from flask import Blueprint, request, jsonify, session
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
from werkzeug.security import generate_password_hash
import connect
import logging


logging.basicConfig(level=logging.DEBUG)

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

        cursor.execute("SELECT * FROM Users WHERE Email = %s", (data['email'],))
        if cursor.fetchone():
            return jsonify({"message": "Email already exists"}), 409

     
        cursor.execute("SELECT * FROM Students WHERE StudentID = %s", (data['studentId'],))
        if cursor.fetchone():
            return jsonify({"message": "Student ID already exists"}), 409

       
        hashed_password = generate_password_hash(data['password'], method='pbkdf2:sha256')

       
        cursor.execute("""
            INSERT INTO Users (Username, Password, Email, UserType)
            VALUES (%s, %s, %s, 'student')
        """, (data['name'], hashed_password, data['email']))
        user_id = cursor.lastrowid

 
        cursor.execute("""
            INSERT INTO Students (StudentID, UserID, EnrollmentYear)
            VALUES (%s, %s, %s)
        """, (data['studentId'], user_id, data['enrollmentYear']))

       
        connection.commit()
        return jsonify({"message": "Student registered successfully"}), 201

    except Error as e:
        connection.rollback()  
        return jsonify({"message": str(e)}), 500

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@student_blueprint.route('/ongoing-quizzes', methods=['GET'])
def get_ongoing_quizzes():
    logging.debug("Fetching ongoing quizzes...")  # 使用logging替代print
    student_id = session.get('user_info', {}).get('studentId')
    if not student_id:
        logging.warning("No student ID in session")  # 使用logging
        return jsonify({"error": "Student ID not found in session"}), 400

    try:
        connection = get_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")
        
        with connection.cursor(dictionary=True) as cursor:
            logging.info(f"Executing query to fetch ongoing quizzes for student ID: {student_id}")
            query = """
                SELECT q.QuizID, q.QuizName, q.QuizImageURL
                FROM Quizzes q
                LEFT JOIN StudentQuizProgress p ON q.QuizID = p.QuizID AND p.StudentID = %s AND p.EndTimestamp IS NULL
            """
            cursor.execute(query, (student_id,))
            quizzes = cursor.fetchall()

            ongoing_quizzes = [quiz for quiz in quizzes if quiz['StudentID'] is not None]
            logging.info(f"Number of ongoing quizzes: {len(ongoing_quizzes)}")
            return jsonify(ongoing_quizzes), 200
    except Error as e:
        logging.error(f"Database error: {e}")
        return jsonify({"error": str(e)}), 500
    except Exception as e:
        logging.error(f"An error occurred: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        if connection and connection.is_connected():
            connection.close()
