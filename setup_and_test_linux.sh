#!/bin/bash
# Setup and Test Script for Linux

# Function to install Python
echo "Installing Python..."
if ! command -v python3 &> /dev/null
then
    sudo apt update
    sudo apt install -y python3 python3-pip
else
    echo "Python is already installed."
fi

# Function to install Node.js
echo "Installing Node.js..."
if ! command -v node &> /dev/null
then
    sudo apt install -y nodejs npm
else
    echo "Node.js is already installed."
fi

# Function to install Git
echo "Installing Git..."
if ! command -v git &> /dev/null
then
    sudo apt install -y git
else
    echo "Git is already installed."
fi

# Set up virtual environment
echo "Setting up virtual environment..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "Virtual environment created."
else
    echo "Virtual environment already exists."
fi
echo "Activating virtual environment..."
source venv/bin/activate

# Install Python dependencies
if [ -f "requirements.txt" ]; then
    echo "Installing Python dependencies..."
    pip install -r requirements.txt
else
    echo "No requirements.txt file found."
fi

# Install Node.js dependencies
if [ -f "package.json" ]; then
    echo "Installing Node.js dependencies..."
    npm install
else
    echo "No package.json file found."
fi

# Run tests
echo "Running Python tests..."
if command -v pytest &> /dev/null; then
    pytest
else
    echo "pytest not found, skipping Python tests."
fi

echo "Running Node.js tests..."
if [ -f "package.json" ] && grep -q "\"test\"" package.json; then
    npm test
else
    echo "No tests defined in package.json, skipping Node.js tests."
fi

# Check Git status
echo "Checking Git status..."
git status

echo "Setup and tests completed."
