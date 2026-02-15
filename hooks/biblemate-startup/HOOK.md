---
name: biblemate-startup
description: "Starts BibleMate WEB and MCP mini servers on gateway startup."
metadata:
  openclaw:
    emoji: "🚀"
    events: ["gateway:startup"]
---

# BibleMate Startup

This hook runs the `/home/eliran/.openclaw/scripts/startup-biblemate.sh` script when the OpenClaw gateway starts.

It ensures that:
- The BibleMate WEB server is running.
- The BibleMate MCP mini server is running on port 33334.

If the services are already running (checked via `pgrep`), it does nothing.
