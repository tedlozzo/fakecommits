#!/bin/bash

# Config
START_DATE="2025-04-29" # Must be a Sunday
WEEKS=2
COMMITS_PER_PIXEL=15
COMMIT_MESSAGE="TED LOZZO"
FILE="dummy.txt"

# 7x14 pixel grid: "X" for commit, " " for no commit
# Each row represents a day of the week (Sunday -> Saturday)
PIXEL_GRID=(
  "X "
  " X"
  "X "
  " X"
  "X "
  " X"
  "X "
)

# Check if system is Mac or Linux
IS_MAC=false
if [[ "$OSTYPE" == "darwin"* ]]; then
  IS_MAC=true
fi

# Prepare file
touch $FILE

# Loop through weeks and days
for (( week=0; week<$WEEKS; week++ ))
do
  for (( day=0; day<7; day++ ))
  do
    # Get current character in the pixel grid
    pixel=${PIXEL_GRID[$day]:$week:1}

    if [ "$pixel" == "X" ]; then
      # Calculate the date
      if [ "$IS_MAC" = true ]; then
        COMMIT_DATE=$(date -j -v+"$((week * 7 + day))"d -f "%Y-%m-%d" "$START_DATE" +"%Y-%m-%d")
      else
        COMMIT_DATE=$(date -d "$START_DATE +$((week * 7 + day)) days" +"%Y-%m-%d")
      fi

      for (( commit=1; commit<=$COMMITS_PER_PIXEL; commit++ ))
      do
        echo "Commit for $COMMIT_DATE ($commit/$COMMITS_PER_PIXEL)" >> $FILE
        git add $FILE
        GIT_AUTHOR_DATE="$COMMIT_DATE 12:00:00" GIT_COMMITTER_DATE="$COMMIT_DATE 12:00:00" git commit -m "$COMMIT_MESSAGE"
      done
    fi
  done
done

echo "All dummy commits created!"
echo "Now push them with: git push origin main"