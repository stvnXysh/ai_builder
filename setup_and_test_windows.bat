@echo off
:: Setup and Test Script for Windows

:: Function to install Python
echo Installing Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python not found. Please download and install Python from https://www.python.org/downloads/
)

:: Function to install Node.js
echo Installing Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js not found. Please download and install Node.js from https://nodejs.org/
)

:: Function to install Git
echo Installing Git...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git not found. Please download and install Git from https://git-scm.com/download/win
)

:: Set up virtual environment
echo Setting up virtual environment...
if not exist "venv" (
    python -m venv venv
    echo Virtual environment created.
) else (
    echo Virtual environment already exists.
)
echo Activating virtual environment...
call venv\Scripts\activate

:: Install Python dependencies
if exist "requirements.txt" (
    echo Installing Python dependencies...
    pip install -r requirements.txt
) else (
    echo No requirements.txt file found.
)

:: Install Node.js dependencies
if exist "package.json" (
    echo Installing Node.js dependencies...
    npm install
) else (
    echo No package.json file found.
)

:: Run tests
echo Running Python tests...
if exist "tests" (
    pytest
) else (
    echo No tests found for Python.
)

echo Running Node.js tests...
if exist "package.json" (
    npm test
) else (
    echo No tests defined in package.json.
)

:: Check Git status
echo Checking Git status...
git status

echo Setup and tests completed.
pause
