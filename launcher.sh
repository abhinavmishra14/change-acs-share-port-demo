#!/bin/sh

export COMPOSE_FILE_PATH="${PWD}/docker-compose.yml"
echo Docker compose file: $COMPOSE_FILE_PATH

buildImages() {
    docker-compose -f "$COMPOSE_FILE_PATH" build --no-cache
}

launch() {
    #Create volumes when external volumes are in use.
    #docker volume create acs-volume
    #docker volume create db-volume
    #docker volume create ass-volume
	#docker volume create acs-volume-logs
	#docker volume create share-volume-logs
    #docker volume create db-volume-logs
    #docker volume create ass-volume-logs
    docker-compose -f "$COMPOSE_FILE_PATH" up --build
}


down() {
    if [ -f "$COMPOSE_FILE_PATH" ]; then
        docker-compose -f "$COMPOSE_FILE_PATH" down
    fi
}

purge() {
    PARENT_FOLDER=$(basename $PWD)
	echo PARENT_FOLDER: $PARENT_FOLDER
    docker volume rm -f ${PARENT_FOLDER}_acs-volume
    docker volume rm -f ${PARENT_FOLDER}_db-volume
    docker volume rm -f ${PARENT_FOLDER}_ass-volume
	docker volume rm -f ${PARENT_FOLDER}_acs-volume-logs
    docker volume rm -f ${PARENT_FOLDER}_db-volume-logs
    docker volume rm -f ${PARENT_FOLDER}_ass-volume-logs
    docker volume rm -f ${PARENT_FOLDER}_share-volume-logs
}

purgeAll() {
   docker volume rm $(docker volume ls -q)
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
  purgeAll)
    down
    purgeAll
    ;;
  tail)
    tail
    ;;
  *)
    echo "Usage: $0 {build|start|stop|purge|tail}"
esac