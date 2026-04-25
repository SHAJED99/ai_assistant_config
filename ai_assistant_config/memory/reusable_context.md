# Reusable Context

## For New Sessions
Load these automatically at session start:
1. workspace/user_profile.json → know who Panna is
2. workspace/assistant_state.json → know who I am
3. workspace/active_projects.json → know current work
4. memory/summary.md → know recent context

## Command Aliases
- "push your data" = git add + commit + push to ai_assistant_config
- "sync workspace" = update workspace files + commit + push
- "backup now" = create backup snapshot
- "restore from repo" = pull latest from ai_assistant_config
- "show workspace" = summarize current state

## GitHub Commands
```bash
# List repos
gh repo list --limit 50

# View repo info
gh repo view owner/repo

# Recent commits
gh repo view owner/repo --json recentCommits
```
