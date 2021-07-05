#!/bin/bash

# Change directory.
ScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$ScriptDir"

# Enable strict mode.
set -u -o pipefail

PACKAGES="$(pwd)/packages"
CHARTS="$(pwd)/charts"
REPOSITORY_URL="https://raw.githubusercontent.com/Pepsi1k/some-food/master"

chartPath="${1:-}"

if [ -z $chartPath ]; then 
  echo "$0 <chart_path>"
  exit 
fi

helm package "$CHARTS/*" -d "$PACKAGES/*"

helm repo index --url $REPOSITORY_URL --merge index.yaml .
