# Restore Guide

## Quick Restore

If Boltu needs to restore workspace from GitHub:

```bash
cd ~/.openclaw/workspace
git pull origin master
```

## What Gets Restored

- config/ → Identity, preferences, environment
- workspace/ → User profile, assistant state, projects, tasks
- memory/ → Summary, patterns
- prompts/ → Startup and specialized prompts
- changelog/ → Version history

## After Restore

1. Verify files exist
2. Load latest context
3. Continue from where left off

## Manual Restore

If automatic restore fails:
1. Clone repo fresh: `git clone https://github.com/SHAJED99/ai_assistant_config.git`
2. Copy contents to ~/.openclaw/workspace/
3. Commit and push changes as needed
