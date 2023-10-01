---
id: sou3q9diz8rk6q06lwvqbx0
title: Start
desc: ''
updated: 1678644477927
created: 1678037893471
---

```bash
# https://docs.nats.io/using-nats/nats-tools/nats_cli
./nats server run #run dev server
./nats context select nats_development #set client to use accounts nats_dev...

#or run with docker (no auth)
docker run -it -p 4222:4222 -p 8222:8222 --name nats nats:alpine

telnet localhost 4222
sub test 1
sub test 2
pub test 2 #2 bytes
ok 

curl localhost:8222/varz # check NATS server metrics
    
```

Install monitoring tool

```bash
go install github.com/nats-io/nats-top@latest

nats-top

nats-top -s 127.0.0.1 -m 8223 #connect to given instance for monitoring
```

Nats configuration
```bash
docker stop nats;docker rm nats;docker run -it -p 4222:4222 -p 8222:8222 -v /home/maks/src/nats01/nats:/etc/nats/ --name nats nats:alpine
docker exec -it nats cat /etc/nats/nats-server.conf
```

```bash

./nats-server -T -p 4222 -cluster nats://127.0.0.1:6222 -routes $SERVERS & ./nats-server -T -p 4223 -cluster nats://127.0.0.1:6223 -routes $SERVERS & ./nats-server -T -p 4224 -cluster nats://127.0.0.1:6224 -routes $SERVERS


./nats-server -c ../../nats01/nats/server-1.conf  & ./nats-server -c ../../nats01/nats/server-2.conf & ./nats-server -c ../../nats01/nats/server-3.conf

# reload server configuration
kill -HUP $(pidof nats-server)
```

```
/usr/sbin/haproxy -f ./haproxy.cfg

```

# haproxy.cfg
```json
frontend nats_service
  bind 127.0.0.1:4002
  mode tcp
  default_backend nats_cluster_nodes
  
backend nats_cluster_nodes
 balance roundrobin
    
 option httpchk get /healthz
    
 server node1 127.0.0.1:4222 check port 8222
 server node2 127.0.0.1:4223 check port 8223
 server node3 127.0.0.1:4224 check port 8224
```