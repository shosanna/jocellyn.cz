#!/bin/bash


if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf build
mkdir build
git worktree prune
rm -rf .git/worktrees/build/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages build nufik/gh-pages

echo "Removing existing files"
rm -rf build/*

echo "Generating site"
bundle exec middleman build

echo "Updating gh-pages branch"
cd build && git add --all && git commit -m "Publishing to gh-pages (publish.sh) ... $(date)"
git push nufik gh-pages
