#!/usr/bin/env bash

set -eu

if [[ "${SERVICE_NAME}X" == "X" ]]; then
  echo "Error: missing SERVICE_NAME environment variable"
  exit 1
fi

if [ -f "version/number" ]; then
  version=`cat version/number`
fi

inArtifact=`basename candidate-release/*.tgz`

tar -xzv -C service-deploy -f candidate-release/${inArtifact}

cp service-checkout/manifest.yml service-deploy

sed -i "s|path: .*$|path: publish|g" service-deploy/manifest.yml
if [ ! -z "${SERVICE_HOST}" ]; then
  sed -i "s|host: .*$|host: ${SERVICE_HOST}|g" service-deploy/manifest.yml
fi

cat service-deploy/manifest.yml
