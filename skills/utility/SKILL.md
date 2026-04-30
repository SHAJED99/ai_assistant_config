name: utility
description: User-defined utility commands. Triggers when Panna types /u_* commands like /u_push, /u_optimize, /u_status, etc. Handles workspace maintenance, git operations, and cleanup tasks.

# User Utility Commands

## Commands

| Command | Action |
|---------|--------|
| `/u_connect` | Start cloudflared tunnel, update OpenClaw config, generate setup code for phone |
| `/u_push` | Stage and push all changes to git |
| `/u_pull` | Pull latest from git |
| `/u_sync` | Sync workspace state |
| `/u_optimize` | Full cleanup: audit files, remove temp data, encrypt nothing, optimize git |
| `/u_status` | Show workspace health, git status, disk usage |
| `/u_clean` | Remove temp files, old scripts, duplicates, empty dirs |
| `/u_gitlog` | Show recent git commits |
| `/u_secrets` | Scan for and remove any exposed secrets |
| `/u_reset` | Soft reset: restore git state, re-read memory files |
| `/u_backup` | Create local backup of workspace |

## Implementation Notes

**File cleanup rules (follow strictly):**
- Delete: `*.py` (temp scripts), `*.sh` (unless essential), `*_token.json`, `google_docs*`, `cleanup*`, `sync*`, `.last_sync_push`, `.secrets.enc`
- Delete: duplicate images or files
- Keep: `.md` files, `.gitignore`, `pin_status.json`, `commands.json`
- Never store raw tokens in any .md file
- **Single source of truth**: No redundant data or files. If data exists in one file, don't duplicate it elsewhere.

**Git workflow:**
- Always check `git status` before acting
- Commit with descriptive messages
- Push after successful operations
- No secrets in git history

**`/u_connect` flow:**
1. Kill any existing cloudflared tunnel: `pkill cloudflared`
2. Start new tunnel in background: `cloudflared tunnel --url http://localhost:18789 > /tmp/cloudflared.log 2>&1 &`
3. Wait ~10s for tunnel to establish
4. Extract URL from `/tmp/cloudflared.log` (look for `https://*.trycloudflare.com`)
5. Update config: `openclaw config set gateway.remote.url wss://<URL>` and `openclaw config set plugins.entries.device-pair.config.publicUrl wss://<URL>`
6. Restart gateway: `openclaw gateway restart`
7. Generate setup code: `openclaw qr --json`
8. Return the `setupCode` to Panna

**Optimize flow (`/u_optimize`):**
1. Check workspace files
2. Remove temp files (see cleanup rules)
3. Verify no secrets in .md files
4. Run `git gc --aggressive --prune=now`
5. Commit and push if needed
6. Report changes

---

_Last updated: 2026-04-29_