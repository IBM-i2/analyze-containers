#!/usr/bin/env bash
# i2, i2 Group, the i2 Group logo, and i2group.com are trademarks of N.Harris Computer Corporation.
# © N.Harris Computer Corporation (2022-2023)
#
# SPDX short identifier: MIT

. /opt/db-scripts/environment.sh
. /opt/db-scripts/common_functions.sh

file_env 'DB_PASSWORD'
file_env 'DB_USERNAME'
file_env 'DB_TRUSTSTORE_PASSWORD'

set -e

TMP_SECRETS="/tmp/i2acerts"

if [[ "${DB_SSL_CONNECTION}" == "true" ]]; then
  file_env 'SSL_CA_CERTIFICATE'
  if [[ -z "${SSL_CA_CERTIFICATE}" ]]; then
    echo "Missing security environment variables. Please check SSL_CA_CERTIFICATE"
    exit 1
  fi
  CA_CER="${TMP_SECRETS}/CA.cer"

  # Create a directory if it doesn't exist
  if [[ ! -d "${TMP_SECRETS}" ]]; then
    mkdir -p "${TMP_SECRETS}"
  fi

  echo "${SSL_CA_CERTIFICATE}" >"${CA_CER}"

  cp "${CA_CER}" /etc/pki/ca-trust/source/anchors
  update-ca-trust
fi

# If user not root ensure to give correct permissions before start
if [ -n "$GROUP_ID" ] && [ "$GROUP_ID" != "0" ]; then
  if [ "$(getent group "${USER}")" ]; then
    groupmod -o -g "$GROUP_ID" "${USER}" &>/dev/null
  else
    groupadd -o -g "$GROUP_ID" "${USER}" &>/dev/null
  fi
  usermod -u "$USER_ID" -g "$GROUP_ID" "${USER}" &>/dev/null
  chown -R "${USER_ID}:0" "/opt" \
    "/etc/pki" \
    "${TMP_SECRETS}"
fi

function run_with_user() {
  exec /usr/local/bin/gosu "${USER}" "$@"
}

case "$1" in
"run-sql-query")
  run_with_user /opt/db-scripts/run_sql_query.sh "$2"
  ;;
"run-sql-query-for-db")
  run_with_user /opt/db-scripts/run_sql_query.sh "$2" "$3"
  ;;
"run-sql-file")
  run_with_user /opt/db-scripts/run_sql_file.sh "$2"
  ;;
*)
  set +e
  run_with_user "$@"
  ;;
esac
