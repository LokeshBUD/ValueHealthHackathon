from flask import Flask, request, jsonify
from flask_cors import CORS  # Import CORS
import pandas as pd
import joblib

# Load the saved model
model = joblib.load('burnout_model.pkl')

# Initialize the Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Define an API endpoint for predictions
@app.route('/predict', methods=['POST'])
def predict_burnout():
    data = request.json  # Get the JSON data
    input_data = pd.DataFrame([data])  # Convert to DataFrame for model

    # Predict using the model
    prediction = model.predict(input_data)

    # Print the prediction to the server console
    print(f"Prediction: {prediction[0]}")

    # Respond with the prediction
    response = {'burnout_risk': int(prediction[0])}  # Convert to int for JSON response
    return jsonify(response)

# Run the Flask server
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)  # Listen on all interfaces
