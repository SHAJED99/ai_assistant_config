#!/bin/bash
# Boltu Status Sync — checks workspace files for changes and pushes to GitHub if needed
# Run via cron: every 30 mins
#
# Note: Uses gh CLI (already authenticated) — no token stored in this script

GIT_DIR="$HOME/.openclaw/workspace"
LAST_PUSH_FILE="$GIT_DIR/.last_sync_push"

# Track if anything was pushed
PUSHED=0

cd "$GIT_DIR" || exit 1

# Initialize last push marker if not exists
[ -f "$LAST_PUSH_FILE" ] || echo "0" > "$LAST_PUSH_FILE"
LAST_PUSH=$(cat "$LAST_PUSH_FILE")

# Files to monitor (in priority order)
MONITOR_FILES=(
  "MEMORY.md"
  "memory/$(date +%Y-%m-%d).md"
  "SOUL.md"
  "USER.md"
  "IDENTITY.md"
  "HEARTBEAT.md"
)

# Check each file for modifications since last push
for file in "${MONITOR_FILES[@]}"; do
  if [ -f "$file" ]; then
    FILE_MTIME=$(stat -c %Y "$file"  2>/dev/null || stat -f %Sm -t %s "$file" 2>/dev/null)
    if [ "$FILE_MTIME" -gt "$LAST_PUSH" ]; then
      echo "Changes detected in: $file"
      PUSHED=1
      break
    fi
  fi
done

# Also check if any memory/*.md files were updated
for mem_file in "$GIT_DIR"/memory/????-??-??.md; do
  [ -f "$mem_file" ] || continue
  FILE_MTIME=$(stat -c %Y "$mem_file" 2>/dev/null || stat -f %Sm -t %s "$mem_file" 2>/dev/null)
  if [ "$FILE_MTIME" -gt "$LAST_PUSH" ]; then
    echo "Changes detected in: $mem_file"
    PUSHED=1
    break
  fi
done

if [ "$PUSHED" -eq 1 ]; then
  echo "Syncing to GitHub..."

  # Configure git (needed in fresh environment)
  git config --global user.email "shajedurrahmanpanna.panna@gmail.com" 2>/dev/null
  git config --global user.name "Shajedur Rahman Panna" 2>/dev/null

  # Pull first (in case of remote changes)
  git pull --rebase origin master 2>/dev/null

  # Stage all changes
  git add -A

  # Check if there are actual changes to commit
  if git diff --staged --quiet; then
    echo "No changes to commit"
  else
    COMMIT_MSG="sync: $(date '+%Y-%m-%d %H:%M') UTC — workspace auto-update"
    git commit -m "$COMMIT_MSG"
    git push origin master 2>&1

    if [ $? -eq 0 ]; then
      echo "Pushed successfully at $(date)"
      # Update last push marker
      date +%s > "$LAST_PUSH_FILE"
    else
      echo "Push failed"
    fi
  fi
else
  echo "No changes detected — nothing to push"
fi
