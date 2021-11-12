cd /d %~dp0
echo Open Visual Studio Code Remote

docker swarm init

docker network create -d overlay --attachable aksstartup_common_network

COPY "%USERPROFILE%\.kube\config" "%~dp0\scripts\secrets\kubeconfig"

REM Use external env-file if it exist
IF EXIST "../../aks-startup-config/.env" (
  echo "aks-startup-config/.env exist"
  docker-compose -f docker-compose.yml --env-file ../../aks-startup-config/.env up -d
) ELSE (
  echo "using local env-file"
  docker-compose -f docker-compose.yml up -d
)

@REM Copy git clone all script to the container
docker cp clone-all.sh aksstartup-workspace-1:/git
docker exec aksstartup-workspace-1 dos2unix /git/clone-all.sh

docker run --rm geircode/string_to_hex bash string_to_hex.bash "aksstartup-workspace-1" > vscode_remote_hex.txt

set /p vscode_remote_hex=<vscode_remote_hex.txt


@REM echo %vscode_remote_hex%
@REM if "%vscode_remote_hex%" == "7b22636f6e7461696e65724e616d65223a222f736c762d776f726b73706163652d31227d" echo Hex_is_correct

code --folder-uri=vscode-remote://attached-container+%vscode_remote_hex%/git
exit /s

@REM pause
