import mysql.connector
from faker import Faker
import random
from datetime import datetime

# Establish a connection to the MySQL database
def create_connection():
    return mysql.connector.connect(
        host="localhost",       
        user="root",            
        password="bloodlust",            
        database="Book_store"
    )

# Generate and insert dummy data
def insert_dummy_data():
    conn = create_connection()
    if conn:
        cursor = conn.cursor()
        fake = Faker()
        
        try:
            # Insert data for customers
            customer_ids = []
            for _ in range(100):
                customer_name = fake.name()
                email = fake.email()
                phone = fake.phone_number()
                primary_address = fake.address()
                billing_address = fake.address()
                cursor.execute("""
                    INSERT INTO customers (customer_name, email, phone, primary_address, billing_address, created_at, updated_at)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """, (customer_name, email, phone, primary_address, billing_address, datetime.now(), datetime.now()))
                customer_ids.append(cursor.lastrowid)

            # Insert data for authors
            author_ids = []
            for _ in range(50):
                author_name = fake.name()
                biography = fake.text(max_nb_chars=200)
                cursor.execute("""
                    INSERT INTO authors (author_name, biography, created_at, updated_at)
                    VALUES (%s, %s, %s, %s)
                """, (author_name, biography, datetime.now(), datetime.now()))
                author_ids.append(cursor.lastrowid)

            # Insert data for books and capture the inserted book IDs
            book_ids = []
            for _ in range(200):
                title = fake.sentence(nb_words=3)
                publish_date = fake.date_between(start_date="-10y", end_date="today")
                description = fake.text(max_nb_chars=200)
                cursor.execute("""
                    INSERT INTO books (title, publish_date, description, created_at, updated_at)
                    VALUES (%s, %s, %s, %s, %s)
                """, (title, publish_date, description, datetime.now(), datetime.now()))
                book_ids.append(cursor.lastrowid)

            # Insert data for prices, using valid book_ids from the books table
            for book_id in book_ids:
                price = round(random.uniform(5.0, 50.0), 2)
                discount_price = random.choice([0, 10, 15, 20, 25])
                cursor.execute("""
                    INSERT INTO prices (book_id, price, discount_price, created_at, updated_at)
                    VALUES (%s, %s, %s, %s, %s)
                """, (book_id, price, discount_price, datetime.now(), datetime.now()))

            # Insert data for orders, using valid customer_ids from the customers table
            order_ids = []
            for _ in range(500):
                customer_id = random.choice(customer_ids)
                order_date = fake.date_time_between(start_date="-1y", end_date="now")
                order_status = random.choice(["Pending", "Completed", "Canceled"])
                cursor.execute("""
                    INSERT INTO orders (customer_id, order_date, order_status, created_at, updated_at)
                    VALUES (%s, %s, %s, %s, %s)
                """, (customer_id, order_date, order_status, datetime.now(), datetime.now()))
                order_ids.append(cursor.lastrowid)

            # Insert data for order items, using valid book_ids and order_ids
            for order_id in order_ids:
                for _ in range(random.randint(1, 5)):  # Each order has 1-5 items
                    book_id = random.choice(book_ids)  # Ensuring a valid book_id
                    quantity = random.randint(1, 3)
                    cursor.execute("""
                        INSERT INTO order_items (order_id, book_id, quantity, created_at, updated_at)
                        VALUES (%s, %s, %s, %s, %s)
                    """, (order_id, book_id, quantity, datetime.now(), datetime.now()))

            # Insert data for reviews, using valid book_ids and customer_ids
            for _ in range(300):
                book_id = random.choice(book_ids)
                customer_id = random.choice(customer_ids)
                rating = random.randint(1, 5)
                review_text = fake.sentence(nb_words=10)
                review_date = fake.date_time_between(start_date="-1y", end_date="now")
                cursor.execute("""
                    INSERT INTO reviews (book_id, customer_id, rating, review_text, review_date, created_at, updated_at)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """, (book_id, customer_id, rating, review_text, review_date, datetime.now(), datetime.now()))

            conn.commit()
            print("Dummy data inserted successfully!")
        
        except mysql.connector.Error as e:
            conn.rollback()
            print(f"Error: {e}")
        
        finally:
            cursor.close()
            conn.close()




if __name__ == "__main__":
    insert_dummy_data()
