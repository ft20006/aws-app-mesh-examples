#!/bin/bash

set -ex

export AWS_ACCOUNT_ID=943999622203
export KEY_PAIR_NAME=appmesh_pk
export AWS_PROFILE=default
export AWS_DEFAULT_REGION=us-east-1
export ENVIRONMENT_NAME=DEMO
export MESH_NAME=appmesh-mesh
export SERVICES_DOMAIN=demo.local
export CLUSTER_SIZE=6
export AWS_DEFAULT_REGION=us-east-1
export GO_PROXY=direct
export GATEWAY_ECR_REPO_NAME=gateway
export COLORTELLER_ECR_REPO_NAME=colorteller
export ENVOY_IMAGE=public.ecr.aws/appmesh/aws-appmesh-envoy:v1.17.2.0-prod
export CLUSTER_SIZE=6
export CLUSTER_INSTANCE_TYPE=t2.micro

## run ./examples/infrastructure/setup_all.sh

./examples/infrastructure/vpc.sh
echo completed setting up vpc
./examples/infrastructure/appmesh-mesh.sh
echo completed setting up appmesh
./examples/infrastructure/ecs-cluster.sh
echo completed setting up ecs-cluster
./examples/infrastructure/ecr.sh
echo completed creating ECR repos
./examples/apps/colorapp/servicemesh/appmesh-colorapp.sh
echo completed setting up appmesh-colorapp
./examples/apps/colorapp/src/gateway/deploy.sh
echo completed deploying gateway
./examples/apps/colorapp/src/colorteller/deploy.sh
echo completed deploying colorteller
./examples/apps/colorapp/ecs/ecs-colorapp.sh
echo completed deploying ecs-colorapp