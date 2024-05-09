from flask import Flask, Blueprint, request, jsonify, session, current_app, send_from_directory
import mysql.connector
from mysql.connector import Error
import connect
from werkzeug.security import generate_password_hash, check_password_hash
from flask_cors import CORS
from datetime import datetime

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
        
        if user: # and check_password_hash(user['Password'], data['password']):
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

@user_blueprint.route('/update-profile', methods=['POST'])
def update_profile():
    data = request.json
    user_id = data.get('userId')  # 从前端发送的数据中获取用户ID
    if not user_id:
        return jsonify({"message": "User ID not provided"}), 400

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    try:
        # 首先验证用户是否存在
        cursor.execute("SELECT Password FROM Users WHERE UserID = %s", (user_id,))
        user = cursor.fetchone()
        if not user:
            return jsonify({"message": "User not found"}), 404

        # 更新密码，如果提供了新密码和当前密码
        if 'newPassword' in data and 'currentPassword' in data:
            if check_password_hash(user['Password'], data['currentPassword']):
                new_password_hashed = generate_password_hash(data['newPassword'])
                cursor.execute("UPDATE Users SET Password = %s WHERE UserID = %s", (new_password_hashed, user_id))
            else:
                return jsonify({"message": "Current password is incorrect"}), 401

        # 更新用户名和邮箱
        if 'username' in data and 'email' in data:
            cursor.execute("UPDATE Users SET Username = %s, Email = %s WHERE UserID = %s", (data['username'], data['email'], user_id))

        # 提交更改并重新获取用户数据
        connection.commit()
        cursor.execute("SELECT UserID, Username, Email, UserType FROM Users WHERE UserID = %s", (user_id,))
        updated_user = cursor.fetchone()
        return jsonify(updated_user), 200  # 返回更新后的用户信息

    except Exception as e:
        connection.rollback()
        return jsonify({"message": str(e)}), 500
    finally:
        cursor.close()
        connection.close()


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


@user_blueprint.route('/quiz/<int:quiz_id>/<int:student_id>', methods=['GET'])
def get_quiz_details(quiz_id, student_id):
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
            cursor.execute('''
                SELECT * FROM StudentQuizAnswers
                WHERE StudentID = %s AND QuizID = %s and ProgressID = (select Max(ProgressID) from StudentQuizAnswers where StudentID = %s AND QuizID = %s) 
            ''', (student_id, quiz_id, student_id, quiz_id))
            answers = cursor.fetchall()
            cursor.execute('''
                            SELECT count(*) as count FROM StudentQuizProgress
                            WHERE StudentID = %s AND QuizID = %s AND EndTimestamp is NULL
                        ''', (student_id, quiz_id))
            progressing = cursor.fetchone()
            connection.commit()

            response = {
                "progressing": progressing['count'] > 0,
                "quizId": quiz_id,
                "quizName": rows[0]['QuizName'],
                "quizImageUrl": rows[0]['QuizImageURL'],
                "questions": list(questions.values()),
                "answers": answers
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

@user_blueprint.route('/check-progress/<int:quiz_id>', methods=['GET'])
def check_progress(quiz_id):
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection, dictionary_cursor=True)
        cursor.execute('''
            SELECT ProgressID, Score, EndTimestamp FROM StudentQuizProgress
            WHERE StudentID = %s AND QuizID = %s AND EndTimestamp IS NULL
        ''', (request.user.studentId, quiz_id))  # Assuming request.user is available with user's ID
        progress = cursor.fetchone()

        if progress:
            return jsonify({
                "progressId": progress['ProgressID'],
                "score": progress['Score'],
                "endTimestamp": progress['EndTimestamp']
            }), 200
        else:
            return jsonify({"message": "No active progress found"}), 404
    except Error as e:
        print("Database error:", str(e))
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
            WHERE StudentID = %s AND QuizID = %s AND EndTimestamp IS NULL
        ''', (data['studentId'], quiz_id))
        progress = cursor.fetchone()

        # 如果进度存在，则检索当前得分；否则，从0开始
        if progress:
            progress_id = progress['ProgressID']
            current_score = progress.get('Score', 0) 
        else:
            # 如果不存在进度，插入新的进度记录并从0开始
            cursor.execute('''
                INSERT INTO StudentQuizProgress (StudentID, QuizID, Score, StartTimestamp)
                VALUES (%s, %s, 0, NOW())
            ''', (data['studentId'], quiz_id))
            connection.commit()  # Commit the new progress record
            progress_id = cursor.lastrowid
            current_score = 0

        total_score = current_score

        # 插入或更新答案并计算新分数
        for answer in data['answers']:
            selected_option_id = answer['selectedOptionId']  # 直接使用传入的ID或'T'/'F'

            cursor.execute('''
    INSERT INTO StudentQuizAnswers (ProgressID, QuestionID, SelectedOptionId, IsCorrect, StudentId, QuizId)
    VALUES (%s, %s, %s, %s, %s, %s)
    ON DUPLICATE KEY UPDATE SelectedOptionId = VALUES(SelectedOptionId), IsCorrect = VALUES(IsCorrect)
