from flask import Blueprint, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
from werkzeug.security import generate_password_hash
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

@student_blueprint.route('/student/info', methods=['GET'])
def get_student_info():
    student_id = request.args.get('studentId')
    connection = get_db_connection()
    
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        
        cursor.execute("""
        SELECT s.StudentID, u.Username, s.EnrollmentYear, u.Email
        FROM Students s
        JOIN Users u ON s.UserID = u.UserID
        WHERE s.StudentID = %s
        """, (student_id,))
        
        student_info = cursor.fetchone()
        if student_info:
            return jsonify(student_info), 200
        else:
            return jsonify({"message": "Student not found"}), 404
    
    except Error as e:
        return jsonify({"message": str(e)}), 500
    
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@student_blueprint.route('/quizzes/ongoing', methods=['GET'])
def get_ongoing_quizzes():
    student_id = request.args.get('studentId')
    connection = get_db_connection()
    
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        
        cursor.execute("""
        SELECT q.QuizID, q.QuizName
        FROM Quizzes q
        JOIN StudentQuizProgress sqp ON q.QuizID = sqp.QuizID
        WHERE sqp.StudentID = %s AND sqp.EndTimestamp IS NULL
        """, (student_id,))
        
        quizzes = cursor.fetchall()
        return jsonify(quizzes), 200
    
    except Error as e:
        return jsonify({"message": str(e)}), 500
    
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@student_blueprint.route('/quizzes/completed', methods=['GET'])
def get_completed_quizzes():
    student_id = request.args.get('studentId')
    connection = get_db_connection()
    
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        
        cursor.execute("""
        SELECT q.QuizID, q.QuizName, sqp.Score
        FROM Quizzes q
        JOIN StudentQuizProgress sqp ON q.QuizID = sqp.QuizID
        WHERE sqp.StudentID = %s AND sqp.EndTimestamp IS NOT NULL
        """, (student_id,))
        
        quizzes = cursor.fetchall()
        return jsonify(quizzes), 200
    
    except Error as e:
        return jsonify({"message": str(e)}), 500
    
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
