# Groq Whisper Skill

Integrate Groq's fast speech-to-text API for instant audio transcription using `whisper-large-v3-turbo`.

## ⚡ Priority: Use This First for Audio Transcription

When transcribing audio, **always try this skill first** before other options:

1. **groq-whisper** (this skill) — Fastest, cloud-based, 25MB limit
2. **whisper-gpu** (`~/.local/bin/whisper-gpu`) — Local GPU fallback (Jetson Orin)
3. **openai-whisper-api** — Cloud fallback if others fail

Only fall back to alternatives if:
- File exceeds 25MB and can't be compressed
- `GROQ_API_KEY` is unavailable
- Groq API is unreachable

## Configuration

This skill requires the `GROQ_API_KEY` environment variable to be set.

## Tools

### `groq-whisper`

Transcribe an audio file using Groq's API.

**Usage:**
```bash
./transcribe.sh <file_path> [prompt] [language]
```

**Parameters:**
- `file_path`: Path to the local audio file.
  - Supported formats: `flac`, `mp3`, `mp4`, `mpeg`, `mpga`, `m4a`, `ogg`, `wav`, `webm`.
  - **Limit:** Max 25MB. (For larger files, use ffmpeg to compress/downsample or split first).
- `prompt` (optional): Context or spelling guidance (max 224 tokens).
- `language` (optional): ISO-639-1 language code (e.g., `en`, `fr`).

**Model:**
Defaults to `whisper-large-v3-turbo` for speed and cost-efficiency.

**Output:**
Returns JSON containing the transcription text.

## Examples

### Basic Transcription
```bash
./transcribe.sh /path/to/recording.m4a
```

### With Prompt (Context/Spelling)
```bash
./transcribe.sh /path/to/interview.mp3 "Technical interview about Kubernetes and Docker"
```

### With Language Specification
```bash
./transcribe.sh /path/to/french_audio.wav "" "fr"
```

## Tips for Large Files (>25MB)

If a file is too large, use `ffmpeg` to convert it to a lower bitrate or efficient format like FLAC/Opus before sending, or split it.

**Example Downsample:**
```bash
ffmpeg -i input.mp3 -ar 16000 -ac 1 -c:a flac output.flac
```
