#!/bin/bash

set -ex

# export AWS_PROFILE=default
# export AWS_DEFAULT_REGION=us-east-1
# export ENVIRONMENT_NAME=DEMO
# export SERVICES_DOMAIN=demo.local
# export MESH_NAME=appmesh-mesh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-appmesh-colorapp" \
    --capabilities CAPABILITY_IAM \
    --template-file "${DIR}/appmesh-colorapp.yaml"  \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    ServicesDomain="${SERVICES_DOMAIN}" \
    AppMeshMeshName="${MESH_NAME}"
