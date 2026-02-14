# Install OpenClaw

Then install OpenClaw:

```bash
npm install -g openclaw@latest
openclaw onboard --install-daemon
```

## Configure AI Backends

Select your AI backend during onboard. For Google, choose **Google Antigravity**.

Tips: Connect a bluetooth keyboard and a mouse to your Pixel Phone to make the authentication process easier:
1. Click the url provided by the onboard process in the Chrome browser on your Pixel Phone.
2. Authenticate with your Google account.
3. Click the "Allow" button to allow OpenClaw to access your Google account.
4. Then, the browser will fail to load the page. This is expected. Don't close the browser yet. 
5. Copy the url from the address bar and paste it in the terminal where you ran the onboard command.
6. Press Enter.
7. The authentication process will complete.

## Configure Providers (Azure OpenAI & Anthropic)

Set up [Providers](providers.md) according to your needs.

## Gateway

Set up [Telegram](telegram.md) as the messaging gateway.

## Skills

Select skills according to your needs. Some skills require their own API keys:

- [Google Places](google_ai_plan.md)
- [Nano Banana](google_ai_plan.md)
- [Notion API](https://www.notion.com/my-integrations)

## Gateway Token

Pay attention to the gateway token displayed at the end of the installation process — it is different from the Telegram bot token.

1. Open `http://127.0.0.1:18789/` Chrome browser on your Pixel Phone.
2. Go to the `Overview` tab.
3. Enter the Gateway Token.
4. Click on the `Connect` button.

### Install like an Android App

1. Select `Add to home screen` in the Chrome browser menu on your Pixel Phone.
2. Select `Install` in the dialog that appears.