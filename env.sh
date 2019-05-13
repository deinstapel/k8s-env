#!/usr/bin/env bash

set -e

timestamp() {
  date +"%T"
}

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

export LOGFILE="${DIR}/__run-$(timestamp).log"
export KUBECONFIG="${DIR}/kubeconfig"
export HELM_HOME="${DIR}/helm-home"

if [ -z "$1" ]; then
  echo "You have to specify your username as first argument, e.g. martin"

else 
  echo 'Setting up helm'

  rm -rf "${HELM_HOME}" 2>/dev/null
  kubectl create ns $1-tiller 2>/dev/null >> "${LOGFILE}"
  helm init --client-only >> "${LOGFILE}"
  helm plugin install https://github.com/rimusz/helm-tiller >> "${LOGFILE}"
  helm tiller start-ci $1-tiller >> "${LOGFILE}"
  source <(helm tiller env) 

  echo 'THIS CLUSTER IS LIVE'
  echo 'Running workloads:'
  helm ls
fi

