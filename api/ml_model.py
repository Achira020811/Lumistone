# api/ml_model.py
import sqlite3
import os

DATABASE = 'water_detection.db' # This should match the settings.py

def get_prediction_from_db(x_nad83, y_nad83):
    """Retrieves a prediction from the database based on location coordinates."""
    try:
        # Connect to the SQLite database
        conn = sqlite3.connect(DATABASE)
        cursor = conn.cursor()

        # Query the database for the prediction
        cursor.execute('''
            SELECT predicted_water
            FROM water_predictions
            WHERE X_NAD83UTMz16N = ? AND Y_NAD83UTMz16N = ?
        ''', (x_nad83, y_nad83)) #SQL injection protection

        # Fetch the result
        result = cursor.fetchone()

        if result:
            return result[0]  # Return the predicted_water value
        else:
            return None  # No prediction found for these coordinates

    except Exception as e:
        print(f"Error retrieving prediction from the database: {e}")
        return None

    finally:
        if conn:
            conn.close()