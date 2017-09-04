import sys
from flask import Flask

app = Flask(__name__)


@app.route('/')
def index():
    return f'Flask and Docker Test {sys.version_info}'


if __name__ == '__main__':
    app.run(port=8000)
