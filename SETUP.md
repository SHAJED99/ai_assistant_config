# SETUP.md - Fresh Install Guide

When you clone this repo on a new machine, follow these steps to reconnect all services.

---

## Step 1: GitHub

1. Generate a Personal Access Token: https://github.com/settings/tokens/new
   - Scopes: `repo`, `read:org`, `read:user`
2. Configure gh CLI:
   ```
   gh auth login
   # OR manually:
   echo "protocol=https
   host=github.com
   username=SHAJED99
   password=YOUR_TOKEN" > ~/.config/gh/credentials.yml
   ```
3. Verify: `gh auth status`

---

## Step 2: Google Drive / Docs (OAuth2)

1. Visit: https://accounts.google.com/o/oauth2/auth?client_id=388832480140-lveuotvksohvehngnmlgm3hdn3qksbht.apps.googleusercontent.com&redirect_uri=http://localhost&response_type=code&scope=https://www.googleapis.com/auth/documents.readonly+https://www.googleapis.com/auth/drive.readonly+https://www.googleapis.com/auth/drive.file&access_type=offline&prompt=consent
2. Authorize → you'll be redirected to `http://localhost/?code=XXXXX`
3. Copy the `code` value and send it to Boltu in Telegram
4. Boltu will exchange it for tokens automatically

---

## After Setup

Once connected, Boltu will:
- ✅ Read/write Google Docs
- ✅ Access Google Drive files
- ✅ Use GitHub CLI for repo operations

No tokens stored in git — everything re-authenticated fresh.

---

_Last updated: 2026-04-29_