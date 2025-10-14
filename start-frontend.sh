#!/bin/bash
# Script to start the React frontend server

set -e

# Get the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRONTEND_DIR="$SCRIPT_DIR/octofit-tracker/frontend"

cd "$FRONTEND_DIR"

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    echo "Installing frontend dependencies..."
    npm install
fi

# Check if .env file exists and update CODESPACE_NAME if needed
if [ -n "$CODESPACE_NAME" ]; then
    echo "REACT_APP_CODESPACE_NAME=$CODESPACE_NAME" > .env
    echo "Updated .env with CODESPACE_NAME: $CODESPACE_NAME"
elif [ ! -f ".env" ]; then
    echo "Creating .env file for localhost..."
    echo "REACT_APP_CODESPACE_NAME=localhost" > .env
else
    echo "Using existing .env file"
fi

# Start React development server
echo "Starting React frontend server on port 3000..."
PORT=3000 npm start
