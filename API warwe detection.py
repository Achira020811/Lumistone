from flask import Flask, request, jsonify
import tensorflow as tf
import pandas as pd
import numpy as np
import sqlite3
from sklearn.preprocessing import StandardScaler

# Initialize Flask app
app = Flask(__name__)

# Load the trained ANN model
model = tf.keras.models.load_model('water_detection_model.h5')  # Save your model using model.save()

# Database setup
DATABASE = 'water_detection.db'

# Load mean and std for normalization (from training)
mean = np.array([...])  # Replace with your training data mean
std = np.array([...])   # Replace with your training data std

def create_table():
    """Create a table to store predictions if it doesn't exist."""
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS predictions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            dist REAL NOT NULL,
            x_nad83 REAL NOT NULL,
            y_nad83 REAL NOT NULL,
            elev REAL NOT NULL,
            prediction INTEGER NOT NULL
        )
    ''')
    conn.commit()
    conn.close()

def save_prediction(dist, x_nad83, y_nad83, elev, prediction):
    """Save the prediction to the database."""
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO predictions (dist, x_nad83, y_nad83, elev, prediction)
        VALUES (?, ?, ?, ?, ?)
    ''', (dist, x_nad83, y_nad83, elev, prediction))
    conn.commit()
    conn.close()

# Define the API endpoint
@app.route('/predict', methods=['POST'])
def predict():
    # Get user input
    data = request.json
    dist = float(data['dist'])
    x_nad83 = float(data['x_nad83'])
    y_nad83 = float(data['y_nad83'])
    elev = float(data['elev'])


