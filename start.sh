#!/bin/bash

# Start the Middleman blog
# This script handles setup and starts the development server

echo "🚀 Starting Middleman blog..."

# Check if gems are installed
if [ ! -d ".bundle" ]; then
    echo "📦 Installing gems..."
    bundle install --path .bundle
fi

# Start the server
echo "🌐 Starting development server at http://localhost:4567"
echo "Press Ctrl+C to stop"
bundle exec middleman server