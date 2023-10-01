---
id: 51106bj47xfyncj7igxsrpq
title: Setup
desc: ''
updated: 1676448584437
created: 1676448568036
---

```bash
#https://learnk8s.io/etcd-kubernetes

#install
curl -LO https://github.com/etcd-io/etcd/releases/download/v3.5.4/etcd-v3.5.4-linux-amd64.tar.gz
tar xzvf etcd-v3.5.4-linux-amd64.tar.gz
cd etcd-v3.5.4-linux-amd64

#server
./etcd

#put 
for i in {1..4};do ./etcdctl put "myprefix/key$i" "thing$i";done


#get with prefix
./etcdctl get --prefix myprefix/key

#watch for prefix (time travel with revision)
./etcdctl watch --prefix myprefix 

#watch (time travel with revision)
./etcdctl watch --prefix myprefix --rev=12

#3 node cluster
```