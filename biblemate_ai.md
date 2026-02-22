# Install BibleMate AI

```
python3 -m venv ai
source ai/bin/activate
pip install -U biblemate biblemateweb biblematedata
# Support document conversion
sudo apt install pandoc texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-xetex
```

## Configure AI Backend

Run `ai -ec`, edit the values of `DEFAULT_AI_BACKEND` and `GOOGLEAI_API_KEY`, e.g.:

```
DEFAULT_AI_BACKEND=googleai
GOOGLEAI_API_KEY=<your_gemini_api_key>
```

In addition, make sure ollama is set up and `paraphrase-multilingual` is downloaded, read:

https://github.com/eliranwong/NvidiaJetsonOpenClaw/blob/main/basic_tools.md#install-ollama

## Setup Gog CLI

Gog CLI is required for uploading the bible study results to Google Drive automatically.

Follow the instructions in [Gog CLI Setup](gog_cli.md).

## Setup BibleMate Data

```
biblematedata
```

## Autostart BibleMate Servers

Copy the `hooks` and `scripts` content from this repository to `.openclaw/hooks` and `.openclaw/scripts` respectively, and run:

> openclaw gateway restart

## Access Web Server from a Local Machine

On a local machine, add the following line in `~/.bashrc`

```
alias nanobible="open http://$(getent hosts ubuntu.local | awk '{print $1}'):33355"
```

## Configure Custom MCP

Confiure mcp auth token:

Run `ai -ec`, then assign a value to `BIBLEMATE_STATIC_TOKEN`, e.g. `testing` for use in the following example:

Run:

```
cd
mkdir .mcporter
cd .mcporter/
micro mcporter.json
```

Add the following content to the file `mcporter.json`:

Remarks: Replace the token `testing` with your own.

```
{
  "mcpServers": {
    "biblemate": {
      "baseUrl": "http://localhost:33334/mcp/",
      "headers": {
        "Authorization": "Bearer testing"
      }
    }
  },
  "imports": []
}
```

Run:

```
openclaw gateway restart
```

# Create a New Agent and Workspace

`Disable` the telegram bot privacy setinng by sending `/setprivacy` in @BotFather chat and follows the instruction.

Assuming you have installed the [custom skill](openclaw.md#install-custom-skills) `isolated-agent-creator`:

1. Create a telegram group
2. Add the main agent in the group
3. In the newly created group, ask the main agent `What is the current group id`. Copy the group id, e.g. -5888888888.
4. Install bible study skill for OpenClaw, run:

```
biblematemcpskill -o
```

5. In the main againt chat, send the following message:

```
I created a new Telegram group, with a group id -5888888888. I want you to create an isolated agent bible-study and bind it to that group, so I can talk to the bible-study agent in the group. Configure the bible-study agent to use model `google-gemini-cli/gemini-3-flash-preview`.
```