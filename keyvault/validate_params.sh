#!/bin/bash
cd "$(dirname "$0")"

echo "Validate parameteres"

echo "TF_STATE_BLOB_SAS_TOKEN: ${TF_STATE_BLOB_SAS_TOKEN}"
if [[ -z "${TF_STATE_BLOB_SAS_TOKEN}" ]]; then
    echo "TF_STATE_BLOB_SAS_TOKEN was not set" 1>&2
    exit 1
fi