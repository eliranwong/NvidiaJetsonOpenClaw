#!/bin/bash

# startup-hook-creator helper script
# Usage: ./create.sh <hook_name> <absolute_script_path> [description]

HOOK_NAME=$1
SCRIPT_PATH=$2
DESCRIPTION=${3:-"Runs startup script $SCRIPT_PATH"}

if [ -z "$HOOK_NAME" ] || [ -z "$SCRIPT_PATH" ]; then
  echo "Usage: $0 <hook_name> <absolute_script_path> [description]"
  exit 1
fi

if [ ! -f "$SCRIPT_PATH" ]; then
  echo "Error: Script not found at $SCRIPT_PATH"
  exit 1
fi

# Ensure script is executable
chmod +x "$SCRIPT_PATH"

HOOK_DIR="$HOME/.openclaw/hooks/$HOOK_NAME"
echo "Creating hook in $HOOK_DIR..."
mkdir -p "$HOOK_DIR"

# 1. Create HOOK.md
cat <<EOF > "$HOOK_DIR/HOOK.md"
---
name: $HOOK_NAME
description: "$DESCRIPTION"
metadata:
  openclaw:
    emoji: "🚀"
    events: ["gateway:startup"]
---

# $HOOK_NAME

This hook executes the bash script at \`$SCRIPT_PATH\` when the OpenClaw gateway starts.
EOF

# 2. Create handler.ts
cat <<EOF > "$HOOK_DIR/handler.ts"
import { exec } from "child_process";
import type { HookHandler } from "../../src/hooks/hooks.js";

const handler: HookHandler = async (event) => {
  // Only run on startup
  if (event.type !== "gateway" || event.action !== "startup") {
    return;
  }

  console.log("[$HOOK_NAME] Triggered. Running: $SCRIPT_PATH");

  exec("$SCRIPT_PATH", (error, stdout, stderr) => {
    if (error) {
      console.error(\`[$HOOK_NAME] Execution error: \${error.message}\`);
      return;
    }
    if (stderr) {
      console.warn(\`[$HOOK_NAME] stderr: \${stderr}\`);
    }
    if (stdout) {
      console.log(\`[$HOOK_NAME] stdout: \${stdout}\`);
    }
  });
};

export default handler;
EOF

echo "Hook files created."

# 3. Enable the hook
# Attempt to find openclaw in PATH or use known location
OPENCLAW_BIN=$(which openclaw)
if [ -z "$OPENCLAW_BIN" ]; then
    OPENCLAW_BIN="/home/eliran/.nvm/versions/node/v24.13.1/bin/openclaw"
fi

if [ -x "$OPENCLAW_BIN" ]; then
    echo "Enabling hook via $OPENCLAW_BIN..."
    "$OPENCLAW_BIN" hooks enable "$HOOK_NAME"
else
    echo "Warning: 'openclaw' CLI not found. Please run 'openclaw hooks enable $HOOK_NAME' manually."
fi

echo "Done! The script will run on next gateway restart."
