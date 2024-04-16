from flask import Flask, Blueprint, request, jsonify, session, current_app, send_from_directory
import mysql.connector
from mysql.connector import Error
import connect
from werkzeug.security import check_password_hash
from flask_cors import CORS

user_blueprint = Blueprint('user', __name__)
CORS(user_blueprint)

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


@user_blueprint.route('/all-quizzes', methods=['GET'])
def get_all_quizzes():
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        cursor.execute('''
            SELECT QuizID, QuizName, QuizImageURL 
            FROM Quizzes
        ''')
        quizzes = cursor.fetchall()
        return jsonify(quizzes), 200
    except Error as e:
        return jsonify({"message": str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()


@user_blueprint.route('/quiz/<int:quiz_id>', methods=['GET'])
def get_quiz_details(quiz_id):
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        cursor.execute('''
            SELECT 
                q.QuizID, q.QuizName, q.QuizImageURL, q.SemesterID, 
                qi.QuestionID, qi.QuestionText, qi.QuestionType, qi.CorrectAnswer, 
                p.PlantID, p.LatinName, p.CommonName, pi.ImageURL,
                qo.OptionID, qo.OptionLabel, qo.OptionText, qo.IsCorrect
            FROM Quizzes q
            JOIN Questions qi ON qi.QuizID = q.QuizID
            LEFT JOIN PlantNames p ON qi.PlantID = p.PlantID
            LEFT JOIN PlantImages pi ON p.PlantID = pi.PlantID
            LEFT JOIN QuestionOptions qo ON qi.QuestionID = qo.QuestionID
            WHERE q.QuizID = %s
        ''', (quiz_id,))
        rows = cursor.fetchall()

        if rows:
            questions = {}
            for row in rows:
                if row['QuestionID'] not in questions:
                    questions[row['QuestionID']] = {
                        "questionId": row['QuestionID'],
                        "questionText": row['QuestionText'],
                        "questionType": row['QuestionType'],
                        "correctAnswer": row['CorrectAnswer'],
                        "plantId": row['PlantID'],
                        "latinName": row['LatinName'],
                        "commonName": row['CommonName'],
                        "imageUrl": row['ImageURL'],
                        "options": []
                    }
                if row['OptionID']:  # Ensure there is an option before adding it
                    questions[row['QuestionID']]['options'].append({
                        "optionId": row['OptionID'],
                        "optionLabel": row['OptionLabel'],
                        "optionText": row['OptionText'],
                        "isCorrect": row['IsCorrect']
                    })
                    
            response = {
                "quizId": quiz_id,
                "quizName": rows[0]['QuizName'],
                "quizImageUrl": rows[0]['QuizImageURL'],
                "questions": list(questions.values())
            }
            return jsonify(response), 200
        else:
            return jsonify({"message": "Quiz not found"}), 404
    except Error as e:
        return jsonify({"message": str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()


@user_blueprint.route('/save-progress/<int:quiz_id>', methods=['POST'])
def save_progress(quiz_id):
    data = request.json
    print("Received data:", data) 
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        # Check if progress already exists
        cursor.execute('''
            SELECT ProgressID FROM StudentQuizProgress
            WHERE StudentID = %s AND QuizID = %s
        ''', (data['studentId'], quiz_id))
        progress = cursor.fetchone()

        if progress:
            progress_id = progress['ProgressID']
            # Update existing progress without setting EndTimestamp
            cursor.execute('''
                UPDATE StudentQuizProgress
                SET Score = %s
                WHERE ProgressID = %s
            ''', (data['score'], progress_id))
        else:
            # Insert new progress without EndTimestamp
            cursor.execute('''
                INSERT INTO StudentQuizProgress (StudentID, QuizID, Score, StartTimestamp)
                VALUES (%s, %s, %s, NOW())
            ''', (data['studentId'], quiz_id, data['score']))
            progress_id = cursor.lastrowid
        
        # Insert or update answers
        for answer in data['answers']:
            cursor.execute('''
                INSERT INTO StudentQuizAnswers (ProgressID, QuestionID, SelectedOptionID, IsCorrect)
                VALUES (%s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE SelectedOptionID = VALUES(SelectedOptionID), IsCorrect = VALUES(IsCorrect)
            ''', (progress_id, answer['questionId'], answer['selectedOptionId'], answer['isCorrect']))

        connection.commit()
        return jsonify({"message": "Progress saved successfully"}), 200
    except Error as e:
        connection.rollback()
        return jsonify({"message": str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()