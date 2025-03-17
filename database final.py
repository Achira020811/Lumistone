import sqlite3
from datetime import datetime

# Connect to SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect('gem_mining.db')
cursor = conn.cursor()


# Create tables for User and Scan Results
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

cursor.execute('''
CREATE TABLE IF NOT EXISTS ScanResults (
    ScanID INTEGER PRIMARY KEY AUTOINCREMENT,
    Date TEXT,
    Time TEXT,
    Zone TEXT,
    DepthScanned REAL,
    Result TEXT,
    Remarks TEXT
)
''')
conn.commit()

# User Class
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
        print("User deleted successfully!")

# WaterDetection Class
class WaterDetection:
    def __init__(self, zone, depth_scanned, result, remarks=""):
        self.zone = zone
        self.depth_scanned = depth_scanned
        self.result = result
        self.remarks = remarks
        self.date = datetime.now().strftime("%Y-%m-%d")
        self.time = datetime.now().strftime("%H:%M:%S")

    def save_to_db(self):
        cursor.execute('''
        INSERT INTO ScanResults (Date, Time, Zone, DepthScanned, Result, Remarks)
        VALUES (?, ?, ?, ?, ?, ?)
        ''', (self.date, self.time, self.zone, self.depth_scanned, self.result, self.remarks))
        conn.commit()
        print("Scan result saved successfully!")

    @staticmethod
    def get_all_scans():
        cursor.execute("SELECT * FROM ScanResults")
        return cursor.fetchall()

    @staticmethod
    def delete_scan(scan_id):
        cursor.execute("DELETE FROM ScanResults WHERE ScanID = ?", (scan_id,))
        conn.commit()
        print("Scan result deleted successfully!")

# Example Usage
if __name__ == "__main__":
    # Create a new user
    user1 = User("John Doe", "john.doe@example.com", "+1234567890", "Miner")
    user1.save_to_db()

    # Try to create another user with the same email (should fail)
    user2 = User("Jane Doe", "john.doe@example.com", "+9876543210", "Supervisor")
    user2.save_to_db()

    # Create a new scan result
    scan1 = WaterDetection("Zone A", 10.5, "Not Safe (Water detected at 10.5m)", "High water level, avoid digging.")
    scan1.save_to_db()

    # Fetch all users
    print("All Users:")
    print(User.get_all_users())

    # Fetch all scan results
    print("All Scan Results:")
    print(WaterDetection.get_all_scans())

# Close the database connection
conn.close()



