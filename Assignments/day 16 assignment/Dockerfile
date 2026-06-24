FROM python:3.11-slim
RUN apt-get update && \
    apt-get install -y default-jdk wget && \
    apt-get clean
ENV JAVA_HOME=/usr
ENV PATH=$JAVA_HOME/bin:$PATH
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY employees.csv .
COPY queries.py .
CMD ["python", "queries.py"]