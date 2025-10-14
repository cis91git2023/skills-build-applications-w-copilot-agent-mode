# Quick Reference: Fixing 502 Bad Gateway Error

## Problem
The frontend at `https://YOUR-CODESPACE-NAME-3000.app.github.dev/` shows a 502 Bad Gateway error.

## Root Cause
The application services (MongoDB, Django backend, React frontend) are not running in the Codespace.

## Quick Fix

### Option 1: Start Everything at Once (Recommended)
```bash
./start-services.sh
```

### Option 2: Start Services Individually
```bash
# 1. Start MongoDB
mongod --dbpath /data/db --fork --logpath /tmp/mongod.log

# 2. Start Backend (in one terminal)
./start-backend.sh

# 3. Start Frontend (in another terminal)
./start-frontend.sh
```

## Verify Services are Running
```bash
./check-services.sh
```

## Expected Output
After running the startup scripts, you should see:
- MongoDB running on port 27017
- Django backend at `https://YOUR-CODESPACE-NAME-8000.app.github.dev/api/`
- React frontend at `https://YOUR-CODESPACE-NAME-3000.app.github.dev/`

## Common Issues and Solutions

### Issue: MongoDB fails to start
**Solution:**
```bash
sudo mkdir -p /data/db
sudo chmod 777 /data/db
mongod --dbpath /data/db --fork --logpath /tmp/mongod.log
```

### Issue: Backend fails with import errors
**Solution:**
```bash
cd octofit-tracker/backend
source venv/bin/activate
pip install -r requirements.txt
```

### Issue: Frontend shows blank page or connection errors
**Solution:**
1. Check the `.env` file exists in `octofit-tracker/frontend/`
2. Verify it contains: `REACT_APP_CODESPACE_NAME=YOUR-CODESPACE-NAME`
3. Restart the frontend: `pkill -f "react-scripts" && ./start-frontend.sh`

### Issue: Port already in use
**Solution:**
```bash
# Kill processes on specific ports
lsof -ti:8000 | xargs kill -9  # Backend
lsof -ti:3000 | xargs kill -9  # Frontend
```

## Stopping Services
```bash
./stop-services.sh
```

## Logs Location
- Backend: `/tmp/backend.log`
- Frontend: `/tmp/frontend.log`
- MongoDB: `/tmp/mongod.log`

View in real-time:
```bash
tail -f /tmp/backend.log
```

## API Endpoints to Test

Once services are running, test these endpoints:

```bash
# Backend API Root
curl https://YOUR-CODESPACE-NAME-8000.app.github.dev/api/

# Users endpoint
curl https://YOUR-CODESPACE-NAME-8000.app.github.dev/api/users/

# Activities endpoint
curl https://YOUR-CODESPACE-NAME-8000.app.github.dev/api/activities/

# Workouts endpoint
curl https://YOUR-CODESPACE-NAME-8000.app.github.dev/api/workouts/
```

## For More Help
See the full documentation in [STARTUP_GUIDE.md](./STARTUP_GUIDE.md)
