#!/usr/bin/env bash

set -eu

if [[ "${SERVICE_NAME}X" == "X" ]]; then
  echo "Error: missing SERVICE_NAME environment variable"
  exit 1
fi

TASK_ROOT=$(pwd)
[[ -d "${TASK_ROOT}/nuget" && ! -d "${HOME}/.nuget" ]] && ln -s "${TASK_ROOT}/nuget" "${HOME}/.nuget"

cd ${TASK_ROOT}/service-checkout/Tests
dotnet restore
dotnet test
