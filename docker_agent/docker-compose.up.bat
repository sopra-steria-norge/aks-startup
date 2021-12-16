cd %~dp0

echo GITHUB_TOKEN: %GITHUB_TOKEN%

docker rm -f aks-startup-dockeragent-1

docker-compose -f docker-compose.yml down --remove-orphans

docker network create -d overlay --attachable aks-startup_common_network

docker-compose -f docker-compose.yml build --progress plain aks-startup-dockeragent-1
@REM docker-compose -f docker-compose.yml build --progress plain --no-cache aks-startup-dockeragent-1

docker-compose -f docker-compose.yml up -d --remove-orphans
REM wait for 1-2 seconds for the container to start
pause
docker exec -it aks-startup-dockeragent-1 /bin/bash