#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://vitaliy-stackbit.ngrok.io/project/5f72f678b3b5bd111244a454/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://vitaliy-stackbit.ngrok.io/pull/5f72f678b3b5bd111244a454
fi
curl -s -X POST https://vitaliy-stackbit.ngrok.io/project/5f72f678b3b5bd111244a454/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://vitaliy-stackbit.ngrok.io/project/5f72f678b3b5bd111244a454/webhook/build/publish > /dev/null
