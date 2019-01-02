---
title: "k8s常用命令"
date: 2018-10-18T11:30:16+08:00
draft: false
tags: ["k8s"]
categories: ["工具"]

---
#### 获取namespace为 console 的pod列表
- kubectl get po -n console
 
	namespace console 
	container 为gateway
	pod id 为console-deploy-7d9dc9f8c5-2lgtc
- kubectl exec -it console-deploy-7d9dc9f8c5-2lgtc -c gateway -n console /bin/bash
  