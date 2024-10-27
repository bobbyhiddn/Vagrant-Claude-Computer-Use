#!/bin/sh
set -ex

# Prompt for API key if not already set
if [ -z "$ANTHROPIC_API_KEY" ]; then
  read -p "Enter your Anthropic API Key: " ANTHROPIC_API_KEY
fi

# Save the API key to environment file
echo "export ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY" | sudo tee -a /etc/bash.bashrc

# Create the Docker command script
cat << 'EOF' > /home/ubuntu/claude-start.sh
#!/bin/sh
set -e

# Check for required environment variable
if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "Error: ANTHROPIC_API_KEY is not set. Please set it in /etc/bash.bashrc or prompt for input."
  exit 1
fi

# Pull the Docker image (if not already pulled) and run the container
echo "Starting Docker container for Claude demo..."
docker pull ghcr.io/anthropics/anthropic-quickstarts:computer-use-demo-latest
docker run -e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
    -v "$HOME/.anthropic:/home/computeruse/.anthropic" \
    -p 5900:5900 -p 8501:8501 -p 6080:6080 -p 8080:8080 \
    ghcr.io/anthropics/anthropic-quickstarts:computer-use-demo-latest --platform linux/amd64 &

# Wait briefly to allow the container to initialize
sleep 5

# Launch Chrome to access the Claude demo
echo "Opening Chrome to access Claude demo..."
nohup google-chrome-stable http://localhost:8080 &
EOF

# Make the script executable
chmod +x /home/ubuntu/claude-start.sh

# Create a symlink in /usr/local/bin to make it easily runnable
sudo ln -sf /home/ubuntu/claude-start.sh /usr/local/bin/claude-start
