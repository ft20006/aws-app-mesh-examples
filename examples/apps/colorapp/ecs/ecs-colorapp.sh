#!/bin/bash

set -ex

# export AWS_PROFILE=default
# export AWS_DEFAULT_REGION=us-east-1
# export ENVIRONMENT_NAME=DEMO
# export MESH_NAME=appmesh-mesh
# export SERVICES_DOMAIN=demo.local
# export KEY_PAIR_NAME=appmesh_pk
# export ENVOY_IMAGE=public.ecr.aws/appmesh/aws-appmesh-envoy:v1.17.2.0-prod
# export GATEWAY_ECR_REPO_NAME=gateway
# export COLORTELLER_ECR_REPO_NAME=colorteller

export COLOR_GATEWAY_IMAGE=$(aws ecr describe-repositories --repository-names="${GATEWAY_ECR_REPO_NAME}" --query 'repositories[0].repositoryUri' --output text)
export COLOR_TELLER_IMAGE=$(aws ecr describe-repositories --repository-names="${COLORTELLER_ECR_REPO_NAME}" --query 'repositories[0].repositoryUri' --output text)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# ecs-colorapp.yaml expects "true" or "false" (default is "false")
# will deploy the TesterService, which perpetually invokes /color to generate history
: "${DEPLOY_TESTER:=false}"

# Creating Task Definitions
#source ${DIR}/create-task-defs.sh

aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-ecs-colorapp" \
    --capabilities CAPABILITY_IAM \
    --template-file "${DIR}/ecs-colorapp.yaml"  \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    ECSServicesDomain="${SERVICES_DOMAIN}" \
    AppMeshMeshName="${MESH_NAME}" \
    EnvoyImage="${ENVOY_IMAGE}" \
    ColorGatewayImage="${COLOR_GATEWAY_IMAGE}" \
    ColorTellerImage="${COLOR_TELLER_IMAGE}" \
    DeployTester="${DEPLOY_TESTER}"