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

# Load the pre-trained model and scaler
model = tf.keras.models.load_model('gold_detection_model.h5')  # Replace with your model path
scaler = MinMaxScaler()
scaler.fit(pd.read_csv('training_data.csv')[['Cr_V_ratio', 'Garnet_Ilmenite_ratio', 'Processed_magnetics', 'Gravity_disturbance_Processed', 'Log10Res']])

# API endpoint to predict gold presence
@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get input data from the request
        data = request.json
        x = float(data['x'])
        y = float(data['y'])
        depth = float(data['depth'])

        # Create a DataFrame with the input data
        input_data = pd.DataFrame({
            'X': [x],
            'Y': [y],
            'Baro_alt': [depth],
            'Cr_V_ratio': [0.0],  # Replace with actual values if available
            'Garnet_Ilmenite_ratio': [0.0],  # Replace with actual values if available
            'Processed_magnetics': [0.0],  # Replace with actual values if available
            'Gravity_disturbance_Processed': [0.0],  # Replace with actual values if available
            'Log10Res': [0.0]  # Replace with actual values if available
        })

               # Normalize the input data
        input_normalized = scaler.transform(input_data[['Cr_V_ratio', 'Garnet_Ilmenite_ratio', 'Processed_magnetics', 'Gravity_disturbance_Processed', 'Log10Res']])

        # Predict gold presence
        prediction = (model.predict(input_normalized) > 0.5).astype(int)
        gold_present = bool(prediction[0][0])

        # Save the result to the database
        result = GoldDetectionResult(
            x_coordinate=x,
            y_coordinate=y,
            depth=depth,
            gold_present=gold_present
        )
        db.session.add(result)
        db.session.commit()

        # Return the prediction result
        return jsonify({
            'x': x,
            'y': y,
            'depth': depth,
            'gold_present': gold_present
        }), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
