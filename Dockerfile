# [Stage 1] 빌드 단계 (Builder)
# 파이썬 전체 버전(무거운 도구 포함)을 사용해 필요한 패키지를 설치합니다.
FROM python:3.11 as builder

WORKDIR /app

# 가상환경을 만들고 의존성 패키지를 설치합니다.
COPY requirements.txt .
RUN python -m venv /opt/venv
# 가상환경 활성화 후 설치
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt

# [Stage 2] 실행 단계 (Final)
# 실행에 필요한 최소한의 OS(slim)만 가져옵니다.
FROM python:3.11-slim

WORKDIR /app

# 빌드 단계에서 만든 가상환경(패키지들)만 쏙 가져옵니다.
COPY --from=builder /opt/venv /opt/venv

# 환경 변수 설정 (가상환경 경로 인식)
ENV PATH="/opt/venv/bin:$PATH"

# 소스 코드 복사
COPY . .

# Flask 앱 실행 (포트 5000번)
CMD ["python", "main.py"]