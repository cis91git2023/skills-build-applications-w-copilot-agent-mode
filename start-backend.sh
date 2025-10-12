#!/bin/bash
# Script to start the Django backend server

set -e

# Get the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$SCRIPT_DIR/octofit-tracker/backend"

cd "$BACKEND_DIR"

# Check if MongoDB is running
if ! pgrep -x mongod > /dev/null; then
    echo "Error: MongoDB is not running!"
    echo "Please start MongoDB first using: mongod --dbpath /data/db --fork --logpath /tmp/mongod.log"
    exit 1
fi

# Check if virtual environment exists, create if not
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install requirements if needed
if [ ! -f "venv/.requirements_installed" ]; then
    echo "Installing Python dependencies..."
    pip install -r requirements.txt
    touch venv/.requirements_installed
fi

# Run migrations
echo "Running database migrations..."
python manage.py makemigrations || true
python manage.py migrate || true

# Populate database if needed
echo "Populating database with test data..."
python manage.py populate_db || true

# Start Django server
echo "Starting Django backend server on 0.0.0.0:8000..."
python manage.py runserver 0.0.0.0:8000
