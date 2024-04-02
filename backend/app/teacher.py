from flask import Blueprint, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import connect

teacher_blueprint = Blueprint('teacher', __name__)
CORS(teacher_blueprint)

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

@teacher_blueprint.route('/register/teacher', methods=['POST'])
def register_teacher():
    data = request.json
    connection = get_db_connection()

    try:
        cursor = get_cursor(connection, dictionary_cursor=True)

        # Check if the email is already taken in Users table
        cursor.execute("SELECT * FROM Users WHERE Email = %s", (data['email'],))
        if cursor.fetchone():
            return jsonify({"message": "Email already exists"}), 409

        # Check if the teacher ID is already taken in Teachers table
        cursor.execute("SELECT * FROM Teachers WHERE TeacherID = %s", (data['teacherId'],))
        if cursor.fetchone():
            return jsonify({"message": "Teacher ID already exists"}), 409

        # Insert new user into Users table
        cursor.execute("""
            INSERT INTO Users (Username, Password, Email, UserType)
            VALUES (%s, %s, %s, 'teacher')
        """, (data['name'], data['password'], data['email']))
        user_id = cursor.lastrowid

        # Insert new teacher into Teachers table using the provided TeacherID
        cursor.execute("""
            INSERT INTO Teachers (TeacherID, UserID, Title)
            VALUES (%s, %s, %s)
        """, (data['teacherId'], user_id, data['title'])) # 修改为 data['title']

        # Commit the transaction
        connection.commit()
        return jsonify({"message": "Teacher registered successfully"}), 201

    except Error as e:
        connection.rollback()
        return jsonify({"message": str(e)}), 500

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
