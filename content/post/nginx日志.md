---
title: "nginx日志重新挂载"
date: 2018-09-14T11:30:16+08:00
draft: false
categories: ["nginx"]

---


先移动日志文件

mv /usr/local/openresty/nginx/logs/access.log /usr/local/openresty/nginx/logs/access.log.20161024

发送信号重新打开日志文件

kill -USR1 $(cat /usr/local/openresty/nginx/logs/nginx.pid)

简单说明一下：

1、在没有执行kill -USR1 `cat ${pid_path}`之前，即便已经对文件执行了mv命令也只是改变了文件的名称，nginx还是会向新命名的文件” access.log.20161024”中照常写入日志数据。原因在于linux系统中，内核是根据文件描述符来找文件的

2、USR1是自定义信号，也就是进程编写者自己确定收到这个信号该干什么。而在nginx中它自己编写了代码当接到USR1信号的时候让nginx重新打开日志文件（重新打开的日志就是配置文件中设置的位置和名称）