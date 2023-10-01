---
id: pbi60vjdeoag9mqtc50ipua
title: Container Runtime
desc: ''
updated: 1675426774631
created: 1675417215833
---

# crictl 

```bash
cat <<EOF | sudo tee /etc/crictl.yaml
runtime-endpoint: unix:///run/containerd/containerd.sock
image-endpoint: unix:///run/containerd/containerd.sock
timeout: 10
debug: true
EOF

sudo crictl ps #list containers
sudo crictl inspect b95643efe92bb #check container, eg. get PID

cat <<EOF | sudo tee  ./container-config.json
{
  "metadata": {
      "name": "busybox"
  },
  "image":{
      "image": "busybox"
  },
  "command": [
      "top"
  ],
  "linux": {
  }
}
EOF

cat <<EOF | sudo tee ./sandbox-config.json
{
    "metadata": {
        "name": "nginx-sandbox",
        "namespace": "default",
        "attempt": 1,
        "uid": "hdishd83djaidwnduwk28bcsb"
    },
    "linux": {
    }
}
EOF

```



# nsenter (namespaces)


```bash
sudo lsns -p 5121 #list all namespaces for the process

# https://www.redhat.com/sysadmin/container-namespaces-nsenter
sudo nsenter -t 5121 -n ip route


```

# sample containerd configuration

- https://github.com/kubernetes-sigs/kind/blob/main/images/base/files/etc/containerd/config.toml
- 

