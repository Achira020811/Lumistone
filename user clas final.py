import sqlite3
from datetime import datetime

# Connect to SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect('gem_mining.db')
cursor = conn.cursor()

# Create the Users table if it doesn't exist
cursor.execute('''
CREATE TABLE IF NOT EXISTS Users (
    UserID INTEGER PRIMARY KEY AUTOINCREMENT,
    FullName TEXT NOT NULL,
    Email TEXT NOT NULL UNIQUE,
    PhoneNumber TEXT,
    Role TEXT,
    DateOfRegistration TEXT
)
''')
conn.commit()

class User:
    def __init__(self, full_name, email, phone_number, role):
        self.full_name = full_name
        self.email = email
        self.phone_number = phone_number
        self.role = role
        self.date_of_registration = datetime.now().strftime("%Y-%m-%d")

    def save_to_db(self):
        # Check if the email already exists
        cursor.execute("SELECT Email FROM Users WHERE Email = ?", (self.email,))
        if cursor.fetchone():
            print(f"Error: Email '{self.email}' is already registered.")
        else:
            cursor.execute('''
            INSERT INTO Users (FullName, Email, PhoneNumber, Role, DateOfRegistration)
            VALUES (?, ?, ?, ?, ?)
            ''', (self.full_name, self.email, self.phone_number, self.role, self.date_of_registration))
            conn.commit()
            print("User saved successfully!")

    
    @staticmethod
    def get_all_users():
        cursor.execute("SELECT * FROM Users")
        return cursor.fetchall()

    @staticmethod
    def delete_user(user_id):
        cursor.execute("DELETE FROM Users WHERE UserID = ?", (user_id,))
        conn.commit()
        print(f"User with ID {user_id} deleted successfully!")

    @staticmethod
    def get_user_details():
        print("Please enter user details:")
        full_name = input("Full Name: ")
        email = input("Email: ")
        phone_number = input("Phone Number: ")
        role = input("Role (e.g., Miner, Supervisor, Admin): ")
        return User(full_name, email, phone_number, role)
# Example Usage
if __name__ == "__main__":
    # Get user details from input
    new_user = User.get_user_details()

    # Save the user to the database
    new_user.save_to_db()

    # Fetch and display all users
    print("\nAll Users in Database:")
    users = User.get_all_users()
    for user in users:
        print(user)

    # Delete a user by ID (example)
    # user_id_to_delete = int(input("\nEnter User ID to delete: "))
    # User.delete_user(user_id_to_delete)



