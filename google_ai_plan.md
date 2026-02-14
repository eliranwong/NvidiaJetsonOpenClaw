# Google AI Plan and API Setup

OpenClaw supports multiple AI backends. I use Google Antigravity Models (both Gemini and Claude models) as my primary backend. Below is my setup.

## Subscribe to Google AI Pro Plan

Subscribe at https://one.google.com/about/google-ai-plans

Benefits for using it with OpenClaw:

- Offers family sharing
- Includes Antigravity usage
- Access to Claude Code models via Antigravity
- Access to Gemini 3 Pro models via Antigravity
- Optional: $10 Google Cloud service monthly credits for Vertex AI API and Gemini API

## Set Up Google Cloud Service

1. Go to **IAM & Admin** > **Service accounts** > create a service account
2. Set up billing at https://console.cloud.google.com/billing
3. Create a new project, e.g. "openclaw"

## Activate $10 Monthly Gen AI & Cloud Credits

1. Register for the Google for Developers program at https://developers.google.com/
2. Get Google AI Pro Plan benefits at https://developers.google.com/program/my-benefits
3. Activate the **$10 monthly Gen AI & Cloud credits** by linking it to your Google Cloud billing account.

## Gemini API Key

Set up a Gemini API key that uses the $10 monthly credits:

1. Go to https://aistudio.google.com
2. Sign in with your Google account (the one with your Pro Plan).
3. On the left sidebar, click **Get API key**.
4. Click **Create API key in existing project** and select the same Google Cloud project where you activated your $10 credit. This ensures your usage is tracked under your billing account rather than a free trial.
5. Copy the new key — it should start with `AIza...`.

> **Will this use my $10 monthly credit?**
> Yes. When you create the API key in Google AI Studio and link it to your Google Cloud project (the one with the credits), your usage is billed to that project. The $10 monthly credit from your Google Developer Program Premium benefit will be applied to your monthly bill.

## Set Up a Single Google API Key for OpenClaw

1. Go to **APIs & services** > **Enabled APIs & services**
2. Search for **Places API (New)** → Enable
3. Search for **Generative Language API** → Enable
4. Go to **APIs & services** > **Credentials** > **+ Create credentials** > **API key**
5. Name it `OpenClaw`
6. Under **API restrictions**, select:
   - Places API (New)
   - Generative Language API

## Generate a Service Account JSON Key for Vertex AI

1. Select a project that is linked to a billing account
2. Go to **IAM & Admin** > **Service accounts**
3. Select the billed account
4. Go to the **Keys** section
5. Click **Add Key** > **Create new key** > **JSON**

Place the JSON file in the `Documents` directory on your Pixel Phone, e.g. `Documents/credentials_google_cloud.json`