#!/usr/bin/env bash
set -euo pipefail

# Change to the redo directory where docs.json is located
cd "$BUILD_WORKSPACE_DIRECTORY/redo"

# Run mint with all provided arguments
# If no arguments provided, default to "dev"
if [ $# -eq 0 ]; then
    mint dev
else
    mint "$@"
fi
