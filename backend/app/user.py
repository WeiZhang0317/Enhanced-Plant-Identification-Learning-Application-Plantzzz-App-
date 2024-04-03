from flask import Flask, Blueprint, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import connect
from werkzeug.security import check_password_hash

user_blueprint = Blueprint('user', __name__)
CORS(user_blueprint)

def get_db_connection():
    return mysql.connector.connect(
        user=connect.dbuser,
        password=connect.dbpass,
        host=connect.dbhost,
        database=connect.dbname,
        autocommit=False  # Turn off autocommit for transaction
    )

def get_cursor(connection, dictionary_cursor=False):
    return connection.cursor(dictionary=dictionary_cursor)

@user_blueprint.route('/login', methods=['POST'])
def login():
    data = request.json
    connection = get_db_connection()
    
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
       
        cursor.execute('SELECT UserID, Password, UserType FROM Users WHERE Email = %s', (data['email'],))
        user = cursor.fetchone()
        
        if user and check_password_hash(user['Password'], data['password']):
          
            return jsonify({"message": "Login successful", "userType": user['UserType']}), 200
        else:
            
            return jsonify({"message": "Invalid email or password"}), 401

    except Error as e:
        return jsonify({"message": str(e)}), 500

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
