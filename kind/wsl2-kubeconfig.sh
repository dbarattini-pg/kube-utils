#!/bin/bash
# run with: source wsl2-kubeconfig.sh
kind.exe get kubeconfig > /tmp/kubeconfig
export KUBECONFIG=/tmp/kubeconfig

