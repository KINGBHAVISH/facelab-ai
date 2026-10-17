#!/bin/bash
set -e

# Deploy helper for Firebase Hosting (local)
# Usage:
# 1) Install Firebase CLI: npm install -g firebase-tools
# 2) Login: firebase login
# 3) Create or select a Firebase project: firebase projects:create facelab-ai-<suffix> or firebase use --add
# 4) Run this script: ./deploy-local.sh

if ! command -v firebase >/dev/null 2>&1; then
  echo "firebase CLI not found. Installing..."
  npm install -g firebase-tools
fi

# ensure public folder exists and contains index.html
mkdir -p public
if [ ! -f public/index.html ] && [ -f index.html ]; then
  cp index.html public/
fi

echo "To deploy, ensure you've run: firebase login && firebase use <project-id>"
echo "Then run: firebase deploy --only hosting"

# Optionally deploy automatically if a project is already selected
if firebase projects:list >/dev/null 2>&1; then
  echo "Ready to deploy. Running: firebase deploy --only hosting"
  firebase deploy --only hosting
else
  echo "No Firebase project configured. Use: firebase use --add"
fi
