from flask import Flask, Blueprint, request, jsonify, session
import mysql.connector
from mysql.connector import Error
import connect
from werkzeug.security import check_password_hash

user_blueprint = Blueprint('user', __name__)

def get_db_connection():
    return mysql.connector.connect(
        user=connect.dbuser,
        password=connect.dbpass,
        host=connect.dbhost,
        database=connect.dbname,
        autocommit=False
    )

def get_cursor(connection, dictionary_cursor=True):
    return connection.cursor(dictionary=dictionary_cursor)

@user_blueprint.route('/login', methods=['POST'])
def login():
    data = request.json
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        cursor.execute('''
            SELECT u.UserID, u.Username, u.Password, u.Email, u.UserType, 
                   s.StudentID, s.EnrollmentYear, t.TeacherID, t.Title
            FROM Users u
            LEFT JOIN Students s ON u.UserID = s.UserID
            LEFT JOIN Teachers t ON u.UserID = t.UserID
            WHERE u.Email = %s
        ''', (data['email'],))
        user = cursor.fetchone()
        
        if user and check_password_hash(user['Password'], data['password']):
            # Set up the basic user info
            session['user_info'] = {
                "userId": user['UserID'],
                "username": user['Username'],
                "email": user['Email'],
                "userType": user['UserType']
            }
            # Add specific student or teacher info to session
            if user['UserType'] == 'student':
                session['user_info'].update({
                    "studentId": user['StudentID'],
                    "enrollmentYear": user['EnrollmentYear']
                })
            elif user['UserType'] == 'teacher':
                session['user_info'].update({
                    "teacherId": user['TeacherID'],
                    "title": user['Title']
                })
            # Prepare the response object
            user_info = session['user_info'].copy()
            user_info.update({"message": "Login successful"})
            return jsonify(user_info), 200
        else:
            return jsonify({"message": "Invalid email or password"}), 401
    except Error as e:
        return jsonify({"message": str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@user_blueprint.route('/logout')
def logout():
    session.clear()
    return jsonify({"message": "You have been logged out"}), 200


# @user_blueprint.route('/info', methods=['GET'])
# def get_user_info():
#     user_id = session.get('user_id')  # Retrieve userId from session
#     if not user_id:
#         return jsonify({"message": "User not logged in"}), 401

#     connection = get_db_connection()
#     try:
#         cursor = get_cursor(connection, dictionary_cursor=True)
#         cursor.execute("""
#         SELECT Users.Username, Users.Email, Students.EnrollmentYear, Teachers.Title
#         FROM Users
#         LEFT JOIN Students ON Users.UserID = Students.UserID
#         LEFT JOIN Teachers ON Users.UserID = Teachers.UserID
#         WHERE Users.UserID = %s
#         """, (user_id,))
        
#         user_info = cursor.fetchone()
#         if user_info:
#             return jsonify(user_info), 200
#         else:
#             return jsonify({"message": "User not found or not a student/teacher"}), 404
#     except Error as e:
#         return jsonify({"message": str(e)}), 500
#     finally:
#         if connection.is_connected():
#             cursor.close()
#             connection.close()
