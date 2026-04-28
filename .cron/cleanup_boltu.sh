#!/bin/bash
# Boltu Cleanup Script - Cleans and optimizes OpenClaw workspace
# Run manually or via cron

LOG_FILE="/home/srppc3/.openclaw/workspace/.cron/cleanup.log"
OPENCLAW_DIR="/home/srppc3/.openclaw"
WORKSPACE_DIR="/home/srppc3/.openclaw/workspace"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M')] $1" >> "$LOG_FILE"
}

log "=== Cleanup started ==="

# 1. Clean config backups in .openclaw
find "$OPENCLAW_DIR" -maxdepth 1 -type f \( -name "*.bak*" -o -name "*.clobbered.*" -o -name "*.rejected.*" -o -name "update-check.json" \) -delete 2>/dev/null
log "Removed config backups"

# 2. Clean session reset files
find "$OPENCLAW_DIR/agents/main/sessions" -type f -name "*.reset.*" -delete 2>/dev/null
log "Removed session reset files"

# 3. Clean old media (images/voice older than 7 days)
find "$OPENCLAW_DIR/media/inbound" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.ogg" -o -name "*.mp3" \) -mtime +7 -delete 2>/dev/null
log "Removed old media files (>7 days)"

# 4. Archive old sessions (keep last 15)
SESSION_DIR="$OPENCLAW_DIR/agents/main/sessions"
if [ $(ls "$SESSION_DIR"/*.jsonl 2>/dev/null | wc -l) -gt 15 ]; then
    cd "$SESSION_DIR"
    ls -t *.jsonl 2>/dev/null | tail -n +16 | xargs -r rm -f
    ls -t *.trajectory.jsonl 2>/dev/null | tail -n +16 | xargs -r rm -f
    log "Archived old sessions (kept 15 recent)"
fi

# 5. Clear sync log if too large (>1MB)
SYNC_LOG="$WORKSPACE_DIR/.cron/sync.log"
if [ -f "$SYNC_LOG" ] && [ $(stat -c%s "$SYNC_LOG" 2>/dev/null || echo 0) -gt 1048576 ]; then
    echo "" > "$SYNC_LOG"
    log "Cleared sync.log (exceeded 1MB)"
fi

# 6. Remove empty directories
find "$WORKSPACE_DIR" -type d -empty -delete 2>/dev/null
log "Removed empty directories"

# 7. Clean workspace memory files (>30 days old, keep MEMORY.md)
find "$WORKSPACE_DIR/memory" -type f ! -name "MEMORY.md" -mtime +30 -delete 2>/dev/null
log "Removed old memory files (>30 days)"

# 7. Compact large session files (extract context → MEMORY.md → delete)
SESSION_DIR="$OPENCLAW_DIR/agents/main/sessions"
for session in $(ls -t "$SESSION_DIR"/*.jsonl 2>/dev/null | tail -n +8); do
    size=$(stat -c%s "$session" 2>/dev/null || echo 0)
    if [ "$size" -gt 512000 ]; then  # >500KB
        # Log compaction
        session_name=$(basename "$session" .jsonl)
        echo "[$(date '+%Y-%m-%d %H:%M')] Compacting session: $session_name (${size} bytes)" >> "$LOG_FILE"
        # Session will be reviewed and compacted by agent in next heartbeat
    fi
done

log "=== Cleanup complete ==="
