from flask import Flask, Blueprint, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import connect
from werkzeug.security import check_password_hash
from flask import session

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

def get_cursor(connection, dictionary_cursor=True):
    return connection.cursor(dictionary=dictionary_cursor)


@user_blueprint.route('/login', methods=['POST'])
def login():
    data = request.json
    connection = get_db_connection()
    
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        cursor.execute('''
            SELECT u.UserID, u.Password, u.UserType, s.StudentID
            FROM Users u
            LEFT JOIN Students s ON u.UserID = s.UserID
            WHERE u.Email = %s
        ''', (data['email'],))
        user = cursor.fetchone()
        
        if user and check_password_hash(user['Password'], data['password']):
            # 存储 session 中的 UserID
            session['user_id'] = user['UserID']
            session['user_type'] = user['UserType']
            
            # 额外添加的逻辑: 如果用户是学生，确保返回 StudentID 而不是 UserID
            student_id = None
            if user['UserType'] == 'student':
                student_id = user['StudentID']
            
            return jsonify({
                "message": "Login successful", 
                "userType": user['UserType'], 
                "userId": user['UserID'],
                "studentId": student_id
            }), 200
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
    # Clear the user session
    session.clear()
    return jsonify({"message": "You have been logged out"}), 200
