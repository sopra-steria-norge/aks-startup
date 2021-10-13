cd %~dp0

echo GITHUB_TOKEN: %GITHUB_TOKEN%

COPY "%USERPROFILE%\.kube\config" "%~dp0\scripts\secrets\kubeconfig"

docker rm -f aksstartup-workspace-1

docker-compose -f docker-compose.yml down --remove-orphans

docker network create -d overlay --attachable aksstartup_common_network

@REM docker-compose -f docker-compose.yml build --progress plain --no-cache aksstartup-workspace-1
docker-compose -f docker-compose.yml build --progress plain aksstartup-workspace-1