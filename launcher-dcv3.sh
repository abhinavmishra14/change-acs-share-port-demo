#!/bin/sh

#docker-compose version 3.x launcher

export COMPOSE_FILE_PATH="${PWD}/docker-compose-v3.yml"
echo Docker compose file: $COMPOSE_FILE_PATH

buildImages() {
    docker volume create acs-volume
    docker volume create db-volume
    docker volume create ass-volume
    docker-compose -f "$COMPOSE_FILE_PATH" --compatibility build --no-cache
}

launch() {
	docker volume create acs-volume
    docker volume create db-volume
    docker volume create ass-volume
    docker-compose -f "$COMPOSE_FILE_PATH" --compatibility up --build
}


down() {
    if [ -f "$COMPOSE_FILE_PATH" ]; then
        docker-compose -f "$COMPOSE_FILE_PATH" --compatibility down
    fi
}

purge() {
    docker volume rm -f acs-volume
    docker volume rm -f db-volume
    docker volume rm -f ass-volume
}

tail() {
    docker-compose -f "$COMPOSE_FILE_PATH" --compatibility logs -f
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