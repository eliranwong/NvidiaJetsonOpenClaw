# Install OpenClaw

Then install OpenClaw:

```bash
npm install -g openclaw@latest
openclaw onboard --install-daemon
```

## Add AI Provider Plugins

Read https://docs.openclaw.ai/concepts/model-providers#google-vertex-antigravity-and-gemini-cli

For Google Antigravity:

```
openclaw plugins enable google-antigravity-auth
openclaw gateway restart
openclaw models auth login --provider google-antigravity --set-default
openclaw gateway restart
```

For Gemini CLI:

```
openclaw plugins enable google-gemini-cli-auth
openclaw gateway restart
openclaw models auth login --provider google-gemini-cli --set-default
openclaw gateway restart
```

## Auth

1. Click the url provided by the onboard process in the Chrome browser on your Pixel Phone.
2. Authenticate with your Google account.
3. Click the "Allow" button to allow OpenClaw to access your Google account.
4. Then, the browser will fail to load the page. This is expected. Don't close the browser yet. 
5. Copy the url from the address bar and paste it in the terminal where you ran the onboard command.
6. Press Enter.
7. The authentication process will complete.

## Configure Azure OpenAI & Claude Models

Set up [Providers](providers.md) according to your needs.

Optional Remove the "models" entry under the main agent and sub-agents, as they limit model selection if the list provided is not exhaustive.

> openclaw gateway restart

## Gateway

Set up [Telegram](telegram.md) as the messaging gateway.

## Skills

Select skills according to your needs. Some skills require their own API keys:

- [Google Places](google_ai_plan.md)
- [Nano Banana](google_ai_plan.md)
- [Notion API](https://www.notion.com/my-integrations)

## Install Custom Skills

```
git clone https://github.com/eliranwong/NvidiaJetsonOpenClaw
cp -r NvidiaJetsonOpenClaw/skills ~/.openclaw/
rm ~/.openclaw/skills/README.md
openclaw gateway restart
```

# Enable Web Search

Create a Brave Search API Key at https://api-dashboard.search.brave.com/app/keys

> openclaw configure --section web

- Enable web_search -> Yes
- Enable web_fetch -> Yes

## Access from Local Machine

> ssh username@ubuntu.local

> openclaw tui