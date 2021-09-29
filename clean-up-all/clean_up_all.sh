#!/bin/bash
cd "$(dirname "$0")"

echo "Delete all resources created by Terraform"

# echo "TF_STATE_BLOB_SAS_TOKEN: ${TF_STATE_BLOB_SAS_TOKEN}"
# if [[ -z "${TF_STATE_BLOB_SAS_TOKEN}" ]]; then
#     echo "TF_STATE_BLOB_SAS_TOKEN was not set" 1>&2
#     exit 1
# fi

# echo ">> az --version"
# az --version

# echo ">> az upgrade --yes"
# az upgrade --yes

# This removes the error "Please ensure you have network connection. Error detail: HTTPSConnectionPool(host='login.microsoftonline.com', port=443):"
export HTTP_PROXY=
export HTTPS_PROXY=

# echo "az login"
az login --service-principal --username ${ARM_CLIENT_ID} --tenant ${ARM_TENANT_ID} --password ${ARM_CLIENT_SECRET}

az account show

# az group create --name aks-startup-d-rg-aks-infrastructure --location norwayeast --subscription ${ARM_SUBSCRIPTION_ID}

# az group exists --name aks-startup-d-rg-aks-infrastructure --subscription ${ARM_SUBSCRIPTION_ID}

group_infrastructure_exists=$(az group exists --name aks-startup-d-rg-aks-infrastructure --subscription ${ARM_SUBSCRIPTION_ID})
echo "group_infrastructure_exists => $group_infrastructure_exists"

## Beware of the whitespace after '[' and before ']'
if [ $group_infrastructure_exists = "true" ] ; then
    echo "** Deleting aks-startup-d-rg-aks-infrastructure **"
    az group delete --name aks-startup-d-rg-aks-infrastructure --subscription ${ARM_SUBSCRIPTION_ID} --yes --verbose
fi

group_shared_exists=$(az group exists --name aks-startup-d-rg-aks-infrastructure-shared --subscription ${ARM_SUBSCRIPTION_ID})
echo "group_shared_exists => $group_shared_exists"

if [ $group_shared_exists == "true" ] ; then
    echo "** Deleting aks-startup-d-rg-aks-infrastructure-shared **"
    az group delete --name aks-startup-d-rg-aks-infrastructure-shared --subscription ${ARM_SUBSCRIPTION_ID} --yes --verbose
fi

#### Exit with great success
exit 0