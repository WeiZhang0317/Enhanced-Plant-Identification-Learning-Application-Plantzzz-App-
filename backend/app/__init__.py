import logging
from flask import Flask
from .student import student_blueprint

def create_app():
    app = Flask(__name__)
    logging.basicConfig(level=logging.DEBUG)

    app.config.from_pyfile('config.py')

 
    app.register_blueprint(student_blueprint)

    return app