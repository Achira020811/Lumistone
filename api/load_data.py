# api/load_data.py
import pandas as pd
import sqlite3
import os

# Database setup
DATABASE = 'water_detection.db' # This should match the settings.py

def load_data_to_sqlite(csv_file):
    """Loads data from a CSV file into an SQLite database."""
    try:
        # Connect to the SQLite database
        conn = sqlite3.connect(DATABASE)
        cursor = conn.cursor()

        # Read CSV data into a Pandas DataFrame
        df = pd.read_csv(csv_file)

        # Create table (adjust column names and data types if needed)
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS water_predictions (
                X_NAD83UTMz16N REAL NOT NULL,
                Y_NAD83UTMz16N REAL NOT NULL,
                predicted_water INTEGER NOT NULL
            )
        ''')
        # Load csv to the database file
        df.to_sql('water_predictions', conn, if_exists='replace', index=False)
        print('Successfully loaded CSV data to the database.')

    except Exception as e:
        print(f'Error loading data: {e}')

    finally:
        if conn:
            conn.close()

if __name__ == '__main__':
    csv_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'water_detection_results.csv')
    load_data_to_sqlite(csv_file)