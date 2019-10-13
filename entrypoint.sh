#! /usr/bin/env bash

ARG_STRING=""

# Check if version flag should be set
if [ "$1" != "false" ]; then
  ARG_STRING=" --version"
fi

# Check if help flag should be set
if [ "$2" != "false" ]; then
  ARG_STRING= " -h"
fi

# Check if list all the rules
if [ "$3" != "false" ]; then
  ARG_STRING= " -L"
fi

# Check if tags flag set
if [ "$4" != "[]" ]; then
  ARG_STRING=" ${ARG_STRING} -t $4"
fi

# Check if verbose flag should be set
if [ "$5" != "false" ]; then
  ARG_STRING=" ${ARG_STRING} -v"
fi

# Check if skipList flag set
if [ "$6" != "[]" ]; then
  ARG_STRING=" ${ARG_STRING} -x $6"
fi

# Check if nocolor flag is set
if [ "$7" != "false" ]; then
  ARG_STRING=" ${ARG_STRING} --nocolor"
fi


# Check if force-color flag is set
if [ "$8" != "false" ]; then
  ARG_STRING=" ${ARG_STRING} --force-color"
fi

# Check if exclude flag is set
if [ "$9" != "[]" ]; then
  ARG_STRING=" ${ARG_STRING} --exclude=${9}"
fi

# Check if configuration flag is set
if [ "${10}" != ".salt-lint" ]; then
  ARG_STRING=" ${ARG_STRING} -c ${10}"
fi

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

if [ "${ARG_STRING}" != ""]; then

  if [ -d "${ACTION_STATE_PATH}" ]; then
    salt-lint "${ARG_STRING}" `find "${ACTION_STATE_PATH}" -type f -name init.sls`
  else
    salt-lint "${ARG_STRING}"  "${ACTION_STATE_PATH}"
  fi

else

  if [ -d "${ACTION_STATE_PATH}" ]; then
    salt-lint `find "${ACTION_STATE_PATH}" -type f -name init.sls`
  else
    salt-lint "${ACTION_STATE_PATH}"
  fi

fi

>&2 echo