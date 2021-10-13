cd %~dp0

echo GITHUB_TOKEN: %GITHUB_TOKEN%

COPY "%USERPROFILE%\.kube\config" "%~dp0\scripts\secrets\kubeconfig"

docker swarm init

docker rm -f aksstartup-workspace-1

docker-compose -f docker-compose.yml down --remove-orphans

docker network create -d overlay --attachable aksstartup_common_network

REM Check if env-file exist, then use this. 
IF EXIST "../../aks-startup-config/.env" (
  echo "aks-startup-config/.env exist"
  docker-compose -f docker-compose.yml --env-file ../../aks-startup-config/.env up -d --remove-orphans 
) ELSE (
  echo "using local env-file"
  docker-compose -f docker-compose.yml up -d --remove-orphans
)

REM wait for 1-2 seconds for the container to start
pause
docker exec -it aksstartup-workspace-1 /bin/bash