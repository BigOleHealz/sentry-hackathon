from flask import Flask, request, jsonify

app = Flask(__name__)

# Sample data storage (in a real application, this would typically be a database)
services = {
    1: {"id": 1, "name": "Service A", "description": "Description for Service A"},
    2: {"id": 2, "name": "Service B", "description": "Description for Service B"}
}

@app.route('/getservices/<int:service_id>', methods=['GET'])
def update_service(service_id):
    if service_id not in services:
        return jsonify({"error": "Service not found"}), 404

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

if __name__ == '__main__':
    app.run(debug=True)