# SKILL.md - Telegram Group ID Discovery

## Description
Find Telegram group IDs for new agent bindings when the group is not yet configured in OpenClaw.

## When to Use
- User wants to bind a new Telegram group to an agent
- Group ID is unknown and not in the configuration
- Messages from the group are being blocked with "not-allowed" error

## The Problem

When a user creates a new Telegram group and adds the bot, the bot cannot respond because:
1. The group ID is not in `channels.telegram.groups` (allowlist)
2. There's no binding mapping the group to an agent

**Forwarding messages does NOT reveal the group ID** - forwarded messages lose the original chat metadata and only show the forwarder's user ID.

## Solution: Use OpenClaw Logs

### Method 1: Watch Logs in Real-Time

1. Start log monitoring:
```bash
openclaw logs --follow
```

2. Have the user send a message in the target group

3. Look for the rejection message in logs:
```
00:27:23 info telegram-auto-reply {"module":"telegram-auto-reply"} {"chatId":-5134264742,"title":"Group Name","reason":"not-allowed"} skipping group message
```

4. Extract the `chatId` value - this is the group ID (e.g., `-5134264742`)

### Method 2: Check Recent Logs

```bash
tail -100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log | grep "not-allowed"
```

## Configuration Steps

Once you have the group ID:

### 1. Add Group to Allowlist

```json
// In openclaw.json under channels.telegram.groups
"-GROUP_ID": {
  "groupPolicy": "open",
  "requireMention": false
}
```

### 2. Create/Update Agent Binding

```json
// In openclaw.json under bindings
{
  "agentId": "agent-name",
  "match": {
    "channel": "telegram",
    "peer": {
      "id": "-GROUP_ID",
      "kind": "group"
    }
  }
}
```

### 3. Create Agent (if new)

```json
// In openclaw.json under agents.list
{
  "id": "agent-name",
  "agentDir": "/home/username/.openclaw/agents/agent-name/agent",
  "model": "model-name",
  "name": "Agent Display Name",
  "workspace": "/home/username/.openclaw/workspaces/agent-name"
}
```

### 4. Create Agent Directory Structure

```bash
mkdir -p /home/username/.openclaw/agents/agent-name/agent
mkdir -p /home/username/.openclaw/agents/agent-name/sessions
mkdir -p /home/username/.openclaw/workspaces/agent-name

# Create minimal config files
echo '{}' > /home/username/.openclaw/agents/agent-name/agent/auth.json
echo '{"default": "model-name"}' > /home/username/.openclaw/agents/agent-name/agent/models.json

# Create workspace files (AGENTS.md, SOUL.md, IDENTITY.md, USER.md, TOOLS.md)
```

### 5. Restart Gateway

```bash
openclaw gateway restart
```

## Common Mistakes to Avoid

1. **Do NOT use forwarded messages** - They lose original chat metadata
2. **Do NOT guess group IDs** - Always extract from actual log entries
3. **Do NOT modify existing agent bindings** - Create new bindings, don't replace
4. **Do NOT forget to create agent workspace** - Agent won't function without proper workspace files

## Quick Reference Commands

```bash
# Watch logs in real-time
openclaw logs --follow

# Check recent logs for blocked groups
grep "not-allowed" /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log | tail -5

# Verify gateway status after changes
openclaw gateway status

# Verify agent binding
python3 -c "
import json
with open('/home/username/.openclaw/openclaw.json', 'r') as f:
    config = json.load(f)
for b in config['bindings']:
    if b['agentId'] == 'agent-name':
        print(f\"Group ID: {b['match']['peer']['id']}\")"
```

## Lesson Learned

On 2026-03-02, I failed to find the group ID by:
1. Asking the user to forward a message (forwarded messages don't preserve chat ID)
2. Trying to query Telegram API getUpdates (no updates because webhook mode)
3. Looking in the wrong log locations

The correct approach was to use `openclaw logs --follow` and have the user send a message in the group, then extract the `chatId` from the "not-allowed" log entry.

---

*Last updated: 2026-03-02*