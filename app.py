import os
from flask import Flask, request, jsonify

app = Flask(__name__)

# Sample data storage (in a real application, this would typically be a database)
services = {
    1: {"id": 1, "name": "Service A", "description": "Description for Service A"},
    2: {"id": 2, "name": "Service B", "description": "Description for Service B"}
}

@app.route('/api/getservices/<int:service_id>', methods=['GET'])
def update_service(service_id):
    if service_id not in services:
        return jsonify({"error": "Service not found"}), 404

    if not request.is_json:
        return jsonify({
            "error": "Unsupported Media Type",
            "message": "Request Content-Type must be 'application/json'"
        }), 415

    data = request.json
    if not data:
        return jsonify({"error": "No input data provided"}), 400

    service = services[service_id]
    
    # Update the service with the provided data
    if 'name' in data:
        service['name'] = data['name']
    if 'description' in data:
        service['description'] = data['description']

    return jsonify({
        "message": "Service updated successfully",
        "service": service
    }), 200

@app.route('/api/getservices', methods=['GET'])
def get_all_services():
    return jsonify(services), 200

@app.route('/', methods=['GET'])
def home():
    return jsonify({"message": "Welcome to the service management API"}), 200

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)