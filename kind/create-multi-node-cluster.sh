#!/bin/bash
kind.exe create cluster --config $(dirname "$0")/multi-node-cluster-config.yml