''', (progress_id, answer['questionId'], selected_option_id, answer['isCorrect'], data['studentId'], quiz_id))
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
        return jsonify({"message": "Progress saved successfully", "total_score": current_score}), 200
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

        # Check for an existing, unfinished progress session
        cursor.execute('''
            SELECT ProgressID, Score FROM StudentQuizProgress
            WHERE StudentID = %s AND QuizID = %s AND EndTimestamp IS NULL
        ''', (data['studentId'], quiz_id))
        progress = cursor.fetchone()

        if progress:
            progress_id = progress['ProgressID']
            current_score = progress['Score']
            # Update the end time to close the session
            cursor.execute('''
                UPDATE StudentQuizProgress
                SET EndTimestamp = %s
                WHERE ProgressID = %s
            ''', (datetime.now(), progress_id))
        else:
            return jsonify({"message": "No active progress found to submit"}), 404

        connection.commit()
        return jsonify({"message": "Quiz submitted successfully", "final_score": current_score}), 200

    except Error as e:
        connection.rollback()
        return jsonify({"message": str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@user_blueprint.route('/progress-list', methods=['GET'])
def get_progress_list():
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection)
        # 联接 StudentQuizProgress 和 Quizzes 表来获取所需信息
        cursor.execute('''
            SELECT 
                p.ProgressID,
                q.QuizName,
                p.StartTimestamp
            FROM StudentQuizProgress p
            JOIN Quizzes q ON p.QuizID = q.QuizID
        ''')
        progresses = cursor.fetchall()

        # 格式化返回前端的数据
        progress_list = [{
            'progressId': progress['ProgressID'],
            'quizName': progress['QuizName'],
            'startTimestamp': progress['StartTimestamp'].isoformat() if progress['StartTimestamp'] else None
        } for progress in progresses]

        return jsonify(progress_list), 200

    except Error as e:
        return jsonify({'message': str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@user_blueprint.route('/incorrect-answers/<int:progress_id>', methods=['GET'])
def get_incorrect_answers(progress_id):
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection)
        cursor.execute('''
            SELECT 
                q.QuestionText, 
                a.SelectedOptionID, 
                q.CorrectAnswer,
                p.LatinName, 
                p.CommonName,
                q.QuestionID
            FROM StudentQuizAnswers a
            JOIN Questions q ON a.QuestionID = q.QuestionID
            JOIN PlantNames p ON q.PlantID = p.PlantID
            WHERE a.ProgressID = %s AND a.IsCorrect = 0
        ''', (progress_id,))
        answers = cursor.fetchall()
        
        # Process each answer to check if it's 'T', 'F' or an option ID
        for answer in answers:
            if answer['SelectedOptionID'] == 'T':
                answer['SelectedOption'] = 'True'
            elif answer['SelectedOptionID'] == 'F':
                answer['SelectedOption'] = 'False'
            else:
                # Retrieve the full option details if it's not 'T' or 'F'
                cursor.execute('''
                    SELECT OptionLabel, OptionText
                    FROM QuestionOptions
                    WHERE QuestionID = %s AND OptionID = %s
                ''', (answer['QuestionID'], answer['SelectedOptionID']))
                option_details = cursor.fetchone()
                if option_details:
                    answer['SelectedOption'] = f"{option_details['OptionLabel']}. {option_details['OptionText']}"
                else:
                    answer['SelectedOption'] = 'Unknown Option'

        return jsonify([{
            'questionText': ans['QuestionText'],
            'selectedOption': ans['SelectedOption'],
            'correctAnswer': ans['CorrectAnswer'],
            'latinName': ans['LatinName'],
            'commonName': ans['CommonName']
        } for ans in answers]), 200
    except Error as e:
        return jsonify({'message': str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()


@user_blueprint.route('/delete-progress/<int:progress_id>', methods=['DELETE'])
def delete_progress(progress_id):
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection)
        # Delete associated answers first to maintain foreign key constraints
        cursor.execute('''
            DELETE FROM StudentQuizAnswers WHERE ProgressID = %s
        ''', (progress_id,))
        # Delete the progress record
        cursor.execute('''
            DELETE FROM StudentQuizProgress WHERE ProgressID = %s
        ''', (progress_id,))
        connection.commit()
        return jsonify({'message': 'Progress record deleted successfully'}), 200
    except Error as e:
        connection.rollback()
        return jsonify({'message': str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@user_blueprint.route('/score-rankings', methods=['GET'])
def get_score_rankings():
    connection = get_db_connection()
    try:
        cursor = get_cursor(connection)
        # Include only records where EndTimestamp is not NULL
        cursor.execute('''
            SELECT u.Username, p.Score, 
       TIMESTAMPDIFF(SECOND, p.StartTimestamp, p.EndTimestamp) as TimeTaken
    FROM StudentQuizProgress p
    JOIN Students s ON p.StudentID = s.StudentID
    JOIN Users u ON s.UserID = u.UserID
    WHERE p.EndTimestamp IS NOT NULL
    ORDER BY p.Score DESC, TimeTaken ASC;

        ''')
        rankings = cursor.fetchall()
        print(rankings) 
        return jsonify(rankings), 200
    except Error as e:
        return jsonify({'message': str(e)}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@user_blueprint.route('/edit-quiz/<int:quiz_id>', methods=['GET', 'POST'])
def edit_quiz(quiz_id):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    if request.method == 'GET':
        try:
            cursor.execute('''
                SELECT 
                    q.QuizID, q.QuizName, q.QuizImageURL, q.SemesterID,
                    qi.QuestionID, qi.QuestionText, qi.QuestionType, qi.CorrectAnswer, qi.PlantID,
                    pn.LatinName, pn.CommonName,
                    pi.ImageID, pi.ImageURL
                FROM Quizzes q
                JOIN Questions qi ON q.QuizID = qi.QuizID
                LEFT JOIN PlantNames pn ON qi.PlantID = pn.PlantID
                LEFT JOIN PlantImages pi ON pn.PlantID = pi.PlantID
                WHERE q.QuizID = %s
            ''', (quiz_id,))
            quiz_details = cursor.fetchall()

            for question in quiz_details:
                if question['QuestionType'] == 'true_false':
                    question['options'] = [
                        {"OptionID": "T", "OptionText": "True", "IsCorrect": question['CorrectAnswer'] == "True"},
                        {"OptionID": "F", "OptionText": "False", "IsCorrect": question['CorrectAnswer'] == "False"}
                    ]
                else:
                    cursor.execute('''
                        SELECT OptionID, OptionLabel, OptionText, IsCorrect
                        FROM QuestionOptions
                        WHERE QuestionID = %s
                    ''', (question['QuestionID'],))
                    question['options'] = cursor.fetchall()

            return jsonify(quiz_details), 200
        except Exception as e:
            print(str(e))
            return jsonify({"message": "Failed to retrieve quiz details"}), 500
        finally:
            cursor.close()
            connection.close()

    elif request.method == 'POST':
        data = request.json
        try:
            cursor.execute('''
                UPDATE Quizzes
                SET QuizName = %s, QuizImageURL = %s
                WHERE QuizID = %s
            ''', (data['quizName'], data['quizImageURL'], quiz_id))

            for question in data['questions']:
                cursor.execute('''
                    UPDATE Questions
                    SET QuestionText = %s, CorrectAnswer = %s
                    WHERE QuestionID = %s
                ''', (question['questionText'], question['correctAnswer'], question['questionId']))

                if question['questionType'] == 'true_false':
                    for option in question['options']:
                        cursor.execute('''
                            INSERT INTO QuestionOptions (QuestionID, OptionText, IsCorrect)
                            VALUES (%s, %s, %s)
                            ON DUPLICATE KEY UPDATE
                            OptionText = VALUES(OptionText), IsCorrect = VALUES(IsCorrect)
                        ''', (question['questionId'], option['optionText'], option['isCorrect']))
                else:
                    for option in question['options']:
                        cursor.execute('''
                            UPDATE QuestionOptions
                            SET OptionText = %s, IsCorrect = %s
                            WHERE OptionID = %s
                        ''', (option['optionText'], option['isCorrect'], option['optionId']))

            connection.commit()
            return jsonify({"message": "Quiz updated successfully"}), 200
        except Exception as e:
            connection.rollback()
            print(str(e))
            return jsonify({"message": "Failed to update quiz"}), 500
        finally:
            cursor.close()
            connection.close()
