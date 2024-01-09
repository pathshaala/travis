#!/bin/bash
set -eu
set -o pipefail

SCRIPT_PATH="$(dirname -- "$(readlink -f "${BASH_SOURCE}")")"
IFS=$' \t\r\n'

TRAVIS_TOKEN=""
ENV_NEW_VALUE=""

: "${TRAVIS_API:=https://travis-ci.com//api/repo}"

: "${ORG:=pathshaala}"

REPO_LIST_FILE="git-repo.list"
REPO_LIST="${SCRIPT_PATH}/${REPO_LIST_FILE}"

DATA_LIST_FILE="travis-env-var.json"
DATA_LIST="${SCRIPT_PATH}/${DATA_LIST_FILE}"

CURL_HEADERS=(-H "Content-Type: application/json" -H "Travis-API-Version: 3" -H "Authorization: token ${TRAVIS_TOKEN}")

##### To create new ENV var in travis
# 
# It will get list of vars to create from 
# DATA_LIST [file: travis-env-var.json] and 

# repo list from 
#REPO_LIST [file: git-repo.list]
#
# Then loop them 

env_create() {
  while read -r REPO
  do
    echo "### ### ### ### ### Repo: $REPO ### ### ### ### ###"
    while read DATA
    do
      echo "# Var: $DATA ###"
      curl -X POST "${TRAVIS_API}/${ORG}%2F${REPO}/env_vars" "${CURL_HEADERS[@]}" -d "${DATA}"
    done < "${DATA_LIST}"
  done < "${REPO_LIST}"
}

env_update() {
  ENV_VAR_NAME="<env name>"
  ENV_VAR_VALUE="${ENV_NEW_VALUE}"
  IS_PUBLIC="false"

  DATA="{\"env_var.value\": \"${ENV_VAR_VALUE}\", \"env_var.public\": ${IS_PUBLIC}}"

  while read -r REPO
  do
    echo "#################################### $REPO #########################################"

    TRAVIS_REPO_ENV_VARS=$(curl -X GET "${CURL_HEADERS[@]}" "${TRAVIS_API}/${ORG}%2F${REPO}/env_vars") || exit $?
    TRAVIS_REPO_ENV_VAR_ID=$(echo "${TRAVIS_REPO_ENV_VARS}" | jq -r '.env_vars[] | select(.name=="'"${ENV_VAR_NAME}"'") | .id')

    curl -X PATCH "${CURL_HEADERS[@]}" -d "${DATA}" "${TRAVIS_API}/${ORG}%2F${REPO}/env_var/$TRAVIS_REPO_ENV_VAR_ID"
  done < "${REPO_LIST}"
}

# Check command-line arguments
ACTION="${1:-}"

case $ACTION in
  "create")
    env_create
    ;;
  "update")
    env_update
    ;;
  *)
    echo "Usage: $0 {create|update}"
    exit 1
    ;;
esac
