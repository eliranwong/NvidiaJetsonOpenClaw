# Install Basic Tools

## Update

```
sudo apt update && sudo apt full-upgrade
sudo reboot
```

## Install Common Tools

Install tools suggested at https://github.com/eliranwong/MultiAMDGPU_AIDev_Ubuntu/blob/main/ubuntu_desktop/basic.md#basic-tools--libraries , according to your own needs

## Install Node.js

https://nodejs.org/en/download

## Install Linux Homebrew

https://brew.sh/

1. Execute the command line displayed at the top of the page.

2. Run the following script:

```
# set path
echo >> ~/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
# opt out analytics
export HOMEBREW_NO_ANALYTICS=1
echo "export HOMEBREW_NO_ANALYTICS=1" >> ~/.bashrc
# Test
which brew
```

## Install Dependencies for OpenClaw and its Builtin SKILLs

```bash
npm install -g mcporter@latest
npm install -g clawhub@latest
npm install -g @steipete/summarize@latest
npm install -g @mariozechner/pi-ai@latest
```

## Install Ollama

Read https://ollama.com/, and run:

> curl -fsSL https://ollama.com/install.sh | sh

> ollama pull paraphrase-multilingual