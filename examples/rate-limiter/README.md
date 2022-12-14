# Global + Local Rate Limiting Example

Example using Gloo Mesh Gateway rate-limiter 

## Installation

This assumes you've already run through the [Gloo Mesh Online Boutique Demo Workshop](https://github.com/solo-io/solo-cop/tree/main/workshops/gloo-mesh-demo) up through Lab 6 and then run the following to install Gloo Mesh Gateway:

```bash
kubectl --context ${CLUSTER1} create namespace gloo-mesh-addons
kubectl --context ${CLUSTER1} label namespace gloo-mesh-addons istio-injection=enabled

helm repo add gloo-mesh-agent https://storage.googleapis.com/gloo-mesh-enterprise/gloo-mesh-agent
helm repo update

helm upgrade --install gloo-mesh-agent-addons gloo-mesh-agent/gloo-mesh-agent \
  --namespace gloo-mesh-addons \
  --kube-context=${CLUSTER1} \
  --set glooMeshAgent.enabled=false \
  --set rate-limiter.enabled=true \
  --set ext-auth-service.enabled=true \
  --version $GLOO_MESH_VERSION

```

Next run the following commands:

```bash
kubectl apply -f global-policy.yaml --context $MGMT
```

```bash
kubectl apply -f local-policy.yaml --context $MGMT
```

```bash
kubectl apply -f unified-envoyfilter.yaml --context $MGMT
```

Now open another terminal and run the following to expose the rate-limiter metrics:

```bash
kubectl port-forward -n gloo-mesh-addons deploy/rate-limiter 9091:9091 --context cluster1
```

From here you can test using `test.sh`

You should see:

bar1: gets 3 HTTP 200s

bar2: gets 3 HTTP 200s

global: gets the remaining 4 HTTP 200s

