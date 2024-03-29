@ECHO OFF

::docker-compose version 3.x launcher
SET COMPOSE_FILE_PATH=.\docker-compose-v3.yml

echo Docker compose file: %COMPOSE_FILE_PATH%

IF [%1]==[] (
    echo "Usage: %0 {build|start|stop|purge|tail}"
    GOTO END
)

IF %1==build (
	CALL :buildImages
    GOTO END
)

IF %1==start (
    CALL :launch
    CALL :tail
    GOTO END
)

IF %1==stop (
    CALL :down
    GOTO END
)

IF %1==purge (
    CALL:down
    CALL:purge
    GOTO END
)

IF %1==tail (
    CALL :tail
    GOTO END
)

IF %1==purgeAll (
    CALL:down
    CALL:purgeAll
    GOTO END
)


:END
EXIT /B %ERRORLEVEL%


:buildImages	
	docker-compose -f "%COMPOSE_FILE_PATH%" build --no-cache
EXIT /B 0

:launch
    docker-compose -f "%COMPOSE_FILE_PATH%" up --build
EXIT /B 0


:down
    if exist "%COMPOSE_FILE_PATH%" (
        docker-compose -f "%COMPOSE_FILE_PATH%" down
    )
EXIT /B 0

:tail
    docker-compose -f "%COMPOSE_FILE_PATH%" logs -f
EXIT /B 0

:purge
   RMDIR "data" /S /Q
EXIT /B 0

:purgeAll
   RMDIR "data" /S /Q
   docker volume prune -f
EXIT /B 0