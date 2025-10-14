#!/bin/bash
# Script to start all OctoFit Tracker services

set -e

echo "=== Starting OctoFit Tracker Services ==="

# Get the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if MongoDB is running
if ! pgrep -x mongod > /dev/null; then
    echo "Starting MongoDB..."
    sudo mkdir -p /data/db
    sudo chmod 777 /data/db
    mongod --dbpath /data/db --fork --logpath /tmp/mongod.log
    sleep 2
    
    # Verify MongoDB started
    if ! pgrep -x mongod > /dev/null; then
        echo "Error: Failed to start MongoDB"
        cat /tmp/mongod.log
        exit 1
    fi
    echo "MongoDB started successfully"
else
    echo "MongoDB is already running"
fi

# Start backend in background
echo "Starting Django backend..."
"$SCRIPT_DIR/start-backend.sh" > /tmp/backend.log 2>&1 &
BACKEND_PID=$!
echo "Backend started with PID $BACKEND_PID"

# Wait for backend to be ready
echo "Waiting for backend to be ready..."
for i in {1..30}; do
    if curl -s http://localhost:8000/api/ > /dev/null 2>&1; then
        echo "Backend is ready!"
        break
    fi
    sleep 1
done

# Start frontend in background
echo "Starting React frontend..."
"$SCRIPT_DIR/start-frontend.sh" > /tmp/frontend.log 2>&1 &
FRONTEND_PID=$!
echo "Frontend started with PID $FRONTEND_PID"

echo ""
echo "=== Services Started ==="
echo "Backend PID: $BACKEND_PID"
echo "Frontend PID: $FRONTEND_PID"
echo ""
echo "Backend log: /tmp/backend.log"
echo "Frontend log: /tmp/frontend.log"
echo "MongoDB log: /tmp/mongod.log"
echo ""
echo "Backend URL: http://localhost:8000"
echo "Frontend URL: http://localhost:3000"
echo ""
if [ -n "$CODESPACE_NAME" ]; then
    echo "Codespace Backend URL: https://$CODESPACE_NAME-8000.app.github.dev"
    echo "Codespace Frontend URL: https://$CODESPACE_NAME-3000.app.github.dev"
fi
echo ""
echo "To view logs:"
echo "  tail -f /tmp/backend.log"
echo "  tail -f /tmp/frontend.log"
echo ""
echo "To stop services:"
echo "  kill $BACKEND_PID $FRONTEND_PID"
