---
id: qnw0onjd8e5ycar6461sooj
title: Tricks
desc: ''
updated: 1676454088441
created: 1676454074035
---
#check laptop model (ubuntu)
sudo dmidecode -s system-version && sudo dmidecode -s system-product-name

# tar gz folder
tar -zcvf devcontainer.tar.gz  /var/tmp/api/

# ip - show network interfaces
ip address show 

# show process using port
netstat -tulpn | grep :3000
ls -l /proc/PID/exe

# ls - sort files by size
ls --sort=size -l

# free disk space (human readable)
df -H

# total used space
du -ch Downloads/

# process tree
pstree

# check memory usage
ps -o pid,ppid,rss,args

#jq filtering
 cat dump.json | jq '.[][].answer_id' |sort|uniq
# generate sql 
 cat dump.json | jq '.[][].answer_id'|sort|uniq|sed 's/.*/"&",/g' > dump.sql
 cat dump.json | jq '.[][].answer_id'|sort|uniq|sed 's/.*/"&"/g' | tr '\n' ','

#for loop in oneliner
for i in {1..10}; do make test; done

