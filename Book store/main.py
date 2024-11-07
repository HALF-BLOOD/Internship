from Customer import buy_book, give_review, generate_bill
from admin import admin_actions

def main():
    print("Enter 1 if you are a Customer or 2 if you are an Admin")
    choice = int(input("Choice: "))
    
    if choice == 1:
        print("Customer Menu:")
        print("1. Buy Book")
        print("2. Give Review")
        print("3. Generate Bill")
        customer_choice = int(input("Enter choice: "))
        
        if customer_choice == 1:
            book_id = int(input("Enter Book ID: "))
            customer_id = int(input("Enter Customer ID: "))
            quantity = int(input("Enter Quantity: "))
            buy_book(book_id, customer_id, quantity) 
        
        elif customer_choice == 2:
            book_id = int(input("Enter Book ID: "))
            customer_id = int(input("Enter Customer ID: "))
            rating = int(input("Enter Rating (1-5): "))
            review_text = input("Enter Review: ")
            give_review(book_id, customer_id, rating, review_text)
        
        elif customer_choice == 3:
            order_id = int(input("Enter Order ID: "))
            generate_bill(order_id)
        else:
            print("Invalid choice.")
    
    elif choice == 2:
        admin_actions()
    
    else:
        print("Invalid choice.")

if __name__ == "__main__":
    main()
