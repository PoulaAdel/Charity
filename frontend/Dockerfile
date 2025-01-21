# Use a Flutter base image
FROM dart:latest

# Set the working directory
WORKDIR /app

# Copy the Flutter project
COPY ./ui .

# Install dependencies
RUN flutter pub get

# Expose port 5000
EXPOSE 5000

# Command to run the Flutter web application on port 5000
CMD ["flutter", "run", "-d", "web-server", "--web-port", "5000"]