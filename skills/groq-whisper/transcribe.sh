#!/bin/bash
set -e

# Default configuration
MODEL="whisper-large-v3-turbo"
API_URL="https://api.groq.com/openai/v1/audio/transcriptions"

# Help / Usage
if [[ "$1" == "--help" || -z "$1" ]]; then
  echo "Usage: $0 <file_path> [prompt] [language]"
  echo "  file_path: Path to the audio file (mp3, wav, m4a, etc.)"
  echo "  prompt:    Optional text to guide style or spelling"
  echo "  language:  Optional ISO-639-1 code (e.g. en, fr)"
  echo ""
  echo "Environment:"
  echo "  GROQ_API_KEY: Required"
  exit 1
fi

FILE_PATH="$1"
PROMPT="$2"
LANG="$3"

if [[ -z "$GROQ_API_KEY" ]]; then
  echo "Error: GROQ_API_KEY environment variable is not set."
  exit 1
fi

if [[ ! -f "$FILE_PATH" ]]; then
  echo "Error: File '$FILE_PATH' not found."
  exit 1
fi

# Build curl args array
CURL_ARGS=(
  -s
  -X POST "$API_URL"
  -H "Authorization: Bearer $GROQ_API_KEY"
  -F "file=@$FILE_PATH"
  -F "model=$MODEL"
  -F "response_format=json"
)

if [[ -n "$PROMPT" ]]; then
  CURL_ARGS+=(-F "prompt=$PROMPT")
fi

if [[ -n "$LANG" ]]; then
  CURL_ARGS+=(-F "language=$LANG")
fi

# Execute
curl "${CURL_ARGS[@]}"
