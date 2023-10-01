---
id: nc2wlbvncm5vy8r1sa2rz1i
title: GitHub
desc: ''
updated: 1696178730650
created: 1676448633634
---

```bash
#setup 2 factor auth
https://github.com/settings/two_factor_authentication/configure 


gh pr create --base master --fill

#Go to https://github.com/settings/tokens and create PAT 
gh auth login 

#Pass PAT 
#https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git  

#create public repo
gh repo create --public -g Go -d "http server in go"  max-mulawa/httpium

# create private repo
gh repo create --private -g Go -d "api client"  max-mulawa/api

#git clone from github
gh repo clone max-mulawa/git-go

```