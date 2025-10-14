# OctoFit Tracker - Startup Guide

## Quick Start

### Prerequisites
- MongoDB must be installed and running
- Python 3.x
- Node.js and npm

### Starting All Services

The easiest way to start all services is to use the provided startup script:

```bash
chmod +x start-services.sh start-backend.sh start-frontend.sh
./start-services.sh
```

This will:
1. Start MongoDB (if not already running)
2. Set up Python virtual environment
3. Install backend dependencies
4. Run database migrations
5. Populate database with test data
6. Start Django backend on port 8000
7. Install frontend dependencies
8. Start React frontend on port 3000

### Starting Services Individually

#### Backend Only
```bash
chmod +x start-backend.sh
./start-backend.sh
```

#### Frontend Only
```bash
chmod +x start-frontend.sh
./start-frontend.sh
```

### Manual Setup

#### 1. Start MongoDB
```bash
sudo mkdir -p /data/db
sudo chmod 777 /data/db
mongod --dbpath /data/db --fork --logpath /tmp/mongod.log
```

#### 2. Setup Backend
```bash
cd octofit-tracker/backend

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run migrations
python manage.py makemigrations
python manage.py migrate

# Populate database (optional)
python manage.py populate_db

# Start server
python manage.py runserver 0.0.0.0:8000
```

#### 3. Setup Frontend
```bash
cd octofit-tracker/frontend

# Install dependencies
npm install

# Start development server
npm start
```

## Accessing the Application

### Local Development
- Backend API: http://localhost:8000/api/
- Frontend: http://localhost:3000/

### GitHub Codespaces
The application will automatically detect the Codespace environment and configure URLs accordingly:
- Backend API: https://YOUR-CODESPACE-NAME-8000.app.github.dev/api/
- Frontend: https://YOUR-CODESPACE-NAME-3000.app.github.dev/

## Troubleshooting

### 502 Bad Gateway Error
This usually means the services are not running. Possible causes:

1. **MongoDB not running**
   ```bash
   ps aux | grep mongod
   ```
   If not running, start it with:
   ```bash
   mongod --dbpath /data/db --fork --logpath /tmp/mongod.log
   ```

2. **Backend not running**
   ```bash
   curl http://localhost:8000/api/
   ```
   Check backend logs: `tail -f /tmp/backend.log`

3. **Frontend not running**
   ```bash
   curl http://localhost:3000/
   ```
   Check frontend logs: `tail -f /tmp/frontend.log`

4. **Dependencies not installed**
   - Backend: Check if `octofit-tracker/backend/venv` exists
   - Frontend: Check if `octofit-tracker/frontend/node_modules` exists

### Port Already in Use
If you get "port already in use" errors:

```bash
# Find process using port 8000
lsof -ti:8000 | xargs kill -9

# Find process using port 3000
lsof -ti:3000 | xargs kill -9
```

### CORS Errors
The backend is configured to allow all origins. If you still get CORS errors:
1. Check that the backend is running and accessible
2. Verify the API URL in the frontend components matches your environment
3. Check browser console for specific error messages

### Environment Variables
The frontend needs the `REACT_APP_CODESPACE_NAME` environment variable:
- In Codespaces: Automatically set via `.env` file
- Local development: Set to `localhost` or your domain

To update:
```bash
cd octofit-tracker/frontend
echo "REACT_APP_CODESPACE_NAME=your-codespace-name" > .env
```

## View Logs

```bash
# Backend logs
tail -f /tmp/backend.log

# Frontend logs
tail -f /tmp/frontend.log

# MongoDB logs
tail -f /tmp/mongod.log
```

## Check Service Status

Use the health check script to verify all services are running:

```bash
./check-services.sh
```

This will check:
- MongoDB status and connectivity
- Backend status and API accessibility
- Frontend status and accessibility
- Dependencies installation status

## Stop Services

Use the stop script to gracefully stop all services:

```bash
./stop-services.sh
```

Or manually stop individual services:
```bash
# Stop backend
pkill -f "python manage.py runserver"

# Stop frontend
pkill -f "react-scripts start"

# Stop MongoDB
pkill mongod
```
