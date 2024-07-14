FROM python:3.9-slim-buster

WORKDIR /code

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "main.py"]