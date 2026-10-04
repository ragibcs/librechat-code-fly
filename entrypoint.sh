#!/bin/sh
set -eu

echo "LibreChat remote Code worker"
echo "Worker starts only when LIBRECHAT_CODE_SANDBOX_ENDPOINT is configured."

if [ -z "${LIBRECHAT_CODE_SANDBOX_ENDPOINT:-}" ]; then
  echo "ERROR: LIBRECHAT_CODE_SANDBOX_ENDPOINT is not set."
  echo "Pair this machine from LibreChat Settings > Code environments > Connect VM."
  exit 1
fi

exec librechat-code "$@"
