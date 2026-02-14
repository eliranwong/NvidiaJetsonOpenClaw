# Homebrew
export HOMEBREW_NO_ANALYTICS=1
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

# Claude Code via Azure Foundry
export ANTHROPIC_AUTH_TOKEN=<your_api_key>
export ANTHROPIC_BASE_URL=https://<your_project_name>.services.ai.azure.com/anthropic/
export ANTHROPIC_FOUNDRY_API_KEY=<your_api_key>
export ANTHROPIC_FOUNDRY_BASE_URL=https://<your_project_name>.services.ai.azure.com/anthropic/
export ANTHROPIC_MODEL=opusplan
export ANTHROPIC_DEFAULT_OPUS_MODEL=claude-opus-4-5
export ANTHROPIC_DEFAULT_SONNET_MODEL=claude-sonnet-4-5

# Gemini CLI via Vertex AI
export GOOGLE_CLOUD_PROJECT=<your_project_id>
export GOOGLE_CLOUD_LOCATION=us-central1
export GOOGLE_APPLICATION_CREDENTIALS='/mnt/shared/Documents/credentials_google_cloud.json'

# File Sharing
alias files="python3 -m http.server 9999"

# BibleMate servers
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