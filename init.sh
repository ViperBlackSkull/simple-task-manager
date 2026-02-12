#!/bin/bash

# Simple Task Manager - Development Environment Setup

set -e

echo "Setting up Simple Task Manager development environment..."

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed"
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install dependencies
if [ -f "requirements.txt" ]; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
else
    echo "No requirements.txt found, skipping dependency installation"
fi

# Start development server
echo "Starting development server..."
if [ -f "app.py" ]; then
    python3 app.py
else
    echo "No app.py found. Creating a simple Flask app..."
    cat > app.py << 'EOF'
from flask import Flask, render_template, jsonify, request

app = Flask(__name__)

@app.route('/')
def index():
    return "Simple Task Manager - Development Server Running"

@app.route('/health')
def health():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
EOF
    python3 app.py
fi
