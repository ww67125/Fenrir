### 1. 概述
1. arp是**TCP/IP**协议栈中的一个协议，并且不怎么安全。

2. arp（Address Resolution Protocol）即**地址解析协议**，用于**ip地址到mac地址**的映射（通过目标ip对应到mac地址）

3. 由于上层程序更关心ip，因此通过arp协议获取mac完成数据封装。


4. arp协议衍生出
    - 代理arp（用于访问不同网段），
    - 无故arp（用于检测地址冲突），
    - 翻转arp（mac对应ip，基本不用），
    - 逆向arp（用于广域网，基本不用）
### 2. 原理
- （仅两台设备直接通讯的简单场景）局域网中一台设备,发送请求，询问目标设备的mac是多少，目标设备回应自己的mac是多少，并互相缓存值arp表直至重启设备 可用`arp -a` 查看arp表
![n1683q1b](/assets/n1683q1b.bmp)

- （多主机场景）局域网中有多台设备，arp协议需要以**广播形式**发送，交换机或路由器收到广播包时，会将数据发送给同一局域网下所有设备,发送请求的设备会**发送自己的ip与mac并询问对应ip的mac地址**，
**判断ip**是否为自己，是就先生成arp表然后用**单播形式**回复自己的mac给发送设备，不是就直接丢掉包
广播包特征:**ip 255.255.255.255 mac:ff:ff:ff:ff:ff:ff**
![gf7lsddl](/assets/gf7lsddl.bmp)

- arp包字段解析

title              | info
-------------------|------------------------------------------------------
Hardware type      | 硬件类型，标识链路层协议
Protocol type      | 协议类型，标识网络层协议
Hardware size      | 硬件地址大小，标识MAC地址长度，这里是6个字节（48bti）
Protocol size      | 协议地址大小，标识IP地址长度，这里是4个字节（32bit）
Opcode             | 操作代码，标识ARP数据包类型，1表示请求，2表示回应
Sender MAC address | 发送者MAC
Sender IP address  | 发送者IP
Target MAC address | 目标MAC，此处全0表示在请求
Target IP address  | 目标IP

- 基于功能来考虑，ARP是链路层协议；基于分层/包封装来考虑，ARP是网络层协议。（此方法对于ICMP协议同样管用）
