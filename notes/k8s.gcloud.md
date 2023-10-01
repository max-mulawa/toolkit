---
id: ob5p6l9wjhrpx49aah4sgfp
title: Gcloud
desc: ''
updated: 1675346804240
created: 1674921274359
---

- https://cloud.google.com/free/ free trial
- tutorial https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-prerequisites.md
- gcloud console: https://console.cloud.google.com/getting-started?project=stately-block-376115
- 

```bash
sudo -i
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.gpg && apt-get update -y && apt-get install google-cloud-sdk -y
```

Tmux

> Enable synchronize-panes by pressing ctrl+b followed by shift+:. Next type set synchronize-panes on at the prompt. To disable synchronization: set synchronize-panes off.


```bash
gcloud config set compute/region europe-north1 #europe-central2
gcloud config set compute/zone europe-north1-c #europe-central2-a
```
tools
```bash
i golang-cfssl #PKI intrastructure - cert generations
```

```bash
gcloud compute networks create hwk8s --subnet-mode custom
# 10.240.0.0/24 subnet
gcloud compute networks subnets create kubernetes --network hwk8s --range 10.240.0.0/24
# kubernetes  europe-central2  hwk8s    10.240.0.0/24  IPV4_ONLY

gcloud compute firewall-rules create hwk8s-allow-internal --allow tcp,udp,icmp --network=hwk8s --source-ranges=10.240.0.0/24,10.200.0.0/16
# NAME                  NETWORK  DIRECTION  PRIORITY  ALLOW         DENY  DISABLED
# hwk8s-allow-internal  hwk8s    INGRESS    1000      tcp,udp,icmp        False

gcloud compute firewall-rules create hwk8s-allow-external --allow=tcp:22,tcp:6443,icmp --network=hwk8s --source-ranges=0.0.0.0/0
# hwk8s-allow-external  hwk8s    INGRESS    1000      tcp:22,tcp:6443,icmp        False

# public api
gcloud compute addresses create hwk8s --region=$(gcloud config get-value compute/region)
gcloud compute addresses list 
#NAME   ADDRESS/RANGE   TYPE      PURPOSE  NETWORK  REGION           SUBNET  STATUS
#hwk8s  34.118.103.210  EXTERNAL                    europe-central2          RESERVED


```

```bash
# control plane
for i in 0 1 2; do
  gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2204-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-2 \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags hwk8s,controller
done
#workers

for i in 0 1 2; do
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2204-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-2 \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags hwk8s,worker
done

gcloud compute instances list --filter="tags.items=hwk8s"

# NAME          ZONE             MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP     STATUS
# controller-0  europe-north1-c  e2-standard-2               10.240.0.10  35.228.236.230  RUNNING
# controller-1  europe-north1-c  e2-standard-2               10.240.0.11  35.228.108.151  RUNNING
# controller-2  europe-north1-c  e2-standard-2               10.240.0.12  34.88.193.241   RUNNING
# worker-0      europe-north1-c  e2-standard-2               10.240.0.20  34.88.199.30    RUNNING
# worker-1      europe-north1-c  e2-standard-2               10.240.0.21  34.88.229.150   RUNNING
# worker-2      europe-north1-c  e2-standard-2               10.240.0.22  34.88.221.21    RUNNING


```

gcloud compute firewall-rules update hwk8s-allow-internal --allow tcp,udp,icmp --network=hwk8s --source-ranges=10.240.0.0/24,10.200.0.0/16

```bash
sudo ETCDCTL_API=3 etcdctl member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem
```

wget -q --show-progress --https-only --timestamping \
  "https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/amd64/kube-apiserver" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/amd64/kube-controller-manager" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/amd64/kube-scheduler" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/amd64/kubectl"


KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe hwk8s \
  --region europe-north1 \
  --format 'value(address)')

  gcloud compute firewall-rules create kubernetes-the-hard-way-allow-health-check \
    --network hwk8s \
    --source-ranges 209.85.152.0/22,209.85.204.0/22,35.191.0.0/16 \
    --allow tcp


  wget -q --show-progress --https-only --timestamping \
    https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.24.0/crictl-v1.24.0-linux-amd64.tar.gz \
    https://github.com/opencontainers/runc/releases/download/v1.1.1/runc.amd64 \
    https://github.com/containernetworking/plugins/releases/download/v1.2.0/cni-plugins-linux-amd64-v1.2.0.tgz \
    https://github.com/containerd/containerd/releases/download/v1.6.4/containerd-1.6.4-linux-amd64.tar.gz \
    https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/amd64/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/amd64/kube-proxy \
    https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/amd64/kubelet



  mkdir containerd
  tar -xvf crictl-v1.24.0-linux-amd64.tar.gz
  tar -xvf containerd-1.6.4-linux-amd64.tar.gz -C containerd
  sudo tar -xvf cni-plugins-linux-amd64-v1.2.0.tgz -C /opt/cni/bin/
  sudo mv runc.amd64 runc
  chmod +x crictl kubectl kube-proxy kubelet runc 
  sudo mv crictl kubectl kube-proxy kubelet runc /usr/local/bin/
  sudo mv containerd/bin/* /bin/

    
  /usr/local/bin/kubelet \
  --config=/var/lib/kubelet/kubelet-config.yaml \
  --container-runtime=remote \
  --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock \
  --image-pull-progress-deadline=2m \
  --kubeconfig=/var/lib/kubelet/kubeconfig \
  --network-plugin=cni \ # removed
  --register-node=true \
  --v=2


  /usr/local/bin/kubelet \
  --config=/var/lib/kubelet/kubelet-config.yaml \
  --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock \
  --kubeconfig=/var/lib/kubelet/kubeconfig \
  --register-node=true \
  --v=2


  cat <<EOF | sudo tee /etc/systemd/system/kubelet.service
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/kubernetes/kubernetes
After=containerd.service
Requires=containerd.service

[Service]
ExecStart=/usr/local/bin/kubelet \\
  --config=/var/lib/kubelet/kubelet-config.yaml \\
  --container-runt  ime-endpoint=unix:///var/run/containerd/containerd.sock \\
  --kubeconfig=/var/lib/kubelet/kubeconfig \\
  --register-node=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe hwk8s \
    --region $(gcloud config get-value compute/region) \
    --format 'value(address)')



for i in 0 1 2; do
  gcloud compute routes create kubernetes-route-10-200-${i}-0-24 \
    --network hwk8s \
    --next-hop-address 10.240.0.2${i} \
    --destination-range 10.200.${i}.0/24
done

/usr/local/bin/kube-scheduler \
  --config=/etc/kubernetes/config/kube-scheduler.yaml \
  --v=2


cat <<EOF | sudo tee /etc/kubernetes/config/kube-scheduler.yaml
apiVersion: kubescheduler.config.k8s.io/v1beta2
kind: KubeSchedulerConfiguration
clientConnection:
  kubeconfig: "/var/lib/kubernetes/kube-scheduler.kubeconfig"
leaderElection:
  leaderElect: true
EOF



cat <<EOF | sudo tee /etc/crictl.yaml
runtime-endpoint: unix:///run/containerd/containerd.sock
image-endpoint: unix:///run/containerd/containerd.sock
timeout: 10
debug: true
EOF

  
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



cat << EOF | sudo tee /etc/containerd/config.toml
[plugins]
  [plugins.cri.containerd]
    snapshotter = "overlayfs"
    [plugins.cri.containerd.default_runtime]
      runtime_type = "io.containerd.runtime.v1.linux"
      runtime_engine = "/usr/local/bin/runc"
      runtime_root = ""
    [plugins.cri.containerd.runtimes.runc]
      [plugins.cri.containerd.runtimes.runc.options]
        SystemdCgroup = true

EOF


cat <<EOF | sudo tee /var/lib/kubelet/kubelet-config.yaml
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    enabled: true
  x509:
    clientCAFile: "/var/lib/kubernetes/ca.pem"
authorization:
  mode: Webhook
cgroupDriver: systemd
clusterDomain: "cluster.local"
clusterDNS:
  - "10.32.0.10"
podCIDR: "${POD_CIDR}"
resolvConf: "/run/systemd/resolve/resolv.conf"
runtimeRequestTimeout: "15m"
tlsCertFile: "/var/lib/kubelet/${HOSTNAME}.pem"
tlsPrivateKeyFile: "/var/lib/kubelet/${HOSTNAME}-key.pem"
EOF

cat << EOF | sudo tee /etc/containerd/config.toml
[plugins]
  [plugins."io.containerd.monitor.v1.cgroups"]
    no_prometheus = false
  [plugins."io.containerd.grpc.v1.cri"]
    sandbox_image = "k8s.gcr.io/pause:3.6"

    [plugins."io.containerd.grpc.v1.cri".containerd]
      snapshotter = "overlayfs"
      [plugins."io.containerd.grpc.v1.cri".containerd.default_runtime]
        runtime_type = "io.containerd.runc.v2"
      [plugins."io.containerd.grpc.v1.cri".containerd.runtimes]
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
          runtime_type = "io.containerd.runc.v2"
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
            SystemdCgroup = true
EOF




# v1.26.1

- https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.26.md#v1261
- https://kubernetes.io/blog/2022/11/18/upcoming-changes-in-kubernetes-1-26/
- https://kubernetes.io/docs/reference/scheduling/config/
- https://github.com/containerd/containerd/blob/main/docs/cri/crictl.md
- https://kubernetes.io/docs/setup/production-environment/container-runtimes/
  - https://blog.kintone.io/entry/2022/03/08/170206 
  - https://github.com/kubernetes/minikube/blob/master/pkg/minikube/cruntime/containerd.go 
  - https://github.com/containerd/containerd/blob/main/docs/cri/crictl.md
  - https://github.com/kubernetes/kubernetes/issues/110177

## Cleanup
```bash
gcloud compute firewall-rules delete kubernetes-the-hard-way-allow-health-check hwk8s-allow-internal hwk8s-allow-external
gcloud compute routes delete kubernetes-route-10-200-0-0-24 kubernetes-route-10-200-1-0-24 kubernetes-route-10-200-2-0-24
gcloud compute instances delete --zone=europe-north1-c worker-0 worker-1 worker-2
gcloud compute instances delete --zone=europe-north1-c controller-0 controller-1 controller-2
gcloud compute networks subnets delete kubernetes
gcloud compute addresses delete -q hwk8s
gcloud compute forwarding-rules delete kubernetes-forwarding-rule -q
gcloud compute target-pools -q delete kubernetes-target-pool


gcloud compute networks delete hwk8s
```

kube* - v1.26.1
runc - 1.1.4
containerd - 1.6.15
coredns - 1.9.3
etcd - 3.5.6
cni-plugins - 1.2.0

```bash
# https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/install-containerd-on-ubuntu-22-04.html
# https://github.com/kubernetes/kubernetes/issues/110177 (Ubuntu 22.04)
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
```

## Diag
```bash
watch kubectl get po  -n kube-system -owide
journalctl -u kubelet.service -b | tail -n100
```

