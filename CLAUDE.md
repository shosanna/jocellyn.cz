# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal blog built with Middleman, a Ruby-based static site generator. The blog contains articles written in Markdown and uses ERB templates for layout and structure.

## Architecture

- **Static Site Generator**: Middleman v4.2.1 with blog extension
- **Content**: Blog articles in `source/` directory as `.html.markdown` files
- **Templates**: ERB templates in `layouts/` and `source/layouts/`
- **Styling**: SCSS in `source/stylesheets/` with Bootstrap 3.3.7
- **Assets**: Images stored in `source/images/`
- **Configuration**: `config.rb` contains Middleman and blog settings

## Development Commands

### Quick Start (Working Solution)
```bash
# 1. Use the working Gemfile and install dependencies
bundle install --path .bundle

# 2. Start development server
bundle exec middleman server
# Server runs at http://localhost:4567

# Alternative: Use the automated script
./start.sh
```

### Ruby Version Compatibility
This legacy project has dependency conflicts with modern Ruby. Multiple solutions available:

**Option 1: Modern Ruby with simplified dependencies (Recommended)**
```bash
# Use the simplified Gemfile
cp Gemfile.simple Gemfile
sudo apt install ruby-dev build-essential
bundle install --path vendor/bundle
bundle exec middleman server
```

**Option 2: Legacy Ruby setup**
```bash
# Install Ruby 2.7.x via rbenv
sudo apt install build-essential libssl-dev libreadline-dev zlib1g-dev
rbenv install 2.7.6
rbenv local 2.7.6
gem install bundler:1.17.3
bundle _1.17.3_ install
```

**Option 3: Docker environment**
```bash
docker run -it -v $(pwd):/app -w /app ruby:2.7 bash
# Then inside container:
gem install bundler:1.17.3
bundle _1.17.3_ install
bundle exec middleman server --bind-address 0.0.0.0
```

### Available Scripts
- `./start.sh` - Automated setup and start script
- `python3 serve.py` - Python fallback server (serves build/ directory)
- `./deploy.sh` - Deploy to GitHub Pages

### Common Commands
- **Install dependencies**: `bundle install --path vendor/bundle`
- **Start development server**: `bundle exec middleman server`
- **Build site**: `bundle exec middleman build`
- **Deploy**: `./deploy.sh` (GitHub Pages) or `rake deploy` (direct server)

### Files Created for Easy Setup
- `Gemfile.simple` - Simplified dependencies that work with modern Ruby
- `start.sh` - Automated setup script
- `serve.py` - Python HTTP server fallback

### Troubleshooting
- **Native extension errors**: Install `ruby-dev` package
- **Permission errors**: Use `--path vendor/bundle` flag
- **Dependency conflicts**: Use `Gemfile.simple` or delete `Gemfile.lock`
- **Port conflicts**: Use `lsof -ti:4567 | xargs kill` to free port 4567

## Deployment

### GitHub Pages (Recommended)
```bash
# Deploy to GitHub Pages
./deploy.sh
```

The deploy script will:
- Build the site with `bundle exec middleman build`
- Create/update `gh-pages` branch
- Push to GitHub Pages
- Site available at: `https://username.github.io/jocellyn.cz`

### Manual Deployment
```bash
# Build site locally
bundle exec middleman build

# Serve built site
python3 serve.py
```

### Alternative: Direct Server
Use `rake deploy` for direct server deployment via SCP (legacy option).

## Content Structure

- Blog articles follow naming pattern: `YYYY-MM-DD-title.html.markdown`
- Articles support tags and are automatically organized by year/month
- Main layout (`source/layout.erb`) includes:
  - Recent articles sidebar
  - Tag cloud
  - Year-based archives
  - Bootstrap styling and analytics

## Key Files

- `config.rb`: Middleman configuration, blog settings, and build options
- `source/layout.erb`: Main page template with navigation and analytics
- `Gemfile`: Ruby dependencies including Middleman and blog extensions
- `deploy.sh`: GitHub Pages deployment script
- `Rakefile`: Alternative deployment task