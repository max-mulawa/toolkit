---
id: 4t4e136b9769hi6e2s20dt9
title: Work
desc: ''
updated: 1676453433650
created: 1676448601841
---

```bash


git rebase --abort #abort git rebase if conflict
git merge --abort #abort git merge if conflict

# unstage changes
git restore --staged ...

# discard changes
git reset --hard

git commit --amend -m "New commit message."
git push --force origin chore/reimport-utils-ng

git reset file #(undo add) 
git restore filepath #(discard changes) 


#configuration
git config --global user.email "max.mulawa@gmail.com"
git config --global user.name "Maksymilian Mulawa"
# git config --global pull.rebase true 

# global gitignore
git config --global core.excludesfile ~/.gitignore
echo .vscode >> ~/.gitignore


#add everything
git add $(git rev-parse --show-toplevel)

#amend the last commit message (by creating new commit)
git commit --amend -m "New commit message."

# Tag commit
git tag v0.1.3
git push origin v0.1.3


```