#!/bin/bash
# Script to check the health status of all OctoFit Tracker services

echo "=== OctoFit Tracker Service Health Check ==="
echo ""

# Check MongoDB
echo "Checking MongoDB..."
if pgrep -x mongod > /dev/null; then
    echo "✓ MongoDB is running"
    if command -v mongosh > /dev/null 2>&1; then
        if mongosh --quiet --eval 'db.runCommand({ping:1})' > /dev/null 2>&1; then
            echo "✓ MongoDB is responding"
        else
            echo "✗ MongoDB is not responding"
        fi
    fi
else
    echo "✗ MongoDB is not running"
    echo "  Start with: mongod --dbpath /data/db --fork --logpath /tmp/mongod.log"
fi
echo ""

# Check Backend
echo "Checking Backend (Django)..."
if pgrep -f "python.*manage.py runserver" > /dev/null; then
    echo "✓ Backend process is running"
    if curl -s http://localhost:8000/api/ > /dev/null 2>&1; then
        echo "✓ Backend is responding at http://localhost:8000/api/"
        
        # Check if we're in a Codespace
        if [ -n "$CODESPACE_NAME" ]; then
            BACKEND_URL="https://$CODESPACE_NAME-8000.app.github.dev/api/"
            if curl -s "$BACKEND_URL" > /dev/null 2>&1; then
                echo "✓ Backend is accessible at $BACKEND_URL"
            else
                echo "✗ Backend is not accessible at $BACKEND_URL"
            fi
        fi
    else
        echo "✗ Backend is not responding"
    fi
else
    echo "✗ Backend is not running"
    echo "  Start with: ./start-backend.sh"
fi
echo ""

# Check Frontend
echo "Checking Frontend (React)..."
if pgrep -f "react-scripts start" > /dev/null; then
    echo "✓ Frontend process is running"
    if curl -s http://localhost:3000/ > /dev/null 2>&1; then
        echo "✓ Frontend is responding at http://localhost:3000/"
        
        # Check if we're in a Codespace
        if [ -n "$CODESPACE_NAME" ]; then
            FRONTEND_URL="https://$CODESPACE_NAME-3000.app.github.dev/"
            echo "  Frontend should be accessible at $FRONTEND_URL"
        fi
    else
        echo "⚠ Frontend process is running but not responding yet (may still be starting)"
    fi
else
    echo "✗ Frontend is not running"
    echo "  Start with: ./start-frontend.sh"
fi
echo ""

# Check for dependencies
echo "Checking Dependencies..."
if [ -d "octofit-tracker/backend/venv" ]; then
    echo "✓ Backend virtual environment exists"
else
    echo "✗ Backend virtual environment not found"
    echo "  Create with: cd octofit-tracker/backend && python3 -m venv venv"
fi

if [ -d "octofit-tracker/frontend/node_modules" ]; then
    echo "✓ Frontend node_modules exists"
else
    echo "✗ Frontend node_modules not found"
    echo "  Install with: cd octofit-tracker/frontend && npm install"
fi
echo ""

# Summary
echo "=== Summary ==="
if pgrep -x mongod > /dev/null && \
   pgrep -f "python.*manage.py runserver" > /dev/null && \
   pgrep -f "react-scripts start" > /dev/null; then
    echo "✓ All services are running!"
    echo ""
    echo "Access the application:"
    echo "  Local: http://localhost:3000/"
    if [ -n "$CODESPACE_NAME" ]; then
        echo "  Codespace: https://$CODESPACE_NAME-3000.app.github.dev/"
    fi
else
    echo "⚠ Some services are not running"
    echo "Run ./start-services.sh to start all services"
fi
