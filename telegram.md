# Telegram Setup

## Create a Bot Token

Generate a bot token via the Telegram app:

1. Search for **@BotFather**
2. Enter: `/start`
3. Enter: `/newbot`
4. Enter a bot name, e.g. `MyBot`
5. Enter a bot username, e.g. `mybot_bot`

Then, in the OpenClaw web UI, configure the bot token.

## Pairing

After configuring the Telegram bot token, search for your bot (e.g. `@mybot_bot`) from a regular Telegram account and send `Hello` to get a pairing code. Then approve it:

```bash
openclaw pairing approve telegram <PAIRING_CODE>
```

## Create a Telegram Group with a Dedicated Agent and Workspace

This lets you isolate the agent's memory and select the most appropriate model for the task.

Assuming you have installed the [custom skill](openclaw.md#install-custom-skills) `isolated-agent-creator`:

1. Ask the main agent to create a new agent with a dedicated workspace.
2. Disable privacy mode for the bot in the **@BotFather** chat so the bot can read all messages in the group:

   ```
   /setprivacy
   @mybot_bot
   Disable
   ```

3. Create a new Telegram group.
4. Add the bot to the group.
5. In the **newly created group chat**, send: `@mybot_bot What is the current group id?`

Trouble-shooting: The bot does not response in the new group. Ask the main agent to change the groupPolicy to "open" temporarily. Messages are being received but skipped with reason "not-allowed" even after changing to groupPolicy: "open". This suggests the gateway may need a full restart (not just hot reload). Ask the main agent to check the logs if it can find the newly created group id:

 Group ID: -5219211952                                                          
 Title: "Image Generation"

6. Copy the group ID from the bot's reply.
7. In the **main agent chat** (not the group chat), ask the main agent to bind the newly created agent to the group using the ID from the previous step, e.g.:

```
I created a new Telegram group, with a group id -5888888888. I want you to create an isolated agent image-generator and bind it to that group, so I can talk to the image-generator agent in the group. Configure the image-generator agent to use model `google-antigravity/gemini-3-pro-high`.
```

8. Specify the model to use for the agent in the group chat.