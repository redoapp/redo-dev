#!/usr/bin/env bash
set -euo pipefail

# Use Node 22 LTS if available (mintlify requires Node < 25)
if [ -d "/opt/homebrew/opt/node@22/bin" ]; then
    export PATH="/opt/homebrew/opt/node@22/bin:/opt/homebrew/bin:$PATH"
elif [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Change to the redo directory where docs.json is located
cd "$BUILD_WORKSPACE_DIRECTORY/redo"

# Run mintlify with all provided arguments
# If no arguments provided, default to "dev"
if [ $# -eq 0 ]; then
    mintlify dev
else
    mintlify "$@"
fi
