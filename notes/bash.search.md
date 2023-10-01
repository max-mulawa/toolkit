---
id: jyi4gtdkmlxw8pn9yvkfoi5
title: Search
desc: ''
updated: 1696178642280
created: 1676453081188
---

# Check how many pages DOES NOT contain `VIEWSTATE` phrase
```bash
grep -L VIEWSTATE ./snapshots/ --recursive |wc -l
```
# list files that doesn't contain VIEWSTATE
grep -L VIEWSTATE ./snapshots/ --recursive

# list files that contain VIEWSTATE
grep -l VIEWSTATE ./snapshots/ --recursive
grep -L VIEWSTATE ./snapshots/abc-3/ --recursive | xargs cat | grep "<form "

# search with grep - https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux
grep -Ril "text-to-find-here" ./source

# find and copy files
find Aspose.Email-for-.NET/ -name '*.msg' -exec cp "{}" /home/maks/source/api/testdata/msg \;

# find large files +400MB
find / -type f -size +400M

# search files
# https://github.com/sharkdp/fd
sudo apt install fdfind

# diff folders
diff -q "./processed-1/" "./processed-2"