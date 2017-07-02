#!/usr/bin/env bash
set -x

# Available environment variables
#
# DEVPI_HOST
# DEVPI_PASSWORD
# DEVPI_PORT

export DEVPI_SERVERDIR=/data/server
export DEVPI_CLIENTDIR=/data/client

mkdir -p $DEVPI_SERVERDIR
mkdir -p $DEVPI_CLIENTDIR

devpi-server --init
devpi-server --start
devpi login root --password=''
devpi user -m root password="$DEVPI_PASSWORD"
devpi index -y -c public pypi_whitelist='*'
devpi-server --stop
devpi-server --host $DEVPI_HOST --port $DEVPI_PORT
