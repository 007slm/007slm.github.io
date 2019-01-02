---
title: "ngxin日志数据查询"
date: 2018-09-14T11:30:16+08:00
draft: false
categories: ["nginx"]
comment: true

---


- 查看时间最长的前300个请求
sed  -e 's/"//g' -e 's/?.*$//g' access.log | awk '{print $6,$1,$2,$3,$4,$5,$6,$10,$11,$12,$13,$14,$15,$16,$20}' | sort -rn |grep -v websocket|grep -v qrcodeLogin|grep -v wxEvent|grep -v wxevent| head -n 300


- 最后30000条记录 请求时间排序
tail -n 30000 access.log | sed  -e 's/"//g' -e 's/?.*$//g' | grep 20/Nov/2018 | awk '{print $10,$1,$2,$3,$4,$5,$6,$10,$11,$12,$13,$14,$15,$16,$20}' | sort -rn |awk '{print $7,$1,$2,$3,$4,$5,$6,$10,$11,$12,$13,$14,$15,$16,$20}' | sort -rn |grep -v websocket|grep -v qrcodeLogin|grep -v wxEvent|grep -v wxevent| head -n 500

![](http://k.justep.com/?controller=FileViewerController&action=image&file_id=5509&project_id=301&task_id=18850)