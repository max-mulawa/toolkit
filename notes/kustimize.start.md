---
id: 06qimbpkfm3w3m9iu4l7vh2
title: Start
desc: ''
updated: 1681562567449
created: 1681562452462
---

```
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
sudo mv ./kustomize /usr/local/bin/

kustomize completion bash | sudo tee /usr/share/bash-completion/completions/kustomize
```
