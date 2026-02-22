# Gog CLI

Openclaw can use gog CLI for managing some Google account API services.

To set up gog CLI authentication, you need to create a project in the Google Cloud Console and download a credentials file. Here is the step-by-step guide:

1. Create Google Cloud Credentials

i. Go to the Google Cloud Console (https://console.cloud.google.com/).
ii. Create a new project (e.g., "My OpenClaw Assistant").
iii. Go to APIs & Services > Library and enable the following APIs (depending on what you want to use):

  • Gmail API
  • Google Calendar API
  • Google Drive API
  • Google Sheets API
  • Google Docs API

iv. Go to APIs & Services > OAuth consent screen:  • Choose External.
  • Fill in the required app info (your email, etc.).
  • Add the scopes for the APIs you enabled (e.g., .../auth/gmail.modify, .../auth/calendar).
  • Important: Add your own email address to the Test users list.

v. Go to APIs & Services > Credentials:  • Click Create Credentials > OAuth client ID.
  • Select Desktop App as the application type.
  • Download the JSON file and save it to your machine (e.g., ~/credentials.json).

2. Configure the CLI

Now, run these commands in your terminal:

Set the master credentials:

> gog auth credentials ~/credentials.json

Add your account:
Run this command, then follow the link in your browser to authorize it.

> gog auth add your-email@gmail.com --services gmail,calendar,drive,contacts,docs,sheets

Verify the setup:

> gog auth list

3. Pro-Tip

To save yourself from typing your email every time, you can set an environment variable in your .bashrc or .zshrc:

> export GOG_ACCOUNT="your-email@gmail.com"

## Details about the scopes

To set up gog properly, you should add the following scopes in your GCP project (under APIs & Services > OAuth consent screen > Scopes):

Core Scopes (Recommended):

• https://www.googleapis.com/auth/gmail.modify (Allows reading, sending, and deleting mail)
• https://www.googleapis.com/auth/calendar (Full access to calendars)
• https://www.googleapis.com/auth/drive (Full access to Drive files)
• https://www.googleapis.com/auth/contacts (Full access to contacts)
• https://www.googleapis.com/auth/spreadsheets (Full access to Sheets)
• https://www.googleapis.com/auth/documents (Full access to Docs)
If you want to be more restrictive, you can use these instead:

• .../auth/gmail.readonly (Read-only mail)
• .../auth/gmail.send (Send-only mail)
• .../auth/calendar.events.readonly (View calendar events only)

When you've added them, make sure to save the consent screen settings and then run the auth command in your terminal:

> gog auth add your-email@gmail.com --services gmail,calendar,drive,contacts,docs,sheets