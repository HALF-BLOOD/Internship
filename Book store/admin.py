from Connector import create_connection

ADMIN_PASSWORD = "admin123"

def verify_admin():
    """Verifies the admin by password."""
    password = input("Enter admin password: ")
    return password == ADMIN_PASSWORD

def view_reviews_and_ratings():
    """Fetch and display reviews and ratings from the `reviews` table."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor()
            # Fetch reviews and ratings from the reviews table
            cursor.execute("""
                SELECT customer_id, book_id, rating, review_text, review_date 
                FROM reviews
            """)
            reviews = cursor.fetchall()
            
            print("\nCustomer Reviews and Ratings:")
            for review in reviews:
                print(f"Customer ID: {review[0]}, Book ID: {review[1]}, Rating: {review[2]}, Review: {review[3]}, Date: {review[4]}")
            print("\n")
        except Exception as e:
            print(f"Error fetching reviews: {e}")
        finally:
            cursor.close()
            connection.close()

def view_sales_analysis():
    """Fetch and display sales analysis from relevant tables."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor()
            # Example query for sales analysis using `orders` and `order_items`
            cursor.execute("""
                SELECT books.title, SUM(order_items.quantity) AS total_quantity_sold, SUM(order_items.final_price) AS total_revenue
                FROM order_items
                JOIN books ON order_items.book_id = books.id
                JOIN orders ON order_items.order_id = orders.id
                WHERE orders.order_status = 'Completed'
                GROUP BY books.title
            """)
            sales = cursor.fetchall()
            
            print("\nSales Analysis:")
            for sale in sales:
                print(f"Book Title: {sale[0]}, Quantity Sold: {sale[1]}, Total Revenue: ${sale[2]}")
            print("\n")
        except Exception as e:
            print(f"Error fetching sales analysis: {e}")
        finally:
            cursor.close()
            connection.close()

def admin_actions():
    """Main menu for admin actions."""
    if not verify_admin():
        print("Incorrect password. Access denied.")
        return

    while True:
        print("\nAdmin Menu:")
        print("1. View Reviews and Ratings")
        print("2. View Sales Analysis")
        print("3. Exit")

        choice = input("Enter your choice: ")

        if choice == "1":
            view_reviews_and_ratings()
        elif choice == "2":
            view_sales_analysis()
        elif choice == "3":
            print("Exiting admin menu.")
            break
        else:
            print("Invalid choice. Please try again.")
