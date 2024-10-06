import os
from flask import Flask, request, jsonify
import boto3
import pymysql
from uuid import uuid4





def connect_to_rds():
    try:
        # Get the RDS endpoint
        rds_endpoint = 'junior-junction.cxmq0owia19x.us-east-2.rds.amazonaws.com'

        # Connect to the RDS instance
        connection = pymysql.connect(
            host=rds_endpoint,
            user='junior_junction',
            password='Junction_Junior',
            db='junior-junction-dev',
            connect_timeout=5
        )

        print("Successfully connected to RDS!")
        return connection
    except Exception as e:
        print(f"Error connecting to RDS: {e}")
        return None

def main():
    connection = connect_to_rds()
    if connection:
        try:
            with connection.cursor() as cursor:
                # Example: Execute a simple query
                cursor.execute("SELECT * FROM Restaurants")
                result = cursor.fetchall()
                print(f"Database version: {result}")
                print("Successfully connected to RDS!")
        finally:
            connection.close()
            print("Connection closed.")


app = Flask(__name__)

# Sample data storage (in a real application, this would typically be a database)
# services = {
#     1: {"id": 1, "name": "Service A", "description": "Description for Service A"},
#     2: {"id": 2, "name": "Service B", "description": "Description for Service B"}
# }

# @app.route('/api/getservices/<int:service_id>', methods=['GET'])
# def update_service(service_id):
#     if service_id not in services:
#         return jsonify({"error": "Service not found"}), 404

#     if not request.is_json:
#         return jsonify({
#             "error": "Unsupported Media Type",
#             "message": "Request Content-Type must be 'application/json'"
#         }), 415

#     data = request.json
#     if not data:
#         return jsonify({"error": "No input data provided"}), 400

#     service = services[service_id]
    
#     # Update the service with the provided data
#     if 'name' in data:
#         service['name'] = data['name']
#     if 'description' in data:
#         service['description'] = data['description']

#     return jsonify({
#         "message": "Service updated successfully",
#         "service": service
#     }), 200

@app.route('/api/getservices', methods=['GET'])
def get_all_services():
    # Return
    sql_connection = connect_to_rds()
    if sql_connection:
        try:
            with sql_connection.cursor() as cursor:
                # Example: Execute a simple query
                cursor.execute("SELECT * FROM Restaurants")
                result = [list(row) for row in cursor.fetchall()]
                print(f"Database version: {result}")
                return jsonify(result), 200
        except Exception as e:
            print(f"Error executing query: {e}")
            return jsonify({"error": "An error occurred while fetching services"}), 500
        finally:
            sql_connection.close()
            print("Connection closed")

@app.route('/api/getcontractors', methods=['GET'])
def getcontractors():
    # Return
    sql_connection = connect_to_rds()
    if sql_connection:
        try:
            with sql_connection.cursor() as cursor:
                # Example: Execute a simple query
                cursor.execute("SELECT * FROM Contractors")
                result = [{"Email": record[1], "Portfolio": record[2], "Bio": record[3]} for record in cursor.fetchall()]
                print(f"Database version: {result}")
                return jsonify(result), 200
        except Exception as e:
            print(f"Error executing query: {e}")
            return jsonify({"error": "An error occurred while fetching services"}), 500
        finally:
            sql_connection.close()
            print("Connection closed")
    

@app.route('/', methods=['GET'])
def home():
    return jsonify({"message": "Welcome to the service management API"}), 200

from flask import Flask, request, jsonify
import pymysql

app = Flask(__name__)

# Database connection (replace with your own credentials)
def get_db_connection():
    return pymysql.connect(
        host='junior-junction.cxmq0owia19x.us-east-2.rds.amazonaws.com',
        user='junior_junction',
        password='Junction_Junior',
        db='junior-junction-dev',
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

@app.route('/api/putrestaurant', methods=['POST'])
def put_restaurant():
    # Parse the JSON data from the request body
    data = request.get_json()

    # Extract the parameters from the JSON body
    _id = str(uuid4())
    email = data.get('email')
    link = data.get('link')
    tip_no_tip = data.get('tip_no_tip')
    about = data.get('about')

    # Check if the required fields are provided
    if not email or not link or tip_no_tip is None or not about:
        return jsonify({"error": "Missing required fields"}), 400

    try:
        # Establish a connection to the database
        connection = get_db_connection()
        with connection.cursor() as cursor:
            # Check if the restaurant already exists by the given _id
            cursor.execute("SELECT _id FROM Restaurants WHERE _id = %s", (id,))
            restaurant = cursor.fetchone()

            if restaurant:
                # If the restaurant exists, update its information
                sql_update_query = """
                UPDATE Restaurants
                SET Email = %s, Link = %s, TipNoTip = %s, About = %s
                WHERE _id = %s
                """
                cursor.execute(sql_update_query, (email, link, tip_no_tip, about, id))
                connection.commit()
                return jsonify({"message": "Restaurant updated successfully"}), 200
            else:
                # If the restaurant doesn't exist, insert a new record
                sql_insert_query = """
                INSERT INTO Restaurants (_id, Email, Link, TipNoTip, About)
                VALUES (%s, %s, %s, %s, %s)
                """
                cursor.execute(sql_insert_query, (id, email, link, tip_no_tip, about))
                connection.commit()
                return jsonify({"message": "Restaurant created successfully"}), 201
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({"error" : str(e)})

    

if __name__ == '__main__':
    main()
    port = int(os.environ.get('PORT', 5006))
    app.run(debug=True)
