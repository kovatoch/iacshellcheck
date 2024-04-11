#!/bin/bash

# Check if a script file is provided as a parameter
if [ -z "$1" ]; then
    echo "Usage: lint.sh <script>"
    exit 1
fi

# Lint the provided script using ShellCheck
echo "Linting $1"
shellcheck "$1"