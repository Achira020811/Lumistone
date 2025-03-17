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
