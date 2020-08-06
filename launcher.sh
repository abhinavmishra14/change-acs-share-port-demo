#!/bin/sh

export COMPOSE_FILE_PATH="${PWD}/docker-compose.yml"
echo Docker compose file: $COMPOSE_FILE_PATH

buildImages() {
    docker volume create acs-volume
    docker volume create db-volume
    docker volume create ass-volume
    docker-compose -f "$COMPOSE_FILE_PATH" build --no-cache
}

launch() {
	docker volume create acs-volume
    docker volume create db-volume
    docker volume create ass-volume
    docker-compose -f "$COMPOSE_FILE_PATH" up --build
}


down() {
    if [ -f "$COMPOSE_FILE_PATH" ]; then
        docker-compose -f "$COMPOSE_FILE_PATH" down
    fi
}

purge() {
    docker volume rm -f acs-volume
    docker volume rm -f db-volume
    docker volume rm -f ass-volume
}

tail() {
    docker-compose -f "$COMPOSE_FILE_PATH" logs -f
}

case "$1" in
  build)
    buildImages
    ;;
  start)
    launch
    tail
    ;;
  stop)
    down
    ;;
  purge)
    down
    purge
    ;;
  tail)
    tail
    ;;
  *)
    echo "Usage: $0 {build|start|stop|purge|tail}"
esac