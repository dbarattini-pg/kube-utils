# kube-utils
## WSL 2 docker-desktop config
1) install docker desktop on windows
2) docker desktop -> settings -> general -> Use the WSL 2 based engine (Windows Home can only run the WSL 2 backend)
3) docker desktop -> settings -> resources -> WSL integration -> select the wsl distro to use and save
4) install kind on the wsl distro
    ```bash
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.12.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin
    ```
## Create a multi-node kind cluster from wsl
```bash
kind create cluster --config $config multi-node-cluster-config.yml
```
### Deploy metrics-server inside kind cluster
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system -p '{"spec":{"template":{"spec":{"containers":[{"name":"metrics-server","args":["--cert-dir=/tmp", "--secure-port=4443", "--kubelet-insecure-tls","--kubelet-preferred-address-types=InternalIP"]}]}}}}'
```
