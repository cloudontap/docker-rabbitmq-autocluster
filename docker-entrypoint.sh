#!/bin/bash

set -e

# TODO: Add clean shutdown of the rabbit server
term_handler() {
  exit 0;
}

trap 'term_handler' SIGTERM SIGKILL

# Ensure the Erlang cookie is present so all nodes use the same cookie
# Specific value can be passed in via ERLANG_COOKIE variable assuming
# cookie file doesn't already exist
COOKIE_FILE="${HOME}/.erlang.cookie"
if [[ ! -f ${COOKIE_FILE} ]]; then
    if [[ "${ERLANG_COOKIE}" != "" ]]; then
        echo -n "${ERLANG_COOKIE" > ${COOKIE_FILE}
    else
        echo -n OYEINYOQTKHEALXSENUK > ${COOKIE_FILE}
    fi
fi

# Ensure our hostname matches the private dns entry for the docker host
export HOSTNAME="ip-$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4 | tr '.' '-')"
hostname ${HOSTNAME}

gosu rabbit exec "$@" &

while true
do
  tail -f /dev/null & wait ${!}
done
