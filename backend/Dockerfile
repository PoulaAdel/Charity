# Use a lightweight Python base image
FROM python:3.9-slim-buster

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt requirements.txt

# Install dependencies
RUN pip install -r requirements.txt

# Copy the rest of the code
COPY . .

# Set environment variables (optional)
ENV DJANGO_SETTINGS_MODULE=charity_management.settings

# Command to run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
