---
name: isolated-agent-creator
description: Create isolated OpenClaw agents with separate workspaces, bound to specific Telegram groups or channels. Use when setting up a specialized agent (e.g., Bible study, work assistant) that should respond in a dedicated chat.
metadata: {"openclaw":{"emoji":"🤖"}}
---

# Isolated Agent Creator

Create fully isolated OpenClaw agents with their own workspace, sessions, and channel bindings.

## When to Use

- User wants a **specialized agent** for a specific purpose (e.g., Bible study, coding, family chat)
- User wants to **bind a Telegram group** to a different agent personality
- User needs **separate conversation history** from the main agent

## Prerequisites

- OpenClaw gateway running
- Access to `~/.openclaw/openclaw.json`
- Main agent's auth files (to copy credentials)

---

## Step-by-Step Process

### Step 1: Create the Agent

```bash
openclaw agents add <agent-id> \
  --workspace ~/.openclaw/workspaces/<agent-id> \
  --model anthropic/claude-sonnet-4-5 \
  --non-interactive
```

**Note:** Do NOT use `--bind` flag — it creates incorrect bindings. We'll add bindings manually.

### Step 2: Create Agent Directory Structure

The CLI doesn't always create all required directories:

```bash
mkdir -p ~/.openclaw/agents/<agent-id>/agent
mkdir -p ~/.openclaw/agents/<agent-id>/sessions
```

### Step 3: Copy Auth Credentials

Copy API keys and model configs from the main agent:

```bash
cp ~/.openclaw/agents/main/agent/auth-profiles.json ~/.openclaw/agents/<agent-id>/agent/
cp ~/.openclaw/agents/main/agent/models.json ~/.openclaw/agents/<agent-id>/agent/
```

### Step 4: Set Correct Permissions

Match main agent's permissions:

```bash
chmod 700 ~/.openclaw/agents/<agent-id>
chmod 700 ~/.openclaw/agents/<agent-id>/agent
chmod 700 ~/.openclaw/agents/<agent-id>/sessions
```

### Step 5: Initialize Sessions

Create empty sessions.json:

```bash
echo '{}' > ~/.openclaw/agents/<agent-id>/sessions/sessions.json
```

### Step 6: Create Workspace Files

Create these files in `~/.openclaw/workspaces/<agent-id>/`:

#### IDENTITY.md
```markdown
# IDENTITY.md - Who Am I?

- **Name:** <Agent Name>
- **Creature:** AI <Specialty> Assistant
- **Vibe:** <personality traits>
- **Emoji:** <emoji>
```

#### SOUL.md
```markdown
# SOUL.md - Who You Are

_You are <Name>. A dedicated <purpose> assistant._

## Core Identity
[Describe the agent's purpose and specialization]

## Core Truths
[Key behavioral guidelines]

## Approach
[How the agent should handle requests]

## Boundaries
[What's in/out of scope]
```

#### USER.md
```markdown
# USER.md - About Your Human

- **Name:** <user name>
- **Timezone:** <timezone>
- **Notes:** <relevant context>
```

#### AGENTS.md
```markdown
# AGENTS.md - <Agent Name> Workspace

[Workflow instructions for this specialized agent]
```

### Step 7: Add Skills (If Applicable)

If the agent needs specific skills that exist in `~/.openclaw/skills/`, copy them to the workspace. **Skip this step if no relevant skills exist.**

```bash
# Only if a relevant skill exists:
mkdir -p ~/.openclaw/workspaces/<agent-id>/skills
cp -r ~/.openclaw/skills/<skill-name> ~/.openclaw/workspaces/<agent-id>/skills/
```

**Note:** Most agents work fine without custom skills. Only copy skills if:
- A specialized skill exists for the agent's purpose (e.g., `bible-study` for a Bible agent)
- You want agent-specific skill behavior separate from the main agent

### Step 8: Update openclaw.json Config

Edit `~/.openclaw/openclaw.json` to add/fix the agent config:

#### Agent Entry (under `agents.list`)

```json
{
  "id": "<agent-id>",
  "name": "<Agent Display Name>",
  "workspace": "/home/<user>/.openclaw/workspaces/<agent-id>",
  "agentDir": "/home/<user>/.openclaw/agents/<agent-id>/agent",
  "sessionsDir": "/home/<user>/.openclaw/agents/<agent-id>/sessions",
  "model": "anthropic/claude-sonnet-4-5"
}
```

⚠️ **CRITICAL:** The `sessionsDir` field is REQUIRED for isolated agents. Without it, you'll get "Session file path must be within sessions directory" errors.

#### Binding Entry (under `bindings`)

For **Telegram group** binding:

```json
{
  "agentId": "<agent-id>",
  "match": {
    "channel": "telegram",
    "peer": {
      "kind": "group",
      "id": "<group-id>"
    }
  }
}
```

For **Telegram DM** binding:

```json
{
  "agentId": "<agent-id>",
  "match": {
    "channel": "telegram",
    "peer": {
      "kind": "direct",
      "id": "<user-id>"
    }
  }
}
```

⚠️ **CRITICAL:** Use `peer.kind` and `peer.id` — NOT `accountId`. Using `accountId` for group IDs will fail silently.

#### Telegram Group Allowlist (under `channels.telegram.groups`)

