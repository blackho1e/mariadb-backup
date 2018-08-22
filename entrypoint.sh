#!/bin/bash
set -e

if [ -n "$MYSQL_PORT_3306_TCP" ]; then
    if [ -z "$MYSQL_HOST" ]; then
      MYSQL_HOST='mysql'
    else
      echo >&2 'warning: both MYSQL_HOST and MYSQL_PORT_3306_TCP found'
      echo >&2 "  Connecting to MYSQL_HOST ($MYSQL_HOST)"
      echo >&2 '  instead of the linked mysql container'
    fi
fi

if [ -z "$MYSQL_HOST" ]; then
    echo >&2 'error: missing MYSQL_HOST and MYSQL_PORT_3306_TCP environment variables'
    echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
    echo >&2 '  with -e MYSQL_HOST=hostname?'
    exit 1
fi

if [ $1 = "go-cron" ]; then
	if [ -z "$SCHEDULE" ]; then
		echo Missing SCHEDULE environment variable 2>&1
		echo Example -e SCHEDULE=\"\*/10 \* \* \* \* \*\" 2>&1
		exit 1
	fi
	exec go-cron -s "${SCHEDULE}" -- backuptool ${ARGS}
fi

exec "$@"
