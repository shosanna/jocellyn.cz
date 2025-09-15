#!/usr/bin/env python3
"""
Simple HTTP server for the Middleman blog
Serves the 'build' directory if it exists, otherwise shows setup instructions
"""

import os
import sys
from http.server import HTTPServer, SimpleHTTPRequestHandler
import webbrowser

class BlogHTTPRequestHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory="build", **kwargs)

def main():
    port = 4567  # Default Middleman port
    
    # Check if build directory exists
    if not os.path.exists("build"):
        print("❌ Build directory not found.")
        print("\nTo generate the site:")
        print("1. Install ruby-dev: sudo apt install ruby-dev")
        print("2. Install gems: bundle install --path vendor/bundle")
        print("3. Build site: bundle exec middleman build")
        print("4. Or use the start.sh script")
        sys.exit(1)
    
    try:
        server = HTTPServer(('localhost', port), BlogHTTPRequestHandler)
        print(f"✅ Serving blog at http://localhost:{port}")
        print("Press Ctrl+C to stop")
        
        # Try to open browser
        try:
            webbrowser.open(f'http://localhost:{port}')
        except:
            pass
            
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n👋 Server stopped")
    except OSError as e:
        if "Address already in use" in str(e):
            print(f"❌ Port {port} is already in use")
            print("Try: lsof -ti:4567 | xargs kill")
        else:
            print(f"❌ Error: {e}")

if __name__ == "__main__":
    main()