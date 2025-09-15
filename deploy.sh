#!/bin/bash

# Deploy Middleman blog to GitHub Pages
# This script builds the site and pushes to gh-pages branch

set -e  # Exit on any error

echo "🚀 Deploying to GitHub Pages..."

# Check if working directory is clean
if [[ $(git status -s) ]]; then
    echo "⚠️  Warning: Working directory has uncommitted changes"
    echo "Continuing anyway..."
fi

# Clean up previous builds
echo "🧹 Cleaning up previous builds"
rm -rf build
mkdir build
git worktree prune
rm -rf .git/worktrees/build/ 2>/dev/null || true

# Remove local gh-pages branch if it exists
git branch -D gh-pages 2>/dev/null || true

# Check if gh-pages branch exists remotely
if git ls-remote --heads origin gh-pages | grep -q gh-pages; then
    echo "📥 Checking out existing gh-pages branch"
    git worktree add -b gh-pages build origin/gh-pages
else
    echo "🆕 Creating new orphan gh-pages branch"
    git worktree add --orphan -b gh-pages build
fi

# Remove existing files (but keep .git)
echo "🗑️  Removing existing files"
cd build
find . -maxdepth 1 ! -name .git ! -name . -exec rm -rf {} +
cd ..

# Build the site
echo "🔨 Building site with Middleman"
bundle exec middleman build

# Deploy to GitHub Pages
echo "📤 Deploying to GitHub Pages"
cd build
git add --all
if git diff --staged --quiet; then
    echo "✅ No changes to deploy"
else
    git commit -m "Deploy blog - $(date)"
    git push origin gh-pages
    echo "✅ Successfully deployed to GitHub Pages!"
    echo "🌐 Your site will be available at: https://$(git config user.name || echo 'username').github.io/$(basename $(git rev-parse --show-toplevel))"
fi

echo "🎉 Deployment complete!"
