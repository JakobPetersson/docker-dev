#!/usr/bin/env bash

set -e

COMPOSE_PATH="$( cd "$(dirname "$0")" ; pwd -P )/docker-compose.yml"

build() {
  echo "Building"
  docker-compose -f "$COMPOSE_PATH" build
}

start() {
  echo "Starting"
  docker-compose -f "$COMPOSE_PATH" up -d --remove-orphans
}

stop() {
  echo "Stopping"
  docker-compose -f "$COMPOSE_PATH" stop
}

remove() {
  stop
  echo "Removing"
  docker-compose -f "$COMPOSE_PATH" rm -f
}

reset() {
  build
  remove
  start
}

logs() {
  echo "Logs"
  docker-compose -f "$COMPOSE_PATH" logs -f
}

for arg in "$@"; do
  if [ "$arg" == "build" ]; then
    build
  elif [ "$arg" == "start" ]; then
    start
  elif [ "$arg" == "stop" ]; then
    stop
  elif [ "$arg" == "reset" ]; then
    reset
  elif [ "$arg" == "remove" ]; then
    remove
  elif [ "$arg" == "logs" ]; then
    logs
  else
    echo "Unknown command: $arg"
    exit 1
  fi
done
