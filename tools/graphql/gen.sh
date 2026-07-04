#!/usr/bin/env bash
# Regenerates the v3 GraphQL reference MDX into the source tree and patches the
# v3 reference nav in docs.json.
set -euo pipefail

"$(rlocation redotech_redodev/tools/graphql/generate)" \
    --model "$(rlocation redotech_redodev/redo/api-schema-v3/v3.docs.json)" \
    --out "$BUILD_WORKSPACE_DIRECTORY/redo/docs/api-reference/v3/reference" \
    --docs-json "$BUILD_WORKSPACE_DIRECTORY/redo/docs.json"
