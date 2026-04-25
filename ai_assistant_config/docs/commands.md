# Commands

## Push Data
Save and push current workspace to GitHub:
```bash
cd ~/.openclaw/workspace
git add -A
git commit -m "update: [description]"
git push origin master
```

## Sync Workspace
Update workspace files with latest context:
```bash
# Edit relevant files in ai_assistant_config/
# Then push
git add -A && git push origin master
```

## Backup Now
Create timestamped backup:
```bash
# Archive current state
tar -czf backups/backup-$(date +%Y%m%d-%H%M%S).tar.gz ai_assistant_config/
git add -A && git push origin master
```

## Restore from Repo
```bash
cd ~/.openclaw/workspace
git pull origin master
```

## Show Workspace
```bash
# Lists current state from:
# - workspace/user_profile.json
# - workspace/active_projects.json
# - workspace/pending_tasks.json
# - memory/summary.md
```

## Health Check
Validate workspace integrity:
```bash
# Check for missing files
ls -la ai_assistant_config/config/
ls -la ai_assistant_config/workspace/
ls -la ai_assistant_config/memory/
```
