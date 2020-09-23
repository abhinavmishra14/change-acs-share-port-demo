#!/bin/sh

#docker-compose version 3.x launcher

export COMPOSE_FILE_PATH="${PWD}/docker-compose-v3-linux.yml"
echo Docker compose file: $COMPOSE_FILE_PATH

buildImages() {
    mkdir data
	mkdir logs
    docker-compose -f "$COMPOSE_FILE_PATH" --compatibility build --no-cache
}

launch() {
	mkdir data
	mkdir logs
    docker-compose -f "$COMPOSE_FILE_PATH" --compatibility up --build
}


down() {
    if [ -f "$COMPOSE_FILE_PATH" ]; then
        docker-compose -f "$COMPOSE_FILE_PATH" --compatibility down
    fi
}

purge() {
	rm -rf data
	rm -rf logs
}

purgeAll() {
   rm -rf data
   rm -rf logs
   docker volume rm $(docker volume ls -q)
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