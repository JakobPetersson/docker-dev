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

if [ "$1" == "build" ]; then
  build
  exit 0
elif [ "$1" == "start" ]; then
  start
  exit 0
elif [ "$1" == "stop" ]; then
  stop
  exit 0
elif [ "$1" == "reset" ]; then
  reset
  exit 0
elif [ "$1" == "remove" ]; then
  remove
  exit 0
elif [ "$1" == "logs" ]; then
  logs
  exit 0
fi

echo "Unknown command: $1"