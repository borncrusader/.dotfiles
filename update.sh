#!/bin/bash

# bail out on first error
set -euo pipefail

# macos specific
if [ "$(uname)" = 'Darwin' ]; then
    ./homebrew/run.sh update consolidate
fi
