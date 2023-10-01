---
id: 4ym8zwpglm5djjo79g1he62
title: Curl
desc: ''
updated: 1676451767328
created: 1676451107751
---


### Get with token
```
# export token=$(cat ~/.token)
curl -H "Accept: application/json" -H "Authorization: Bearer $token" "http://localhost:8090/"
```

### Check external IP
```
curl ifconfig.me 
```