---
title: "git常用命令"
date: 2018-10-18T11:30:16+08:00
draft: false
tags: ["k8s"]
categories: ["工具"]

---

### 创建新的github仓库

- git init
- git add README.md
- git commit -m "readme.md"
- git remote add origin https://github.com/lonelyc/MyRepo.git
- git push -u origin master

### 在新的仓库中创建分支
- 获取远程分支列表 git branch -r
- 在本地创建新的分支 git branch newbranch
- 切换到新的分支 git checkout newbranch
- 将新的分支推送到github git push origin newbranch
- 在本地删除一个分支： git branch -d newbranch
- 在github远程端删除一个分支： git push origin :newbranch (分支名前的冒号代表删除)

### 直接使用git pull和git push的设置
- git branch --set-upstream-to=origin/master master
- git branch --set-upstream-to=origin/ThirdParty ThirdParty
- git config --global push.default matching

### github 收到dns污染加速方案 hosts中添加 
- 192.30.253.112 github.com
- 151.101.72.249 github.global.ssl.fastly.net

### 本地修改了许多文件，其中有些是新增的，因为开发需要这些都不要了，想要丢弃掉，可以使用如下命令：
- git checkout . #本地所有修改的。没有的提交的，都返回到原来的状态
- git stash #把所有没有提交的修改暂存到stash里面。可用git stash pop回复。
- git reset \-\-hard HASH #返回到某个节点，不保留修改。
- git reset \-\-soft HASH #返回到某个节点。保留修改

- git clean -df #返回到某个节点
- git clean 参数
    -n 显示 将要 删除的 文件 和  目录
    -f 删除 文件
    -df 删除 文件 和 目录12345678910

也可以使用：
- git checkout . && git clean -xdf
