---
id: nm64l2od2cg9q3dimevrkuo
title: Helm
desc: ''
updated: 1681555614848
created: 1681555478608
---

```bash
helm install redis bitnami/redis

export REDIS_PASSWORD=$(kubectl get secret --namespace default redis -o jsonpath="{.data.redis-password}" | base64 -d)
kubectl run --namespace default redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.0.10-debian-11-r4 --command -- sleep infinity

kubectl exec --tty -i redis-client --namespace default -- bash
# on pod bash
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-master
```
