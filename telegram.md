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
6. Copy the group ID from the bot's reply.
7. In the **main agent chat** (not the group chat), ask the main agent to bind the newly created agent to the group using the ID from the previous step, e.g.:

```
I created a new Telegram group, with a group id -5888888888. I want you to create an isolated agent image-generator and bind it to that group, so I can talk to the image-generator agent in the group. Configure the image-generator agent to use model `google-antigravity/gemini-3-pro-high`.
```

8. Specify the model to use for the agent in the group chat.

### Trouble-shooting - No Response to the Group ID Query

This issue happens when `channels.telegram.groupPolicy` is set to `allowlist`.

In the **newly created group chat**, ask:

> `@mybot_bot What is the current group id?`

The bot does not response in the new group abou the group id, as the messages are being received but skipped with reason "not-allowed" even after changing to groupPolicy: "open".

Solution:

1. In the main agent chat, send, e.g.:

> I created a new Telegram group "Personal Assistant".  I asked you there about the group id, without a response. Please check the logs for me to retrieve the group id.

2. Copy the retrieved group, e.g. -5888888888, id for the next step.

3. In the main agent chat, send, e.g.:

> Please add the Telegram group (group id -5888888888) to the channels.telegram.groups in openclaw.json, to allow messages in the group. Create an isolated agent personal-assistant and bind it to that group, so I can talk to the personal-assistant agent in the group. Configure the personal-assistant agent to use model `google-gemini-cli/gemini-3-flash-preview`.