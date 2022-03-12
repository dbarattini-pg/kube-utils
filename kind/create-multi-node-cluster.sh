#!/bin/bash
config=$(dirname "$0")/multi-node-cluster-config.yml
nginx=false
wsl2=false

while getopts nw flag
do
    case "${flag}" in
        n)  config=$(dirname "$0")/ingress-nginx-multi-node-cluster-config.yml
            nginx=true
            ;;
        w)  wsl2=true
    esac
done

kind create cluster --config $config

if [ "$wsl2" = true ] ; then
    echo -e '\nWriting kind kubeconfig to /tmp/kubeconfig... ✍🏻'
    kind get kubeconfig > /tmp/kubeconfig
    export KUBECONFIG=$KUBECONFIG:/tmp/kubeconfig
fi

if [ "$nginx" = true ] ; then
    if [ "$wsl2" = false ] ; then
        echo ''
    fi
    echo 'Installing ingress Nginx... 🚪'
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
fi

if [ "$wsl2" = true ] ; then
    echo -e '\n\033[1;33mAdd kind kubeconfig to env with: export KUBECONFIG=$KUBECONFIG:/tmp/kubeconfig\033[0m\n'
fi
