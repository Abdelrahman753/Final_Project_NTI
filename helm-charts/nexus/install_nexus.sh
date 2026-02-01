#!/bin/bash
SCRIPTDIR=`dirname $(readlink -f $0)`
set +x
set -e
APP_NAME_SPACE="nexus"



hhelm repo add stevehipwell https://stevehipwell.github.io/helm-charts/ --force-update 

helm upgrade -i nexus stevehipwell/nexus -n "${APP_NAME_SPACE}" \
           -f  values.yaml --version 5.18.0 --debug
