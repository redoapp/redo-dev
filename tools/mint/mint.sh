#!/usr/bin/env bash
set -euo pipefail

# Change to the redo directory where docs.json is located
cd "$BUILD_WORKSPACE_DIRECTORY/redo"

# Get the path to the mintlify binary
MINTLIFY_BIN="$(dirname $0)/mintlify_bin"

# Run mintlify with all provided arguments
# If no arguments provided, default to "dev"
if [ $# -eq 0 ]; then
    exec "$MINTLIFY_BIN" dev
else
    exec "$MINTLIFY_BIN" "$@"
fi
