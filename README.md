# deinstapel Cluster 

## Introduction

This repo is used to setup a working environment to work with the `deinstapel` cluster.

### What do you need?

+ Username (`$USER`)
+ kubeconfig from `deinstapel`-Cluster with your account.

## Usage

+ Paste your personal `kubeconfig` to `./kubeconfig`
+ Run `source ./env.sh $USER`

> This sets your `KUBECONFIG` enviroment variable to the kubeconfig, which you just pasted into this directory. This also starts a `helm-tiller`, which spins up a local `tiller` instance on your machine, which connects directly to the cluster. This also creates the namespace `$USER-tiller`, which is used to store the configurations of `helm`

You can now use `kubectl` and `helm` as usual.
> Due to some extra hacks, you are not able to create a namespace with helm. If you want to deploy a helm chart to a non-existing namespace, please create the namespace first.
