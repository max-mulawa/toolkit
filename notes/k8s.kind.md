---
id: yz9pvchsfflia0ofxsb84fd
title: Kind
desc: ''
updated: 1675426633036
created: 1675418563698
---

If you have go (1.17+) and docker installed 
```bash
go install sigs.k8s.io/kind@latest && kind create cluster #is all you need!
```

# bash into kind control plane
```
docker exec -it kind-control-plane /bin/bash
```

# Docker image for kind
- https://github.com/kubernetes-sigs/kind/blob/main/images/base/Dockerfile