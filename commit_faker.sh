#!/bin/bash

# Config
START_DATE="2024-05-12" # Must be a Sunday
WEEKS=35
COMMITS_PER_PIXEL=25
COMMIT_MESSAGE="TED LOZZO"
FILE="dummy.txt"

# Use your real GitHub name/email (visible in contributions)
AUTHOR_NAME="Ted Lozzo"
AUTHOR_EMAIL="youremail@example.com" # <- Use GitHub-linked email

# 7x14 pixel grid: "X" for commit, " " for no commit
PIXEL_GRID=(
  "XXX XXX XX   X    XX  XXX XXX  XX  "
  " X  X   X X  X   X  X   X   X X  X "
  " X  X   X  X X   X  X   X   X X  X "
  " X  XXX X  X X   X  X  X   X  X  X "
  " X  X   X  X X   X  X X   X   X  X "
  " X  X   X X  X   X  X X   X   X  X "
  " X  XXX XX   XXX  XX  XXX XXX  XX  "
)

# Detect platform (macOS or Linux)
IS_MAC=false
if [[ "$OSTYPE" == "darwin"* ]]; then
  IS_MAC=true
fi

# Ensure file exists
touch $FILE

# Generate commits
for (( week=0; week<$WEEKS; week++ ))
do
  for (( day=0; day<7; day++ ))
  do
    pixel=${PIXEL_GRID[$day]:$week:1}
    if [ "$pixel" == "X" ]; then
      if [ "$IS_MAC" = true ]; then
        COMMIT_DATE=$(date -j -v+"$((week * 7 + day))"d -f "%Y-%m-%d" "$START_DATE" +"%Y-%m-%d")
      else
        COMMIT_DATE=$(date -d "$START_DATE +$((week * 7 + day)) days" +"%Y-%m-%d")
      fi

      for (( commit=1; commit<=$COMMITS_PER_PIXEL; commit++ ))
      do
        echo "Commit for $COMMIT_DATE ($commit/$COMMITS_PER_PIXEL)" >> $FILE
        git add $FILE
        GIT_AUTHOR_DATE="$COMMIT_DATE 12:00:00" \
        GIT_COMMITTER_DATE="$COMMIT_DATE 12:00:00" \
        GIT_AUTHOR_NAME="$AUTHOR_NAME" \
        GIT_AUTHOR_EMAIL="$AUTHOR_EMAIL" \
        GIT_COMMITTER_NAME="$AUTHOR_NAME" \
        GIT_COMMITTER_EMAIL="$AUTHOR_EMAIL" \
        git commit -m "$COMMIT_MESSAGE"
      done
    fi
  done
done

echo "✅ All dummy commits created!"
echo "🚀 Now push with: git push origin main"
