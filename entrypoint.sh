#!/bin/sh
set -eu

echo "======================================"
echo " LibreChat Code Interpreter Worker"
echo "======================================"

if [ -z "${LIBRECHAT_CODE_SANDBOX_ENDPOINT:-}" ]; then
    echo ""
    echo "ERROR:"
    echo "LIBRECHAT_CODE_SANDBOX_ENDPOINT is not configured."
    echo ""
    echo "Pair this machine from:"
    echo "LibreChat -> Settings -> Code environments -> Connect VM"
    echo ""
    exit 1
fi

echo "Sandbox endpoint:"
echo "${LIBRECHAT_CODE_SANDBOX_ENDPOINT}"

cd /app/code-interpreter

# Show available commands from the checked-out repository.
if [ -f package.json ]; then
    echo "Available npm scripts:"
    npm run 2>/dev/null || true
fi

# The exact remote-worker command is release-dependent.
# Prefer the repository's documented CLI when available.
if npm run | grep -q "worker"; then
    exec npm run worker
fi

if npm run | grep -q "bridge"; then
    exec npm run bridge
fi

echo ""
echo "ERROR: No worker/bridge npm script was found."
echo "Inspect the current Code Interpreter release before starting."
exit 1
