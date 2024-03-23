
from flask import Blueprint, render_template,request, session
import mysql.connector
import connect


student_blueprint = Blueprint('student', __name__)

connection = None  # Global variable to store the connection

def getCursor(dictionary_cursor=False):
    global connection

    if connection is None or not connection.is_connected():
        connection = mysql.connector.connect(
            user=connect.dbuser,
            password=connect.dbpass,
            host=connect.dbhost,
            database=connect.dbname,
            autocommit=True)
        
    cursor = connection.cursor(dictionary=dictionary_cursor)
    return cursor

@student_blueprint.route('/register/student')