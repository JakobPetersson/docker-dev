#!/usr/bin/env bash

COMPOSE_PATH="$( cd "$(dirname "$0")" ; pwd -P )/docker-compose.yml"

function build() {
  echo "Building"
  docker-compose -f "$COMPOSE_PATH" build
}

function start() {
  echo "Starting"
  docker-compose -f "$COMPOSE_PATH" up -d --remove-orphans
}

function stop() {
  echo "Stopping"
  docker-compose -f "$COMPOSE_PATH" stop
}

function remove() {
  stop
  echo "Removing"
  docker-compose -f "$COMPOSE_PATH" rm -f
}

function reset() {
  build
  remove
  start
}

function logs() {
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
