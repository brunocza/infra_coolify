#!/bin/sh
set -e

# Output debug information
echo "Starting git-sync with SSH key setup"

# Write SSH key to file from environment variable
if [ -n "$GIT_SSH_KEY" ]; then
  echo "Setting up SSH key from environment variable"
  echo "$GIT_SSH_KEY" | base64 -d > /etc/git-secret/id_rsa
  chmod 600 /etc/git-secret/id_rsa
  echo "SSH key set up successfully at /etc/git-secret/id_rsa"
  ls -la /etc/git-secret/
else
  echo "No SSH key provided in environment variable GIT_SSH_KEY"
  exit 1
fi

# Set up Git configuration for SSH
git config --global core.sshCommand "ssh -i /etc/git-secret/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

# Print all environment variables for debugging (hide sensitive data)
echo "Environment variables set (hiding sensitive values):"
env | grep -v "KEY" | grep -v "PASSWORD" | grep -v "SECRET"

# Run the original git-sync command
echo "Starting git-sync process"
exec /git-sync
