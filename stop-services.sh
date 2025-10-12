#!/bin/bash
# Script to stop all OctoFit Tracker services

echo "=== Stopping OctoFit Tracker Services ==="

# Stop frontend
echo "Stopping React frontend..."
if pgrep -f "react-scripts start" > /dev/null; then
    pkill -f "react-scripts start"
    echo "✓ Frontend stopped"
else
    echo "Frontend was not running"
fi

# Stop backend
echo "Stopping Django backend..."
if pgrep -f "python.*manage.py runserver" > /dev/null; then
    pkill -f "python.*manage.py runserver"
    echo "✓ Backend stopped"
else
    echo "Backend was not running"
fi

# Stop MongoDB (optional - ask user)
if pgrep -x mongod > /dev/null; then
    read -p "Stop MongoDB as well? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Stopping MongoDB..."
        pkill -x mongod
        echo "✓ MongoDB stopped"
    else
        echo "MongoDB left running"
    fi
else
    echo "MongoDB was not running"
fi

echo ""
echo "=== Services Stopped ==="
echo "To start services again, run: ./start-services.sh"
