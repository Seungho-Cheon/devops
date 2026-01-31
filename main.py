import time
import redis
from flask import Flask

app = Flask(__name__)
# 'redis'라는 이름의 컴퓨터(컨테이너)에 접속한다는 뜻입니다.
cache = redis.Redis(host='redis', port=6379)

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

@app.route('/')
def hello():
    try:
        count = get_hit_count()
        return f'<h1>Hello, Ship VMS! 🚢</h1><p>Visitor Count: <strong>{count}</strong></p>'
    except:
        return '<h1>DB Connection Failed...</h1>'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)