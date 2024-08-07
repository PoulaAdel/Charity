# Use a Flutter base image
FROM dart:latest

# Set the working directory
WORKDIR /app

# Copy the Flutter project
COPY ./ui .

# Install dependencies
RUN flutter pub get

# Command to run the Flutter application
CMD ["flutter", "run"]