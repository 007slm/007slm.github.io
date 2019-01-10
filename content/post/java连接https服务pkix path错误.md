
---  
title: "https连接提示pkix_path错误" 
date: 2019-01-08T11:30:16+08:00 
draft: false 
tags: ["https"]  
categories: ["开发"]  
comment: true 

---  
  
  
关于java中用httpclient访问https服务报错  
```java  
javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target  
at sun.security.ssl.Alerts.getSSLException(Alerts.java:192)  
at sun.security.ssl.SSLSocketImpl.fatal(SSLSocketImpl.java:1949)  
at sun.security.ssl.Handshaker.fatalSE(Handshaker.java:302)  
at sun.security.ssl.Handshaker.fatalSE(Handshaker.java:296)  
at sun.security.ssl.ClientHandshaker.serverCertificate(ClientHandshaker.java:1514)  
at sun.security.ssl.ClientHandshaker.processMessage(ClientHandshaker.java:216)  
at sun.security.ssl.Handshaker.processLoop(Handshaker.java:1026)  
at sun.security.ssl.Handshaker.process_record(Handshaker.java:961)  
at sun.security.ssl.SSLSocketImpl.readRecord(SSLSocketImpl.java:1062)  
at sun.security.ssl.SSLSocketImpl.performInitialHandshake(SSLSocketImpl.java:1375)  
at sun.security.ssl.SSLSocketImpl.startHandshake(SSLSocketImpl.java:1403)  
at sun.security.ssl.SSLSocketImpl.startHandshake(SSLSocketImpl.java:1387)  
at sun.net.www.protocol.https.HttpsClient.afterConnect(HttpsClient.java:559)  
at sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.connect(AbstractDelegateHttpsURLConnection.java:185)  
at sun.net.www.protocol.https.HttpsURLConnectionImpl.connect(HttpsURLConnectionImpl.java:153)  
at TestSecuredConnection.testConnectionTo(TestSecuredConnection.java:30)  
at TestSecuredConnection.main(TestSecuredConnection.java:16)  
Caused by: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target  
at sun.security.validator.PKIXValidator.doBuild(PKIXValidator.java:387)  
at sun.security.validator.PKIXValidator.engineValidate(PKIXValidator.java:292)  
at sun.security.validator.Validator.validate(Validator.java:260)  
at sun.security.ssl.X509TrustManagerImpl.validate(X509TrustManagerImpl.java:324)  
at sun.security.ssl.X509TrustManagerImpl.checkTrusted(X509TrustManagerImpl.java:229)  
at sun.security.ssl.X509TrustManagerImpl.checkServerTrusted(X509TrustManagerImpl.java:124)  
at sun.security.ssl.ClientHandshaker.serverCertificate(ClientHandshaker.java:1496)  
... 12 more  
Caused by: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target  
at sun.security.provider.certpath.SunCertPathBuilder.build(SunCertPathBuilder.java:141)  
at sun.security.provider.certpath.SunCertPathBuilder.engineBuild(SunCertPathBuilder.java:126)  
at java.security.cert.CertPathBuilder.build(CertPathBuilder.java:280)  
at sun.security.validator.PKIXValidator.doBuild(PKIXValidator.java:382)  
... 18 more  
```  
  
**PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target**  
  
主要看这一句，是说没有找到的指定的证书。  
  
我们知道ssl握手是又服务端返回证书信息，客户端进行校验，这里有个隐藏的规则，因为证书是链式签发的  
  
**root ca-->一级ca -—>二级ca -->我的网站**  
  
#### 问题1  
  
很多用户在部署证书的时候都只部署了自己的证书，这就造成浏览器一般会把受信任的证书补全，类似curl，httpclient等工具会利用操作系统本地的cert列表 eg：/etc/local/cert 来补全公信的证书，某些时候如果操作系统的cert不全或者java的security\cacert里面没有添加公信ca就会出现问题了。（不同版本的jre带的cacert可能会不一样，所以同样的代码 有些环境就不报错）

**注意**  
**微信小程序在中级证书没有部署的情况下，是会ssl握手失败的，和java一样的机制，本质是android中java握手失败。但是浏览器却完全正常。**
报错日志为：2019-1-9 17:19:52 [log] wx.request fail callback with msg request:fail ssl hand shake error with seq 0
  
#### 解决办法：  
服务器部署证书的时候部署全证书链，如下图即为典型的没有添加全证书链  
  
通过myssl校验证书信息  
  
![enter image description here](https://i.imgur.com/CESb3vS.png)  
在kong的certificate中补全证书链信息后就正常了 用java验证也通过：  
验证代码：  
```java  
public void testConnectionTo(String aURL) throws Exception {  
URL destinationURL = new URL(aURL);  
HttpsURLConnection conn = (HttpsURLConnection) destinationURL  
.openConnection();  
conn.connect();  
Certificate[] certs = conn.getServerCertificates();  
for (Certificate cert : certs) {  
System.out.println("Certificate is: " + cert);  
if(cert instanceof X509Certificate) {  
try {  
( (X509Certificate) cert).checkValidity();  
System.out.println("Certificate is active for current date");  
} catch(CertificateExpiredException cee) {  
System.out.println("Certificate is expired");  
}  
}  
}  
}  
```  
结果：  
```java  
[2]: ObjectId: 1.3.6.1.5.5.7.1.1 Criticality=false  
AuthorityInfoAccess [  
[  
accessMethod: ocsp  
accessLocation: URIName: http://ocsp2.digicert.com  
,  
accessMethod: caIssuers  
accessLocation: URIName: http://cacerts.digitalcertvalidation.com/TrustAsiaTLSRSACA.crt  
]  
]  
  
```  
  
### 问题2  
java中默认采用的cacert中没有对应的证书供应商的证书问题，需要导出证书文件才可以通过，推荐java中忽略ssl验证。  
  
### 备注  
java中默认请求https时候回失败，是因为默认java类库开启了ssl握手的校验，nginx中默认连接ssl的时候总是成功是默认没有校验证书  
  
  
```nginx  
  
Syntax: proxy_ssl_verify on | off;  
Default:  
proxy_ssl_verify off;  
Context: http, server, location  
This directive appeared in version 1.7.0.  
  
```  
  
Enables or disables verification of the proxied HTTPS server certificate.