'''
Author: Veerendra Kakumanu
Description: Sample Flask App in Docker
'''
from flask import Flask
from flask import request
import json
import re

app = Flask(__name__)


@app.route('/', methods=['PUT', 'GET', 'DELETE', 'POST'])
def hello():
    if request.method == 'GET':
        return "HTTP GET Method"
    if request.method == 'DELETE':
        return "HTTP DELETE Method"
    if request.method == 'PUT':
        return "HTTP PUT Method"


if __name__ == '__main__':
    app.run()
