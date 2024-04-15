# __init__.py

from flask import Flask
import logging
from flask_cors import CORS
from .student import student_blueprint
from .teacher import teacher_blueprint
from .user import user_blueprint

def create_app():
    # Configure logging
    logging.basicConfig(level=logging.DEBUG)
    
    # Create the Flask application
    app = Flask(__name__, static_folder='../static')
    app.secret_key = 'your_secret_key_here'
    
    # Setup CORS
    CORS(app)

    # Register the blueprints
    app.register_blueprint(student_blueprint, url_prefix='/student')
    app.register_blueprint(teacher_blueprint, url_prefix='/teacher')
    app.register_blueprint(user_blueprint, url_prefix='/user')
 
    
    return app
