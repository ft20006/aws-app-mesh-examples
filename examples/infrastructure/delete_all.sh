#!/bin/bash

set -ex

export AWS_ACCOUNT_ID=943999622203
export AWS_PROFILE=default
export AWS_DEFAULT_REGION=us-east-1
export ENVIRONMENT_NAME=DEMO
export MESH_NAME=appmesh-mesh
export SERVICES_DOMAIN=demo.local
export GO_PROXY=direct
export GATEWAY_ECR_REPO_NAME=gateway
export COLORTELLER_ECR_REPO_NAME=colorteller

## run ./examples/infrastructure/delete_all.sh

## delete ecs-colorapp
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation delete-stack \
    --stack-name "${ENVIRONMENT_NAME}-ecs-colorapp"

aws cloudformation wait stack-delete-complete \
    --stack-name "${ENVIRONMENT_NAME}-ecs-colorapp"

## delete appmesh-colorapp
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation delete-stack \
    --stack-name "${ENVIRONMENT_NAME}-appmesh-colorapp"

aws cloudformation wait stack-delete-complete \
    --stack-name "${ENVIRONMENT_NAME}-appmesh-colorapp"

## delete ECR repos
## add fix to delete images only before stack delete
aws ecr delete-repository --repository-name="${GATEWAY_ECR_REPO_NAME}" --force
aws ecr delete-repository --repository-name="${COLORTELLER_ECR_REPO_NAME}" --force
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation delete-stack \
    --stack-name "${ENVIRONMENT_NAME}-ecr"

aws cloudformation wait stack-delete-complete \
    --stack-name "${ENVIRONMENT_NAME}-ecr"

## delete ecs-clusters
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation delete-stack \
    --stack-name "${ENVIRONMENT_NAME}-ecs-cluster" 

aws cloudformation wait stack-delete-complete \
    --stack-name "${ENVIRONMENT_NAME}-ecs-cluster" 

## delete appmesh
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation delete-stack \
    --stack-name "${ENVIRONMENT_NAME}-appmesh-mesh"

aws cloudformation wait stack-delete-complete \
    --stack-name "${ENVIRONMENT_NAME}-appmesh-mesh"

## remove vpcs
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation delete-stack \
    --stack-name "${ENVIRONMENT_NAME}-vpc"

aws cloudformation wait stack-delete-complete \
    --stack-name "${ENVIRONMENT_NAME}-vpc"