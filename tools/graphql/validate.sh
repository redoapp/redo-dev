#!/usr/bin/env bash
# Validates the vendored doc model by rendering it to a throwaway directory.
# The renderer exits non-zero on any internal inconsistency.
set -euo pipefail

"$(rlocation redotech_redodev/tools/graphql/generate)" \
    --model "$(rlocation redotech_redodev/redo/api-schema-v3/v3.docs.json)" \
    --out "${TEST_TMPDIR:-/tmp}/v3-reference-validate"
