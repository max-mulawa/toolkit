---
id: py3wcau7c47b57544m4k1do
title: Redis
desc: ''
updated: 1676452424661
created: 1676448828886
---

```bash
#run redis-stack (redis server, redis insights, redis cli) - https://redis.io/docs/stack/get-started/install/docker/
sudo docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 redis/redis-stack:latest

#http://localhost:8001/redis-stack/workbench


```

```bash
# start redis cli
sudo docker exec -it redis-stack redis-cli
sadd deck C1 C2 C3 C4
```


# connect to redis and issue commands

```bash
k exec -ti redis-pod --container redis redis-cli

#redis commands
HGETALL /orders/11
```
