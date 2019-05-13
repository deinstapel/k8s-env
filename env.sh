#!/usr/bin/env bash

timestamp() {
  date +"%T"
}

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

export LOGFILE="${DIR}/__run-$(timestamp).log"
export KUBECONFIG="${DIR}/kubeconfig"
export HELM_HOME="${DIR}/helm-home"

echo 'Setting up helm'

rm -rf "${HELM_HOME}" 2>/dev/null
kubectl create ns $1-tiller 2>/dev/null >> "${LOGFILE}"
helm init --client-only >> "${LOGFILE}"
helm plugin install https://github.com/rimusz/helm-tiller >> "${LOGFILE}"
helm plugin tiller start $1-tiller >> "${LOGFILE}"
helm plugin tiller env >> "${LOGFILE}"

echo 'THIS CLUSTER IS LIVE'
echo 'Running workloads:'
helm ls
