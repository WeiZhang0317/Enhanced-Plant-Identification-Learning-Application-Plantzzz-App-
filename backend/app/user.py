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
    print("Received data:", data)  # 打印接收到的全部数据
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        # 检查是否已经存在进度
        cursor.execute('''
            SELECT ProgressID, Score FROM StudentQuizProgress
            WHERE StudentID = %s AND QuizID = %s
        ''', (data['studentId'], quiz_id))
        progress = cursor.fetchone()

        # 如果进度存在，则检索当前得分；否则，从0开始
        if progress:
            progress_id = progress['ProgressID']
            current_score = progress['Score'] or 0
        else:
            # 如果不存在进度，插入新的进度记录并从0开始
            cursor.execute('''
                INSERT INTO StudentQuizProgress (StudentID, QuizID, Score, StartTimestamp)
                VALUES (%s, %s, 0, NOW())
            ''', (data['studentId'], quiz_id))
            progress_id = cursor.lastrowid
            current_score = 0

        total_score = current_score

        # 插入或更新答案并计算新分数
        for answer in data['answers']:
            selected_option_id = answer['selectedOptionId']  # 直接使用传入的ID或'T'/'F'

            cursor.execute('''
                INSERT INTO StudentQuizAnswers (ProgressID, QuestionID, SelectedOptionId, IsCorrect)
                VALUES (%s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE SelectedOptionId = VALUES(SelectedOptionId), IsCorrect = VALUES(IsCorrect)
            ''', (progress_id, answer['questionId'], selected_option_id, answer['isCorrect']))

            # 仅在答案正确时更新分数
            if answer['isCorrect']:
                total_score += 1

        # 更新 StudentQuizProgress 表中的总分
        cursor.execute('''
            UPDATE StudentQuizProgress
            SET Score = %s
            WHERE ProgressID = %s
        ''', (total_score, progress_id))

        connection.commit()
        return jsonify({"message": "Progress saved successfully", "total_score": total_score}), 200
    except Error as e:
        connection.rollback()
        print("Database error:", str(e))
        return jsonify({"message": str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
        print("Database connection closed.")


@user_blueprint.route('/submit-quiz/<int:quiz_id>', methods=['POST'])
def submit_quiz(quiz_id):
    data = request.json
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        
        # 检查是否已经存在进度
        cursor.execute('''
            SELECT ProgressID, Score FROM StudentQuizProgress
            WHERE StudentID = %s AND QuizID = %s
        ''', (data['studentId'], quiz_id))
        progress = cursor.fetchone()

        if not progress:
            return jsonify({"message": "No existing progress found"}), 404

        progress_id = progress['ProgressID']
        current_score = progress['Score']  # 分数直接从数据库获取，不进行重新计算

        # 只更新结束时间
        cursor.execute('''
            UPDATE StudentQuizProgress
            SET EndTimestamp = NOW()
            WHERE ProgressID = %s
        ''', (progress_id,))

        connection.commit()
        return jsonify({"message": "Quiz submitted successfully", "final_score": current_score}), 200

    except Error as e:
        connection.rollback()
        return jsonify({"message": str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
