#!/bin/bash

# Path
export PATH=$PATH:$HOME/ai/bin

# Functions to start BibleMate servers

## web server
start_bmweb() {
    echo "Starting BibleMate AI WEB server ..."
    nohup biblemateweb > /dev/null 2>&1 &
    echo "BibleMate AI WEB server started."
}

### Check if BibleMate WEB server is already running
if ! pgrep -f "/bin/biblemateweb" > /dev/null; then
    start_bmweb
else
    echo "BibleMate AI WEB server is already running."
fi

## mcp mini server
start_bmmcpmini() {
    echo "Starting BibleMate MCP mini server ..."
    nohup bmmcpmini -b googleai -p 33334 > /dev/null 2>&1 &
    echo "BibleMate AI MCP mini server started."
}

### Check if BibleMate MCP mini server is already running
if ! pgrep -f "/bin/bmmcpmini" > /dev/null; then
    start_bmmcpmini
else
    echo "BibleMate AI MCP mini server is already running."
fi
