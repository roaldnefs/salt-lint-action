#! /usr/bin/env bash

set -eo pipefail
set -x

ACTION_STATE_NAME="${ACTION_STATE_NAME:-init.sls}"

set -u

cd "${GITHUB_WORKSPACE}"

ACTION_STATE_PATH="${GITHUB_WORKSPACE}/${ACTION_STATE_NAME}"

if [ ! -f "${ACTION_STATE_PATH}" -a ! -d "${ACTION_STATE_PATH}" ]; then
  >&2 echo "==> Can't find '${ACTION_STATE_PATH}'.
    Please ensure to set up ACTION_STATE_NAME env var
    relative to the root of your project."
  exit 1
fi

>&2 echo
>&2 echo "==> Linting ${ACTION_STATE_PATH}…"

if [ -d "${ACTION_STATE_PATH}" ]; then
  salt-lint `find "${ACTION_STATE_PATH}" -type f -name *.sls`
else
  salt-lint "${ACTION_STATE_PATH}"
fi

>&2 echo