```json
"groups": {
  "<group-id>": {
    "requireMention": false
  }
}
```

### Step 9: Restart Gateway

```bash
systemctl --user restart openclaw-gateway
```

Or if using CLI:
```bash
openclaw gateway restart
```

### Step 10: Verify

```bash
openclaw agents list --bindings
```

Should show the agent with correct routing rules.

---

## Common Mistakes to Avoid

### ❌ Wrong: Using accountId for group binding
```json
{
  "match": {
    "channel": "telegram",
    "accountId": "-5147393542"  // WRONG!
  }
}
```

### ✅ Correct: Using peer object
```json
{
  "match": {
    "channel": "telegram",
    "peer": {
      "kind": "group",
      "id": "-5147393542"
    }
  }
}
```

### ❌ Wrong: Missing sessionsDir
```json
{
  "id": "my-agent",
  "agentDir": "...",
  "workspace": "..."
  // sessionsDir missing!
}
```

### ✅ Correct: Include sessionsDir
```json
{
  "id": "my-agent",
  "agentDir": "/home/user/.openclaw/agents/my-agent/agent",
  "workspace": "/home/user/.openclaw/workspaces/my-agent",
  "sessionsDir": "/home/user/.openclaw/agents/my-agent/sessions"
}
```

### ❌ Wrong: Using --bind flag with group ID
```bash
openclaw agents add myagent --bind "telegram:-5147393542"
# Creates incorrect accountId binding
```

### ✅ Correct: Add binding manually in config
Add the proper peer-based binding to openclaw.json after creating the agent.

---

## Troubleshooting

### "Session file path must be within sessions directory"

**Cause:** Missing `sessionsDir` in agent config.

**Fix:** Add `sessionsDir` to the agent entry in openclaw.json:
```json
"sessionsDir": "/home/<user>/.openclaw/agents/<agent-id>/sessions"
```

### Agent not responding in group

**Check:**
1. Group is in `channels.telegram.groups` allowlist
2. Binding uses `peer.kind` and `peer.id` (not `accountId`)
3. Bot has message access in the Telegram group
4. Gateway was restarted after config changes

### Auth errors

**Cause:** Missing or invalid auth-profiles.json.

**Fix:** Copy from main agent:
```bash
cp ~/.openclaw/agents/main/agent/auth-profiles.json ~/.openclaw/agents/<agent-id>/agent/
```

### Stale session references

**Cause:** sessions.json references non-existent .jsonl files.

**Fix:** Reset sessions:
```bash
echo '{}' > ~/.openclaw/agents/<agent-id>/sessions/sessions.json
```

---

## Complete Example: Bible Study Agent

```bash
# 1. Create agent (without --bind)
openclaw agents add bible-study \
  --workspace ~/.openclaw/workspaces/bible-study \
  --model anthropic/claude-sonnet-4-5 \
  --non-interactive

# 2. Create directories
mkdir -p ~/.openclaw/agents/bible-study/agent
mkdir -p ~/.openclaw/agents/bible-study/sessions

# 3. Copy auth
cp ~/.openclaw/agents/main/agent/auth-profiles.json ~/.openclaw/agents/bible-study/agent/
cp ~/.openclaw/agents/main/agent/models.json ~/.openclaw/agents/bible-study/agent/

# 4. Set permissions
chmod 700 ~/.openclaw/agents/bible-study
chmod 700 ~/.openclaw/agents/bible-study/agent
chmod 700 ~/.openclaw/agents/bible-study/sessions

# 5. Initialize sessions
echo '{}' > ~/.openclaw/agents/bible-study/sessions/sessions.json

# 6. Create workspace files (IDENTITY.md, SOUL.md, USER.md, AGENTS.md)
# [Use write tool to create these]

# 7. Copy skills (only if applicable)
# Skip if no relevant skill exists for this agent's purpose
# mkdir -p ~/.openclaw/workspaces/bible-study/skills
# cp -r ~/.openclaw/skills/bible-study ~/.openclaw/workspaces/bible-study/skills/
```

Then edit `~/.openclaw/openclaw.json`:

```json
{
  "agents": {
    "list": [
      {
        "id": "bible-study",
        "name": "BibleMate",
        "workspace": "/home/username/.openclaw/workspaces/bible-study",
        "agentDir": "/home/username/.openclaw/agents/bible-study/agent",
        "sessionsDir": "/home/username/.openclaw/agents/bible-study/sessions",
        "model": "anthropic/claude-sonnet-4-5"
      }
    ]
  },
  "bindings": [
    {
      "agentId": "bible-study",
      "match": {
        "channel": "telegram",
        "peer": {
          "kind": "group",
          "id": "-5147393542"
        }
      }
    }
  ],
  "channels": {
    "telegram": {
      "groups": {
        "-5147393542": {
          "requireMention": false
        }
      }
    }
  }
}
```

Finally:
```bash
systemctl --user restart openclaw-gateway
```

---

## Notes

- All paths must be **absolute** (not relative or using `~`)
- The `main` agent uses defaults and doesn't need explicit sessionsDir
- Bindings are evaluated most-specific-first (peer > accountId > channel)
- Skills in workspace `skills/` folder override shared skills in `~/.openclaw/skills/`
- Each agent has its own conversation history (no cross-talk)
