# Dockerfile

# 1. 베이스 이미지 설정 (파이썬 3.11 슬림 버전 사용)
FROM python:3.11-slim

# 2. 컨테이너 내부의 작업 디렉토리 설정
WORKDIR /app

# 3. 라이브러리 목록 파일을 먼저 복사
COPY requirements.txt .

# 4. 라이브러리 설치
RUN pip install --no-cache-dir -r requirements.txt

# 5. 현재 폴더의 모든 소스 코드를 컨테이너의 /app으로 복사
COPY . .

# 6. 컨테이너가 실행될 때 수행할 명령어
CMD ["python", "main.py"]
