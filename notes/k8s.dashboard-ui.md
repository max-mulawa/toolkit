---
id: ry3fir2dt21a4mpb4psqvjw
title: Dashboard UI
desc: ''
updated: 1668023742995
created: 1668023614143
---

Get token to login to Dashboard 

```bash
kubectl describe secret  $(kubectl get secret -n kube-system | grep deployment-controller-token | awk '{print $1}') -n kube-system  
```

Provision dashboard ui components https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/  

- Run 
```bash
kubectl proxy 
```

- Go to http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/workloads?namespace=default  

- Create dashboard user with admin priviliges and use it's token 

https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md 

- Get user token 

```bash
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/dashboard-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}" 
```