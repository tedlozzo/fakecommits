#!/bin/bash

# Create a new orphan branch (no history)
git checkout --orphan new-main
AUTHOR_NAME="TED LOZZO"
AUTHOR_EMAIL="youremail@example.com"
COMMIT_DATE="2025-04-28T12:00:00"

# Remove all old files from the index
git reset --hard

# Add everything cleanly again (you can exclude .gitignore, .env, etc.)
git add .

# Make a clean commit as current user
GIT_AUTHOR_DATE="$COMMIT_DATE" \
GIT_COMMITTER_DATE="$COMMIT_DATE" \
GIT_AUTHOR_NAME="$AUTHOR_NAME" \
GIT_AUTHOR_EMAIL="$AUTHOR_EMAIL" \
GIT_COMMITTER_NAME="$AUTHOR_NAME" \
GIT_COMMITTER_EMAIL="$AUTHOR_EMAIL" \
git commit -m "🎉 Project reborn under TED LOZZO"


# Delete old main
git branch -D main

# Rename new branch to main
git branch -m main

# Force push to origin
git push -f origin main