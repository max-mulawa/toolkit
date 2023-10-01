---
id: kejm6wrdla6mbkuizz6gmva
title: Katana Scraper
desc: ''
updated: 1696178670517
created: 1668685424836
---

Project website
https://github.com/projectdiscovery/katana

Install spider
```bash
go install github.com/projectdiscovery/katana/cmd/katana@latest
```


```bash
katana -hl -fs fqdn -cos Incapsula -ef css,js -ct 2 -u https://www.ll.com/ -json
```


katana -hl -fs fqdn -cos Dependency -ef css,js -u https://www.ll.dk/ -json

looking for the link from which page
```bash
katana -hl -fs fqdn -cos Dependency -ef css,js -u https://ll.nl -json | tee > katana.log
cat katana.log | grep "https://www.ll.dk/media/12"
```
