---
id: 8enox3mnydypfwgs31fhhtb
title: Download Wikipedia
desc: ''
updated: 1669376459336
created: 1669376333767
---

https://planetofthepaul.com/wikipedia-download-usb-flash/
different ZIM dumps: https://library.kiwix.org/?lang=eng&category=wikipedia


https://github.com/openzim/zim-tools
```bash
./zimdump dump --dir dump/ wikipedia_en_100_nopic_2022-10.zim

# find larger files (300 bytes+)
find ./dump/A/ -maxdepth 5 -size +300 -print | xargs ls -f
```

