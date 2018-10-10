---
title: "git常用操作"
date: 2018-10-10T11:30:16+08:00
draft: false
tags: ["git"]
categories: ["工具"]

---


### 创建新的github仓库

git init
git add README.md
git commit -m "readme.md"
git remote add origin https://github.com/lonelyc/MyRepo.git
git push -u origin master

### 在新的仓库中创建分支

在本地创建新的分支 git branch newbranch
切换到新的分支 git checkout newbranch
将新的分支推送到github git push origin newbranch
在本地删除一个分支： git branch -d newbranch
在github远程端删除一个分支： git push origin :newbranch (分支名前的冒号代表删除)

### 直接使用git pull和git push的设置
git branch --set-upstream-to=origin/master master
git branch --set-upstream-to=origin/ThirdParty ThirdParty
git config --global push.default matching

