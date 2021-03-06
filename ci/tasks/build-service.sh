#!/usr/bin/env bash

set -eu

if [[ "${SERVICE_NAME}X" == "X" ]]; then
  echo "Error: missing SERVICE_NAME environment variable"
  exit 1
fi

if [ ! -f "version/number" ]; then
  echo "Error: version file does not exist"
  exit 1
fi

version=`cat version/number`
if [[ "${version}X" == "X" ]]; then
  echo "Error: version number is empty"
  exit 1
fi

TASK_ROOT=$(pwd)
[[ -d "${TASK_ROOT}/nuget" && ! -d "${HOME}/.nuget" ]] && ln -s "${TASK_ROOT}/nuget" "${HOME}/.nuget"

cd ${TASK_ROOT}/service-checkout/${SERVICE_NAME}
dotnet restore
dotnet publish -c Release /property:PublishWithAspNetCoreTargetManifest=false

cd bin/Release/netcore*
tar -czvf ${SERVICE_NAME}-${version}.tgz publish
cp *.tgz ${TASK_ROOT}/service-build
ls ${TASK_ROOT}/service-build
