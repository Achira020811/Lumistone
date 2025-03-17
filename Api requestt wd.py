import requests
# Define the API URL
url = 'http://127.0.0.1:5000/predict'

# Define the input data
data = {
    'dist': 100.0,
    'x_nad83': 500000.0,
    'y_nad83': 4500000.0,
    'elev': 50.0
}
