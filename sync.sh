#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Define the path to the subscript (relative to the script directory)
SUBSCRIPT_DIR="$SCRIPT_DIR/includes/custom_formats"
SUBSCRIPT="$SUBSCRIPT_DIR/update.sh"

# Check if the subscript exists
if [[ -f "$SUBSCRIPT" ]]; then
    echo "Running subscript: $SUBSCRIPT"
    # Run the subscript
    cd "$SUBSCRIPT_DIR"
    bash "$SUBSCRIPT"
else
    echo "Error: Subscript not found at $SUBSCRIPT"
    exit 1
fi

# Run the "recyclarr sync" command after the subscript
echo "Running 'recyclarr sync'..."

recyclarr sync
