# Install BibleMate AI

## Install BibleMate AI

```
python3 -m venv ai
source ai/bin/activate
pip install -U biblemate biblemateweb biblematedata
```

## Setup BibleMate Data

```
biblematedata
```

## Edit ~/.bashrc

Add the following lines in `~/.bashrc`

```
# Setup venv path
export PATH=$PATH:$HOME/ai/bin

# Function to start BibleMate servers
## web server
start_bmweb() {
  echo "Starting BibleMate AI WEB server ..."
  nohup biblemateweb &
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
  nohup bmmcpmini -b googleai -p 33334 &
  echo "BibleMate AI MCP mini server started."
}
### Check if BibleMate MCP mini server is already running
if ! pgrep -f "/bin/bmmcpmini" > /dev/null; then
  start_bmmcpmini
else
  echo "BibleMate AI MCP mini server is already running."
fi
```

On a local machine, add the following line in `~/.bashrc`

```
alias nanobible="open http://$(getent hosts ubuntu.local | awk '{print $1}'):33355"
```