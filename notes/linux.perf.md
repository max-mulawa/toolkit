---
id: 35e4po9k5todlohulinl1bk
title: Perf
desc: ''
updated: 1676452832387
created: 1676452767164
---

# install memusg script
```bash
wget https://gist.githubusercontent.com/netj/526585/raw/7f7cd17541a1d29bc978eccc80c270ab6b83ed9c/memusg
sudo mv memusg /usr/local/bin/
chmod +x /usr/local/bin/memusg
```

# eg. usage

```bash
memusg /usr/local/go/bin/go test -benchmem -run=^$ -bench ^BenchmarkDeduplication$ github.com/org-ai/orders-api/pkg/action
```