#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")

SUBSCRIPT_DIR="$SCRIPT_DIR/includes/custom_formats"
SUBSCRIPT="$SUBSCRIPT_DIR/update.sh"

if [[ -f "$SUBSCRIPT" ]]; then
    chmod +x "$SUBSCRIPT"
    echo "Running subscript: $SUBSCRIPT"
    cd "$SUBSCRIPT_DIR"
    bash "$SUBSCRIPT"
else
    echo "Error: Subscript not found at $SUBSCRIPT"
    exit 1
fi

echo "Running 'recyclarr sync'..."

recyclarr sync
