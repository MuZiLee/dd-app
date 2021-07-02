查看 debug.keystore 的SHA1，无密码

$ keytool -list -v -keystore debug.keystore



*****************  WARNING WARNING WARNING  *****************
* 存储在您的密钥库中的信息的完整性  *
* 尚未经过验证!  为了验证其完整性, *
* 必须提供密钥库口令。                  *
*****************  WARNING WARNING WARNING  *****************

密钥库类型: JKS
密钥库提供方: SUN

您的密钥库包含 1 个条目

别名: androiddebugkey
创建日期: 2021年3月12日
条目类型: PrivateKeyEntry
证书链长度: 1
证书[1]:
所有者: C=US, O=Android, CN=Android Debug
发布者: C=US, O=Android, CN=Android Debug
序列号: 1
生效时间: Fri Mar 12 13:50:12 CST 2021, 失效时间: Sun Mar 05 13:50:12 CST 2051
证书指纹:
         SHA1: C8:3E:49:9B:3C:0E:FA:15:00:C7:BD:89:46:74:40:40:FE:FF:9E:2D
         SHA256: 6A:66:9A:29:0D:01:56:22:55:21:58:3C:33:04:7D:6F:C2:58:86:18:D2:E6:FE:F5:74:4F:82:7F:33:DA:7B:96
签名算法名称: SHA1withRSA (弱)
主体公共密钥算法: 2048 位 RSA 密钥
版本: 1


*******************************************
*******************************************



Warning:
<androiddebugkey> 使用的 SHA1withRSA 签名算法被视为存在安全风险。此算法将在未来的更新中被禁用。
JKS 密钥库使用专用格式。建议使用 "keytool -importkeystore -srckeystore debug.keystore -destkeystore debug.keystore -deststoretype pkcs12" 迁移到行业标准格式 PKCS12。
