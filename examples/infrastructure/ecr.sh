#!/bin/bash

set -ex 

# export AWS_PROFILE=default
# export AWS_DEFAULT_REGION=us-east-1
# export ENVIRONMENT_NAME=DEMO
# export GATEWAY_ECR_REPO_NAME=gateway
# export COLORTELLER_ECR_REPO_NAME=colorteller

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-ecr" \
    --capabilities CAPABILITY_IAM \
    --template-file "${DIR}/ecr.yaml"  \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    GatewayRepoName="${GATEWAY_ECR_REPO_NAME}" \
    ColortellerRepoName="${COLORTELLER_ECR_REPO_NAME}" 