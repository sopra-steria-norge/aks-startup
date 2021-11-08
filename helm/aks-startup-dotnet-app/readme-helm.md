# Installer aks-startup-dotnet-app med Helm

## Få innsikt i Kubernetes med Portainer

Følg instrukser på [https://github.com/portainer/k8s]

eller kjør dette:

```bash
helm repo add portainer https://portainer.github.io/k8s/
helm repo update
helm install --create-namespace -n portainer portainer portainer/portainer \
--set service.type=LoadBalancer
```

Tjensten blir tilgjengelig på <IP>:9000.

## Installer aks-startup-dotnet-app med Helm

1 - Legg til secret i Kubernetes cluster

Dette gjør det mulig for Kubernetes å hente container images fra det private docker registry. Blir brukt i **imagePullSecrets** i DeploymentConfig.

```bash

export DOCKER_REGISTRY_SERVER=aksstartup.azurecr.io
export DOCKER_USER=aksstartup
export DOCKER_PASSWORD=

kubectl create secret docker-registry aksstartup-acr\
 --docker-server=$DOCKER_REGISTRY_SERVER\
 --docker-username=$DOCKER_USER\
 --docker-password=$DOCKER_PASSWORD

```

2 - Installer aks-startup-app

```bash
cd /helm/aks-startup-dotnet-app
helm template aks-startup-app .
helm install aks-startup-app .
kubectl get pods
kubectl get services aks-startup-app
```

3 - Oppdater aks-startup-app ved endringer

```bash
helm upgrade aks-startup-app .
```


-----------------

Basert på 

- [https://github.com/paulbouwer/hello-kubernetes]