# MEMORY.md - Long-Term Memory

## User

- **Name:** Shajedur Rahman Panna (Panna)
- **Preferred name:** Panna
- **Timezone:** Asia/Dhaka (UTC+6)
- **Email:** shajedurrahmanpanna.panna@gmail.com
- **Phone:** +8801703718809 (Grameenphone)

## Identity

- **My name:** Boltu ⚡
- **Role:** Panna's personal AI assistant

## GitHub

- **Username:** shajed99
- **Profile:** https://github.com/SHAJED99
- **Bio:** Aspiring Flutter developer with a passion for creating beautiful and functional mobile applications.
- **Organization:** AuroraSoft-dev
- **Token:** Stored in environment variable GH_TOKEN (~/.local/bin/bin/gh)
- **Scopes:** repo, read:org, read:user
- **Key repos:** portfolio, prime_on_boarding, EKYC, clean_architecture_getx, on_process_button_widget, time_range_selector_widget, fluttergems

- **LinkedIn:** https://www.linkedin.com/in/shajed99

- Software Engineer / Flutter Developer at Polygon Technology
- Skilled in Flutter, Dart, Android, Jetpack Compose, EKYC, Firebase, ESP8266, Local AI
- Prefers practical, production-ready code with file names
- Windows 10 Pro + WSL2 setup with Intel Arc A770
- Speaks English & Bangla

## Preferences (from config doc)

- Respond clearly and directly
- Practical solutions with steps
- Production-ready code when possible
- Prioritize Dart / Flutter examples
- Concise first, detailed when needed
- Remember user environment before suggesting
- Optimize for local/self-hosted tools first
- Full code examples with file names preferred

## CV

- **Latest:** [Google Doc](https://docs.google.com/document/d/15XH6-w_NpmshmCj395GpoNGYNwaaqCXaqD1HLdpQL8/edit?usp=sharing) — saved to `memory/cv.md`
- **5 years** Flutter/Dart experience
- **Skills:** Dart, Flutter, GetX, BLoC, Jetpack Compose, Firebase, EKYC, REST API
- **Current:** Software Engineer II at Polygon Technology (since May 2024)
- **Previous:** GTR (May 2023 - May 2024)
- **Key projects:** EKYC packages (Bkash, City Bank, Prime Bank), Owner's Proof, Halda, Atrai, Efficient App
- **Education:** B.Sc. CSE from HSTU (2017-2020)

## Available Ollama Models

- **Default Model:** ollama/qwen2.5:latest
- **Also Available:** ollama/llama3.2:latest
- **Newly Added:** llama3.2:1b (just added by Panna)

---

_Last updated: 2026-04-29_

## 🔐 Credential Management (2026-04-29)

**RULE: No secrets stored in git.** Fresh clone = fresh auth for all services.

**Setup on new machine:** See `SETUP.md` — has step-by-step for GitHub + Google OAuth.

**FILE CLEANUP RULES:**
- Delete: temp scripts (google_docs_*.py, *_token.json, cleanup_*.sh, sync_*.sh, .last_sync_push, .secrets.enc)
- Delete: duplicate images
- Keep: .gitignore updated with secrets patterns (.secrets.enc, *.token, *.key, google_tokens*, google_docs*)
- Commit only: source files, docs, memory content

**FILE AUDIT (do periodically):**
- Check workspace for: *.py, *.json (except config), *.sh, *.log, temp files
- Remove anything that isn't: .md or essential config
- Update MEMORY.md after any structural changes