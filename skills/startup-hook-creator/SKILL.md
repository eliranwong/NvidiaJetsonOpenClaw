# Startup Hook Creator Skill

Create and enable OpenClaw hooks that execute bash scripts on Gateway startup.

## Purpose

Automates the process of creating a "startup hook" (Option 2) that runs a script silently in the background when the OpenClaw gateway starts. This is useful for:
- Starting background services (e.g., BibleMate, web servers)
- Syncing files or environment setup
- Running maintenance tasks

## Usage

### 1. Create your bash script first

Write the script you want to run (e.g., `start-services.sh`) and save it somewhere (e.g., `~/.openclaw/scripts/`).

```bash
# Example script content
#!/bin/bash
nohup python3 -m http.server 8080 &
```

### 2. Run the skill command

```bash
/home/eliran/.openclaw/skills/startup-hook-creator/create.sh <hook_name> <script_path> [description]
```

**Parameters:**
- `hook_name`: A unique identifier for the hook (e.g., `my-service-startup`).
- `script_path`: Absolute path to the bash script you created in step 1.
- `description` (optional): Short description of what the hook does.

### Example

```bash
# Create and enable a hook named 'web-server-start' that runs the script at /home/eliran/scripts/start-web.sh
/home/eliran/.openclaw/skills/startup-hook-creator/create.sh web-server-start /home/eliran/scripts/start-web.sh "Starts local web server"
```

## What it does

1.  Verifies the script exists and makes it executable (`chmod +x`).
2.  Creates a new hook directory at `~/.openclaw/hooks/<hook_name>`.
3.  Generates `HOOK.md` metadata configured for the `gateway:startup` event.
4.  Generates `handler.ts` which executes the bash script using `child_process.exec`.
5.  Enables the hook using `openclaw hooks enable <hook_name>`.
6.  (Requires a gateway restart to take effect).
