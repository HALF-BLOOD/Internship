import mysql.connector
from mysql.connector import Error

def create_connection():
    """Creates a connection to the MySQL database."""
    try:
        connection = mysql.connector.connect(
            host="localhost",       
            user="root",            
            password="bloodlust",            
            database="Book_store"   
        )
        if connection.is_connected():
            print("Connection successful!")
        return connection
    except Error as e:
        print(f"Error: '{e}'")
        return None

def fetch_books():
    """Fetches all books from the database."""
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM books;")
            books = cursor.fetchall()
            for book in books:
                print(book)
        except Error as e:
            print(f"Error: '{e}'")
        finally:
            cursor.close()
            connection.close()

# Call the function to test
fetch_books()


