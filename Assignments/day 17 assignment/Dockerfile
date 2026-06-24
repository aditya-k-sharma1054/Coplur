FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirement.txt .
RUN pip install -r requirement.txt
COPY queries.py .
COPY sales.csv .
CMD ["python","queries.py"]