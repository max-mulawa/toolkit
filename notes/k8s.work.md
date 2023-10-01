---
id: 8gajkcu977ul53bwcgyf8j5
title: Work
desc: ''
updated: 1696179205742
created: 1661499316786
---

Also see [[azure]]

### Check memory consumtion
```bash
kubectl top pods -n abc --sort-by='memory' --context aks
```

### Nodes resources

```bash
# nodes used memory
k --context abc top nodes

# nodes allocated memory
k describe nodes -A | grep "Allocated resources" -A 7
```

### Control plane services

```
kubectl get cs
```

### copy file to local filesystem run
```bash
kubectl cp namespace/pod-name:plan.json ./plan.json
```

### Force pulling image 
```bash
kubectl --context abc edit deploy/abc-api
## change imagePullPolicy: Always

# restore to imagePullPolicy: Never after new pods are running

```

### Execute shell
```bash
kubectl -n staging exec -it POD -c CONTAINER -- sh
```

#### Get value of env variable
```bash
kubectl exec --context abc-ctx po/abc-api-64d7699598-97vjz -c abc-api -- env | grep SECRET
```


### port-forward to deployment
```bash
k port-forward --context abc deploy/abc-api 8020:8080
```


### Restart deployment with FLUX

https://fluxcd.io/flux/faq/#why-are-kubectl-edits-rolled-back-by-flux

```bash
kubectl --context abc -n abc --field-manager=flux-client-side-apply rollout restart deployment abc-api
```