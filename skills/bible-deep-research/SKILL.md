---
name: bible-deep-research
description: Run deep Bible study research using the bibleagent CLI tool. Use when the user requests in-depth Bible study, theological research, verse analysis, or comprehensive biblical investigation. The tool performs multi-step research and exports results to DOCX files which are then uploaded to Google Drive.
---

# Bible Deep Research

Run comprehensive Bible study research using the `bibleagent` CLI.

## Workflow

When the user requests deep Bible research:

### 1. Ensure Local Output Directory Exists

```bash
mkdir -p ~/bible_agent_research
```

The workspace output directory is `~/bible_agent_research`.

### 2. Run the Research CLI

```bash
/home/username/ai/bin/bibleagent -docx -o ~/bible_agent_research -p "[user_request]"
```

**Important:**
- The CLI runs a multi-step research process and takes a while
- It prints output as it processes
- Each step exports a DOCX file (00_..., 01_..., etc.) to a date-stamped sub-folder
- Sub-folder naming: `YYYY_M_D_study_title` (generated automatically)

**Monitoring:** Since the process takes time, run it and wait for completion. The CLI will exit when finished.

### 3. Upload to Google Drive

After the CLI completes:

**a) Find or create the Google Drive folder:**

```bash
# Check if "bible_agent_research" folder exists
gog drive search "name = 'bible_agent_research' and mimeType = 'application/vnd.google-apps.folder'" --max 1 --json
```

If no folder exists, create it:
```bash
gog drive mkdir "bible_agent_research" --json
```

**b) Record the folder ID** - Store it in `~/.openclaw/workspaces/bible-deep-research/memory/gdrive_folder_id.txt` for future use.

**c) Upload the research sub-folder:**

The CLI creates a date-stamped sub-folder. Upload all DOCX files from it:

```bash
# Find the newly created sub-folder (most recent)
LATEST_DIR=$(ls -td ~/bible_agent_research/*/ | head -1)

# Create a folder in Google Drive for this study
gog drive mkdir "[study_name]" --parent [bible_agent_research_folder_id] --json

# Upload all DOCX files
for file in "$LATEST_DIR"*.docx; do
  gog drive upload "$file" --parent [study_folder_id]
done
```

### 4. Share and Deliver

**a) Share the study folder with anyone (read access):**

```bash
gog drive share [study_folder_id] --role reader --type anyone
```

**b) Get the shareable link and send to the user via Telegram:**

The link format is: `https://drive.google.com/drive/folders/[folder_id]`

## Google Drive Folder ID Storage

Store the main `bible_agent_research` folder ID in:
```
~/.openclaw/workspaces/bible-deep-research/memory/gdrive_folder_id.txt
```

Before creating a new folder, check this file first. If it exists and contains a valid ID, use it.

## Notes

- The bibleagent CLI performs multiple research steps automatically
- Output is always in DOCX format when using `-docx` flag
- Each study gets its own sub-folder with sequential DOCX files
- Always confirm upload success before sharing
