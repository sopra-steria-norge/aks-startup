cd %~dp0

docker swarm init


set DOCKER_LATEST_VERSION_FILE=docker-19.03.4.tgz

docker-compose -f docker-compose.yml build --progress plain
pause
    