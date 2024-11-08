from Connector import create_connection

def buy_book(book_id, customer_id, quantity):
    conn = create_connection()
    if conn:
        cursor = conn.cursor()
        try:
            # Check if the book exists and fetch price and discount
            cursor.execute("SELECT price, discount FROM books JOIN prices ON books.ID = prices.book_id WHERE books.ID = %s", (book_id,))
            result = cursor.fetchone()
            
            if result:
                price, discount = result
                final_price = price * (1 - (discount / 100))
                
                # Insert into orders
                cursor.execute("INSERT INTO orders (customer_id, book_id, quantity, final_price) VALUES (%s, %s, %s, %s)", (customer_id, book_id, quantity, final_price * quantity))
                conn.commit()
                print(f"Book purchased successfully! Total Price: {final_price * quantity}")
            else:
                print("Book not found!")
        except Exception as e:
            print(f"Error: {e}")
        finally:
            cursor.close()
            conn.close()

def give_review(book_id, customer_id, rating, review_text):
    conn = create_connection()
    if conn:
        cursor = conn.cursor()
        try:
            # Insert review
            cursor.execute("INSERT INTO reviews (book_id, customer_id, rating, review_text) VALUES (%s, %s, %s, %s)", (book_id, customer_id, rating, review_text))
            conn.commit()
            print("Review submitted!")
        except Exception as e:
            print(f"Error: {e}")
        finally:
            cursor.close()
            conn.close()

# customer billing 
def generate_bill(order_id):
    conn = create_connection()
    if conn:
        cursor = conn.cursor()
        try:
            # Fetch the order details including title, price, and discount percentage
            cursor.execute("""
                SELECT books.title, prices.price, prices.discount_price
                FROM order_items 
                JOIN books ON order_items.book_id = books.id
                JOIN prices ON books.id = prices.book_id
                WHERE order_items.order_id = %s
            """, (order_id,))
            result = cursor.fetchall()

            # Calculate the total price considering the discount
            total = sum(price * (1 - (discount / 100)) for title, price, discount in result)

            print(f"Order #{order_id} Total: ${total:.2f}")
            print("\nOrder Details:")
            for title, price, discount in result:
                discounted_price = price * (1 - (discount / 100))
                print(f"Book: {title}, Original Price: ${price:.2f}, Discounted Price: ${discounted_price:.2f}")
        except Exception as e:
            print(f"Error: {e}")
        finally:
            cursor.close()
            conn.close()
            
# buy_book.py
def buy_book(book_id, customer_id, quantity):
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Fetch the current price and discount price for the book
            cursor.execute("""
                SELECT price, discount_price 
                FROM prices 
                WHERE book_id = %s 
                AND CURDATE() BETWEEN effective_date AND expiration_date
                LIMIT 1;
            """, (book_id,))
            price_info = cursor.fetchone()
            
            if not price_info:
                print("No active price found for the selected book.")
                return

            current_price = price_info['price']
            discount_price = price_info['discount_price']
            final_price = discount_price if discount_price else current_price
            
            if final_price == 0:
                print("Error: Price cannot be zero.")
                return

            # Calculate the total price based on quantity
            total_price = final_price * quantity
            
            # Insert into orders and order_items tables
            cursor.execute("""
                INSERT INTO orders (customer_id, total_amount, order_date) 
                VALUES (%s, %s, NOW())
            """, (customer_id, total_price))
            order_id = cursor.lastrowid
            
            cursor.execute("""
                INSERT INTO order_items (order_id, book_id, quantity, price_at_sale, discount_applied, final_price, created_at)
                VALUES (%s, %s, %s, %s, %s, %s, NOW())
            """, (order_id, book_id, quantity, current_price, (current_price - final_price), final_price))
            
            connection.commit()
            print(f"Book purchased successfully! Order ID: {order_id}")

        except Exception as e:
            print(f"Error: {e}")
            connection.rollback()
        finally:
            cursor.close()
            connection.close()


def view_reviews_and_ratings():
    """Fetch and display reviews and ratings."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor()
            # Adjusted query to match actual column names in `reviews` table
            cursor.execute("SELECT customer_id, book_id, rating, review_text FROM reviews")  # Check that 'review_text' matches the column name
            reviews = cursor.fetchall()
            
            print("\nCustomer Reviews and Ratings:")
            for review in reviews:
                print(f"Customer ID: {review[0]}, Book ID: {review[1]}, Rating: {review[2]}, Review: {review[3]}")
            print("\n")
        except Exception as e:
            print(f"Error fetching reviews: {e}")
        finally:
            cursor.close()
            connection.close()
