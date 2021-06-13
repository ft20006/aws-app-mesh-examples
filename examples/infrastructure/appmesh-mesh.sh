#!/bin/bash

set -ex

# export AWS_PROFILE=default
# export AWS_DEFAULT_REGION=us-east-1
# export ENVIRONMENT_NAME=DEMO
# export MESH_NAME=appmesh-mesh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-appmesh-mesh" \
    --capabilities CAPABILITY_IAM \
    --template-file "${DIR}/appmesh-mesh.yaml"  \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    AppMeshMeshName="${MESH_NAME}"
