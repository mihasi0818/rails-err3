#!/bin/bash
set -e

rm -f /dnprp-app/tmp/pids/server.pid

exec "$@"
