from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "<h1>Hello, DevOps! 🚀</h1><p>This is my first web server running in Docker.</p>"

if __name__ == '__main__':
    # 0.0.0.0은 '누구나 접속 가능'하게 연다는 뜻입니다.
    app.run(host='0.0.0.0', port=5000)