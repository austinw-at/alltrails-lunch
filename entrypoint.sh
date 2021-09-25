#!/bin/bash
set -e

rm -f /alltrails-lunch/tmp/pids/server.pid

exec "$@"
