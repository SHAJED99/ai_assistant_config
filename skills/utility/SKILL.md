name: utility
description: User-defined utility commands. Triggers when Panna types /u_* commands like /u_push, /u_optimize, /u_status, etc. Handles workspace maintenance, git operations, and cleanup tasks.

# User Utility Commands

## Commands

| Command | Action |
|---------|--------|
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
- Keep: `.md` files, `.gitignore`, `pin_status.json`
- Never store raw tokens in any .md file

**Git workflow:**
- Always check `git status` before acting
- Commit with descriptive messages
- Push after successful operations
- No secrets in git history

**Optimize flow (`/u_optimize`):**
1. Check workspace files
2. Remove temp files (see cleanup rules)
3. Verify no secrets in .md files
4. Run `git gc --aggressive --prune=now`
5. Commit and push if needed
6. Report changes

---

_Last updated: 2026-04-29_