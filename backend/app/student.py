from flask import Blueprint, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import connect

student_blueprint = Blueprint('student', __name__)
CORS(student_blueprint)

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

@student_blueprint.route('/register/student', methods=['POST'])
def register_student():
    data = request.json
    connection = get_db_connection()

    try:
        cursor = get_cursor(connection, dictionary_cursor=True)

        # Check if the email is already taken in Users table
        cursor.execute("SELECT * FROM Users WHERE Email = %s", (data['email'],))
        if cursor.fetchone():
            return jsonify({"message": "Email already exists"}), 409

        # Check if the student ID is already taken in Students table
        cursor.execute("SELECT * FROM Students WHERE StudentID = %s", (data['studentId'],))
        if cursor.fetchone():
            return jsonify({"message": "Student ID already exists"}), 409

        # Insert new user into Users table
        cursor.execute("""
            INSERT INTO Users (Username, Password, Email, UserType)
            VALUES (%s, %s, %s, 'student')
        """, (data['name'], data['password'], data['email']))
        user_id = cursor.lastrowid

        # Insert new student into Students table using the provided StudentID
        cursor.execute("""
            INSERT INTO Students (StudentID, UserID, EnrollmentYear)
            VALUES (%s, %s, %s)
        """, (data['studentId'], user_id, data['enrollmentYear']))

        # Commit the transaction
        connection.commit()
        return jsonify({"message": "Student registered successfully"}), 201

    except Error as e:
        connection.rollback()
        return jsonify({"message": str(e)}), 500

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
