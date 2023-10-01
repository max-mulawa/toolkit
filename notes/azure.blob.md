---
id: qvdkr5nsxrbabat3ja5m7td
title: Blob
desc: ''
updated: 1696178632423
created: 1676450316702
---

# Install azcopy
- https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10

```bash
wget https://aka.ms/downloadazcopy-v10-linux
tar -C . -xzf downloadazcopy-v10-linux
sudo mv azcopy_linux_amd64_10.16.2/azcopy /usr/local/bin/azcopy
chmod +x /usr/local/bin/azcopy
```

# Copy files locally from blob

```bash
# !/bin/bash
declare -a snapshots=(
 12344
)

for snapshotId in "${snapshots[@]}"
    do
       snapshotDir=/home/maks/ 
       mkdir -p $snapshotDir
      
       azcopy cp "https://......blob.core.windows.net/abc/xyz-${snapshotId}/?....." $snapshotDir --recursive=true 
    done
```

















```