from flask import Flask
from flask_cors import CORS
from .student import student_blueprint
from .teacher import teacher_blueprint
from .user import user_blueprint 


def create_app():
    app = Flask(__name__)
    
    CORS(app)

    app.register_blueprint(student_blueprint, url_prefix='/student')
    app.register_blueprint(teacher_blueprint, url_prefix='/teacher')
    app.register_blueprint(user_blueprint, url_prefix='/user')  
    return app
