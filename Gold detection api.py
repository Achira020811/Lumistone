from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.preprocessing import MinMaxScaler

app = Flask(__name__)

# Database configuration (SQLite for simplicity)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///gold_detection.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Define the database model for storing results
class GoldDetectionResult(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    x_coordinate = db.Column(db.Float, nullable=False)
    y_coordinate = db.Column(db.Float, nullable=False)
    depth = db.Column(db.Float, nullable=False)
    gold_present = db.Column(db.Boolean, nullable=False)

     def __repr__(self):
        return f"GoldDetectionResult(X={self.x_coordinate}, Y={self.y_coordinate}, Depth={self.depth}, GoldPresent={self.gold_present})"

# Create the database tables
with app.app_context():
    db.create_all()
