---
title: "url规范"
date: 2018-09-09T11:30:16+08:00
draft: false
tags: ["uri","url"]
categories: ["开发"]
comment: true

---

### url规范

## Components of an URI

[RFC 3986 Section 3](http://tools.ietf.org/html/rfc3986#section-3)  visualizes the structure of  URIs as follows:


![](uri%E8%A7%84%E8%8C%83_md_files/image.png?v=1&type=image)
 

### Components of an  URL  in URI.js
![输入图片描述](uri%E8%A7%84%E8%8C%83_md_files/%E6%90%9C%E7%8B%97%E6%88%AA%E5%9B%BE20200514170625.png?v=1&type=image)

          
In Javascript the  _query_  is often referred to as the  _search_. URI.js provides both accessors with the subtle difference of  [.search()](http://medialize.github.io/URI.js/docs.html#accessors-search)  beginning with the  `?`-character and  [.query()](http://medialize.github.io/URI.js/docs.html#accessors-search)  not.

In Javascript the  _fragment_  is often referred to as the  _hash_. URI.js provides both accessors with the subtle difference of  [.hash()](http://medialize.github.io/URI.js/docs.html#accessors-hash)  beginning with the  `#`-character and  [.fragment()](http://medialize.github.io/URI.js/docs.html#accessors-hash)  not.
