#!/bin/bash

set -ex 

# export AWS_PROFILE=default
# export AWS_DEFAULT_REGION=us-east-1
# export ENVIRONMENT_NAME=DEMO
# export SERVICES_DOMAIN=demo.local
# export KEY_PAIR_NAME=appmesh_pk
# export CLUSTER_SIZE=6
export CLUSTER_INSTANCE_TYPE=t2.micro

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-ecs-cluster" \
    --capabilities CAPABILITY_IAM \
    --template-file "${DIR}/ecs-cluster.yaml"  \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    KeyName="${KEY_PAIR_NAME}" \
    ECSServicesDomain="${SERVICES_DOMAIN}" \
    ClusterSize="${CLUSTER_SIZE:-5}" \
    InstanceType="${CLUSTER_INSTANCE_TYPE}"
