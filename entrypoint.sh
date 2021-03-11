#! /usr/bin/env bash

set -eo pipefail
set -x

ACTION_STATE_NAME="${ACTION_STATE_NAME:-init.sls}"
ACTION_STATE_FIND_PATTERN="${ACTION_FIND_PATTERN:-*.sls}"
ACTION_STATE_FIND_TYPE="${ACTION_FIND_TYPE:-name}"
SALT_LINT_EXTRA_PARAMS="${SALT_LINT_EXTRA_PARAMS}"

set -u

cd "${GITHUB_WORKSPACE}"

ACTION_STATE_PATH="${GITHUB_WORKSPACE}/${ACTION_STATE_NAME}"

if [ ! -f "${ACTION_STATE_PATH}" -a ! -d "${ACTION_STATE_PATH}" -a -z "${ACTION_STATE_FIND_PATH}" ]; then
  >&2 echo "==> Can't find '${ACTION_STATE_PATH}' and ACTION_STATE_FIND_PATH is not set.
    Please ensure to set up ACTION_STATE_NAME env var
    relative to the root of your project."
  exit 1
fi

>&2 echo

if [ -n "${ACTION_STATE_PATH}" ]; then
  >&2 echo "==> Linting ${ACTION_STATE_FIND_PATH} for files ${ACTION_STATE_FIND_PATTERN}…"
  salt-lint ${SALT_LINT_EXTRA_PARAMS} `find "${ACTION_STATE_FIND_PATH}" -type f -${ACTION_STATE_FIND_TYPE} "${ACTION_STATE_FIND_PATTERN}"`
elif [ -d "${ACTION_STATE_PATH}" ]; then
  >&2 echo "==> Linting ${ACTION_STATE_PATH}…"
  salt-lint ${SALT_LINT_EXTRA_PARAMS} `find "${ACTION_STATE_PATH}" -type f -${ACTION_STATE_FIND_TYPE} "${ACTION_STATE_FIND_PATTERN}"`
else
  salt-lint ${SALT_LINT_EXTRA_PARAMS} "${ACTION_STATE_PATH}"
fi

>&2 echo
