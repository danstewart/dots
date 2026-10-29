Maps to `~/.pi`

## Setup

```bash
# Install extensions
pi install npm:@gotgenes/pi-permission-system
pi install npm:pi-permission-classifier
pi install npm:pi-open-tui
pi install npm:pi-hermes-memory
pi install https://github.com/ayghri/i-have-adhd
pi install npm:pi-mermaid

# Install plannotator
curl -fsSL https://plannotator.ai/install.sh | bash

# Set up permission judge
ollama pull qwen3:4b-instruct
```

The judge model `qwen3-judge` (4B instruct, 16k context, temp 0) is built from
`config/pi/agent/extensions/pi-permission-classifier/Modelfile.judge` by the `andThen`
hook in `config.json`, so `./links.pl pi` creates it. The classifier points at
`ollama/qwen3-judge` in `~/.pi/agent/models.json`, which must list the model or every
ask defers with `model-unresolved`.
