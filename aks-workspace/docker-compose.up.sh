#!/bin/bash
BASEDIR=$(dirname "$0")
echo "$BASEDIR"
cd $BASEDIR

docker rm -f aksstartup-workspace-1
docker-compose -f docker-compose.yml down --remove-orphans

docker network create -d overlay --attachable aksstartup_common_network

# docker-compose -f docker-compose.yml build --progress plain --no-cache

docker-compose -f docker-compose.yml up -d --remove-orphans
# wait for a few seconds for the container to start
echo sleeping a few sec
sleep 2
# open http://localhost:8428/metrics in a browser

echo "Opening a terminal to the Container..."
docker exec -it aksstartup-workspace-1 /bin/bash
# ================================================= #

## ## Troubleshooting ## ##

# # Test connection
# curl -v http://aksstartup-workspace:8428/metrics

# echo "Opening a terminal to the Container..."
# docker exec -it aksstartup-workspace-1 /bin/bash

echo "### docker logs aksstartup-workspace-1"
docker logs aksstartup-workspace-1