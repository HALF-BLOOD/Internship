import random
import mysql.connector
from datetime import datetime
from decimal import Decimal

# Sample function to connect to the database
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="bloodlust",
        database="Book_store"
    )

# Sample function to populate `order_items` with calculated prices
def populate_order_items(cursor, num_records=1000):
    cursor.execute("SELECT id FROM orders")
    orders = [order[0] for order in cursor.fetchall()]
    
    cursor.execute("SELECT price_id, book_id, price FROM prices")
    prices = cursor.fetchall()
    
    for _ in range(num_records):
        order_id = random.choice(orders)
        price_entry = random.choice(prices)
        book_id = price_entry[1]
        price_at_sale = price_entry[2]
        
        # Convert random.uniform output to Decimal to ensure compatibility with price_at_sale
        discount_rate = Decimal(random.uniform(0, 0.3))
        discount_applied = round(price_at_sale * discount_rate, 2)
        final_price = price_at_sale - discount_applied
        
        quantity = random.randint(1, 5)
        
        cursor.execute("""
            INSERT INTO order_items (order_id, book_id, quantity, price_at_sale, discount_applied, final_price, created_at, updated_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (order_id, book_id, quantity, price_at_sale, discount_applied, final_price, datetime.now(), datetime.now()))

# Main script to execute
def main():
    db = get_db_connection()
    cursor = db.cursor()
    try:
        populate_order_items(cursor)
        db.commit()
    finally:
        cursor.close()
        db.close()

if __name__ == "__main__":
    main()
