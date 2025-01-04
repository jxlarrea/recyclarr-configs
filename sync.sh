#!/bin/bash

SCRIPT_PATH=$(dirname "$0")
cd "$SCRIPT_PATH"/includes/custom_formats

./update.sh

recyclarr sync
