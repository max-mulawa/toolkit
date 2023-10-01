---
id: 8izyv4vve7fc1ahlbmljhe9
title: Start
desc: ''
updated: 1681562480641
created: 1681551874318
---

# Host chart repository with local filesystem

use chartmuseum server https://chartmuseum.com/#Instructions

```bash
docker run --rm -it \
  -p 8080:8080 \
  -e DEBUG=1 \
  -e STORAGE=local \
  -e STORAGE_LOCAL_ROOTDIR=/charts \
  -v $(pwd)/charts:/charts \
  ghcr.io/helm/chartmuseum:v0.14.0
```

# auto-completion

```bash
sudo apt-get install bash-completion -y
helm completion bash | sudo tee /usr/share/bash-completion/completions/helm
```

