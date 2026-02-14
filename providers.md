# Providers

Edit `~/.openclaw/openclaw.json` to add the following configuration:

Important: To use Azure Claude & OpenAI Models, replace `<your_resource_name>`, `<your_api_key>` and `<username>` with your actual values.

```
  "models": {
    "providers": {
      "azure-openai-responses": {
        "baseUrl": "https://<your_resource_name>.openai.azure.com/openai/v1",
        "apiKey": "<your_api_key>",
        "api": "openai-responses",
        "headers": {
          "api-key": "<your_api_key>"
        },
        "authHeader": false,
        "models": [
          {
            "id": "gpt-5.2-codex",
            "name": "GPT-5.2-Codex (Azure)",
            "reasoning": true,
            "input": [
              "text",
              "image"
            ],
            "cost": {
              "input": 0,
              "output": 0,
              "cacheRead": 0,
              "cacheWrite": 0
            },
            "contextWindow": 400000,
            "maxTokens": 16384,
            "compat": {
              "supportsStore": false
            }
          },
          {
            "id": "gpt-5.2",
            "name": "GPT-5.2 (Azure)",
            "reasoning": false,
            "input": [
              "text",
              "image"
            ],
            "cost": {
              "input": 0,
              "output": 0,
              "cacheRead": 0,
              "cacheWrite": 0
            },
            "contextWindow": 272000,
            "maxTokens": 16384,
            "compat": {
              "supportsStore": false
            }
          }
        ]
      },
      "anthropic": {
        "baseUrl": "https://<your_resource_name>.services.ai.azure.com/anthropic",
        "apiKey": "<your_api_key>",
        "api": "anthropic-messages",
        "headers": {
          "api-key": "<your_api_key>"
        },
        "authHeader": false,
        "models": [
          {
            "id": "claude-opus-4-5",
            "name": "Claude Opus 4.5 (Azure)",
            "reasoning": true,
            "input": [
              "text",
              "image"
            ],
            "cost": {
              "input": 0,
              "output": 0,
              "cacheRead": 0,
              "cacheWrite": 0
            },
            "contextWindow": 200000,
            "maxTokens": 64000
          },
          {
            "id": "claude-sonnet-4-5",
            "name": "Claude Sonnet 4.5 (Azure)",
            "reasoning": true,
            "input": [
              "text",
              "image"
            ],
            "cost": {
              "input": 0,
              "output": 0,
              "cacheRead": 0,
              "cacheWrite": 0
            },
            "contextWindow": 200000,
            "maxTokens": 64000
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-opus-4-5"
      },
      "models": {
        "azure-openai-responses/gpt-5.2-codex": {},
        "anthropic/claude-opus-4-5": {
          "params": {
            "cacheRetention": "long"
          }
        },
        "anthropic/claude-sonnet-4-5": {
          "params": {
            "cacheRetention": "long"
          }
        },
        "google-antigravity/claude-opus-4-6-thinking": {},
        "google-antigravity/claude-sonnet-4-5-thinking": {},
        "google-antigravity/claude-sonnet-4-5": {},
        "google-antigravity/gemini-3-pro-high": {},
        "google-antigravity/gemini-3-pro-low": {},
        "google-antigravity/gemini-3-flash": {},
        "google-antigravity/gpt-oss-120b-medium": {}
      },
      "workspace": "/home/<username>/.openclaw/workspace",
      "compaction": {
        "mode": "safeguard"
      },
      "maxConcurrent": 4,
      "subagents": {
        "maxConcurrent": 8
      }
    }
  },
```

Remarks:

- The `username` in the `workspace` path is the Linux username on the machine where OpenClaw is running.
- Either use "azure-openai-responses/gpt-5.2-codex": {}, or "azure-openai-responses/gpt-5.2": {}, but not both, in agent settings.
- Change the "api" of "azure-openai-responses" to "openai-completions" when using gpt-5.2, [read more ...](https://github.com/openclaw/openclaw/discussions/13307)