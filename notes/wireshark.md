---
id: nbmwklrdcggae17le0kroqc
title: Wireshark
desc: ''
updated: 1696178986314
created: 1676448978308
---

```bash
#ref https://www.google.com/search?q=--ssl-key-log-file&sa=X&ved=2ahUKEwi68_GL1pn5AhXll4sKHTqJC4oQ1QJ6BAgcEAE&biw=3491&bih=1780&dpr=1.1#kpvalbx=_d4HhYp7hDY-UrwSf1JzoBQ14


# create ssl key log file (set in in .bashrc)
export SSLKEYLOGFILE=/home/maks/.ssl-key.log
touch /home/maks/.ssl-key.log

# start capturing traffic
sudo tcpdump -w /var/tmp/capture.dmp

#run curl as it seems to understand SSLKEYLOGFILE env var (firefox and chrome should also)
# this will record the keys in .ssl-key.log file
curl --tls-max 1.2 -v "https://api.example.com/v1/search?query=test" | jq

#configure wireshark to use /home/maks/.ssl-key.log which allows to decipher these
# Edit=>Preferences=>Protocols=>TLS=> (Pre)-Master-Secret-log filename

# open captured traffic 
# enter sudo pass if needed
function wsh() {
  sudo echo "starting wireshark"
  sudo wireshark 1>/dev/null 2>/dev/null  & disown
}

wsh

# Wireshark filter for bad tcp (retransmissions etc)
tcp.analysis.flags

```