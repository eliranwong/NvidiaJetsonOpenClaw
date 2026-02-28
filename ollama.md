## Install Ollama

Read https://ollama.com/, and run:

> curl -fsSL https://ollama.com/install.sh | sh

> ollama pull paraphrase-multilingual

# Activate Ollama Cloud

Subscribe to a cloud plan at https://ollama.com/pricing

```
ollama signin
ollama launch openclaw --config
```

Read more at https://docs.ollama.com/integrations/openclaw

# Enable OpenClaw to use Ollama web search

Copy the signature key from /usr/share/ollama/.ollama/id_ed25519 to ~/.ollama/

```
sudo cp /usr/share/ollama/.ollama/id_ed25519 ~/.ollama/
sudo chown $USER:$USER ~/.ollama/id_ed25519
chmod 600 ~/.ollama/id_ed25519
```