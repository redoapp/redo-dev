#!/usr/bin/env bash
set -euo pipefail

echo "============================================"
echo "Validating OpenAPI Specification"
echo "============================================"
echo ""

# Find the OpenAPI file in the runfiles
# In Bazel test context, files are in the runfiles directory
if [ -n "${TEST_SRCDIR:-}" ]; then
    OPENAPI_FILE="$TEST_SRCDIR/redotech_redodev/redo/api-schema/openapi.yaml"
else
    # Fallback for when running outside test context
    OPENAPI_FILE="$(dirname "$0")/../../redo/api-schema/openapi.yaml"
fi

if [ ! -f "$OPENAPI_FILE" ]; then
    echo "❌ ERROR: OpenAPI file not found"
    echo "Expected at: $OPENAPI_FILE"
    echo "TEST_SRCDIR: ${TEST_SRCDIR:-not set}"
    exit 1
fi

echo "📄 Validating: redo/api-schema/openapi.yaml"
echo ""

# Run mint openapi-check
# Note: We need to create a temp directory structure for mint to work
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

mkdir -p "$TEMP_DIR/redo/api-schema"
cp "$OPENAPI_FILE" "$TEMP_DIR/redo/api-schema/openapi.yaml"

cd "$TEMP_DIR/redo"
if mintlify openapi-check api-schema/openapi.yaml 2>&1; then
    echo ""
    echo "✅ SUCCESS: OpenAPI specification is valid and conforms to the OpenAPI standard."
    exit 0
else
    EXIT_CODE=$?
    echo ""
    echo "============================================"
    echo "❌ VALIDATION FAILED"
    echo "============================================"
    echo ""
    echo "The OpenAPI specification is out of spec and does not conform to the OpenAPI standard."
    echo ""
    echo "To fix this:"
    echo "1. Review the validation errors above"
    echo "2. Make necessary changes in redo/api-schema/src/ files (NOT openapi.yaml directly)"
    echo "3. Run 'bazel run openapi_gen' to regenerate the OpenAPI file"
    echo "4. Run 'bazel run docs -- openapi-check api-schema/openapi.yaml' to validate locally"
    echo ""
    exit $EXIT_CODE
fi
