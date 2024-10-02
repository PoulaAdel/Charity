@ECHO OFF

REM Change these to match your project directory and container names
SET PROJECT_DIR=./
SET BACKEND_CONTAINER_NAME=backend
SET FRONTEND_CONTAINER_NAME=frontend

docker-compose up -d

ECHO Waiting for backend to start...
PING 127.0.0.1 -n 5 > NUL

docker ps | FINDSTR /C:"$BACKEND_CONTAINER_NAME" /I | FINDSTR "healthy" > NUL
IF ERRORLEVEL 1 (
  ECHO Backend container is not healthy. Exiting.
  EXIT /B 1
)

docker logs -f "$BACKEND_CONTAINER_NAME"

ECHO Starting Flutter development server...
cd %PROJECT_DIR%/frontend
flutter run
