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

