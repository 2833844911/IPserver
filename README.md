## 安卓客户端服务端代理工具
视频教程:
https://www.bilibili.com/video/BV1WJ4m1A78w/

    工具可以实现代理池的搭建利用手机可以一直切ip,把手机（使用流量，不是wifi）作为类似拨号服务器,可以在我们需要过ip风控(利用手机切ip)的时候使用

### 下面的配置要服务端和客户端的配置一样


```json
{
    "connectionName": "", // 无关 后续功能还在开发
    "username": "", // 无关 后续功能还在开发
    "password": "",// 无关 后续功能还在开发
    "proxydk": 19191, // 安卓手机哪个端口作为代理端口
    "cyBohao": 19687, // 安卓手机哪个端口作为拨号服务端口

    "group": "cbb", // 设置这台手机属于什么组，方便后续根据组去获取代理 (不能为空) 为("all" )就在全部的代理中随机选择不会按照组去分类
    "frpserverIp": "213.126.207.110", // 服务端的ip地址
    "frpserverPort": 57001, // 服务端的frps端口 （记得开放这个端口 或者 关闭防火墙）
    "serverPort": 9990, // 服务端的获取代理的端口 （记得开放这个端口 或者 关闭防火墙）
    "frptoken": "64dcadf8108a9fc9d175778f31c6192f", // 服务端的token
    "maxError": 3,  // 服务端检测代理是否可以使用的次数(建议填多些) （超出次数判定这个代理不能使用 获取代理就不会获取到 需要重启客户端）
    "qieHuanIpTime": 180, // 代理切换ip地址的时间间隔
    "jiancTime": 60, // 服务端检测代理是否可以使用的时间间隔
    "bohaosleepTime": 20, // 代理切换ip地址后多长时间可以使用该代理
    "startPort": 20000, // 服务端的 代理端口范围 到下面的endProt （记得开放这个范围的端口 或者 关闭防火墙）
    "endProt": 30000
}

```


## 服务端使用方法 
1. 把压缩包里面的文件放入 centos的 目录下 这里我举例子放入 /data/ipServer
2. cd /data/ipServer 进入centos的目录
3. chmod +x ./main 给权限
4. ./main 启动
5. 启动后一定开放 frpserverPort serverPort 还有范围 startPort-endProt 的端口
### 服务端快速使用方法  （不想执行上面代理的话）
```sh
# curl -sSL https://ciyverify.com/serve/anzinstall.sh | sh -s 服务端外网地址 你的校验token(frptoken)
curl -sSL https://ciyverify.com/serve/anzinstall.sh | sh -s 127.0.0.1 hdakjsdhaskhnkcnzxck
```
启动后一定开放 57001 9990 还有范围 20000-21000 的端口 , 然后才可以部署客户端



## 安卓arm客户端使用方法
1. 把压缩包里面的文件放入 安卓的 /data/local/tmp 目录下
2. cd /data/local/tmp 进入安卓的目录
3. chmod +x ./main 给权限
4. ./main 启动 (启动前要确保服务端已经开启了)
### 安卓arm客户端快速使用方法  （不想执行上面代理的话）
进入 /data/local/tmp 目录下
```sh
cd /data/local/tmp
# curl -sSL https://ciyverify.com/anzzzzz/anzinstall.sh | sh -s 服务端外网地址 你的校验token(frptoken)
curl -sSL https://ciyverify.com/anzzzzz/anzinstall.sh | sh -s 127.0.0.1 hdakjsdhaskhnkcnzxck
```



## 拨号centos客户端使用方法 (用pppoe-start 和 pppoe-stop 去拨号的)
1. 把压缩包里面的文件放入 安卓的 /data/cyIp 目录下
2. cd /data/cyIp 进入安卓的目录
3. chmod +x ./main 给权限
4. ./main 启动 (启动前要确保服务端已经开启了)
### 安卓arm客户端快速使用方法  （不想执行上面代理的话）
```sh
# curl -sSL https://ciyverify.com/cento/anzinstall.sh | sh -s 服务端外网地址 你的校验token(frptoken)
curl -sSL https://ciyverify.com/cento/anzinstall.sh | sh -s 127.0.0.1 hdakjsdhaskhnkcnzxck
```


## 从代理池中获取ip代理


```python

# url = "http://服务端ip:服务端的获取代理的端口/getProxy/服务端的token/组"

url = "http://213.126.207.110:9990/getProxy/5779264dcad8f31c61f8108a9fc9d17f/cbb"

response = requests.get(url)
print(response.text)

# {"proxy":"kz7LUHAk-0xNTQ==:SI1T6KkoFchY3g==@127.0.0.1:20000","code":200}
```

## 从代理池所有节点配置

```python
# url = "http://服务端ip:服务端的获取代理的端口/getConfig/服务端的token"
url = "http://213.126.207.110:9990/getConfig/5779264dcad8f31c61f8108a9fc9d17f"
response = requests.get(url,
                    )
print(response.text)

# {"code":200,"data":[{"proxyPort":20000,"id":"23288566-fd00-40c3-ad27-66470f5c7698","addr":"127.0.0.1","group":"cbb","token":"KhLBooCCJRFGorQv1QlKCpJA3PhaWtoN","serverPort":20001,"serverProxyIp":"127.0.0.1","nameInfo":"kz7LUHAk-0xNTQ==","password":"SI1T6KkoFchY3g=="}]}

```

## 把别人的节点添加到自己的代理池中
```python
import requests
url = "http://127.0.0.1:9990/pushIpConfig/5779264dcad8f31c61f8108a9fc9d17f"

response = requests.post(url,
                        json=[{"proxyPort":20000,"id":"0fb283c7-b376-4a40-ba33-cbfe5e1aa95a","addr":"106.228.116.174","group":"cbb","token":"uwTiYpM9RbLmKG81_uLZdujgIW_6yz7U","serverPort":20001,"serverProxyIp":"221.227.122.182","nameInfo":"unaGF5Nm6wgSLA==","password":"t_hKzQhs9CFUnQ=="},{"proxyPort":20002,"id":"d35be4ed-41aa-4911-8690-34dc041203e3","addr":"117.57.74.213","group":"cbb","token":"JkbpAqgjhuf6iIXAnIDGU6xATVPzY9bZ","serverPort":20003,"serverProxyIp":"221.227.122.182","nameInfo":"Ujqs9dCsZOx3ng==","password":"pLoeBRC1va_TiQ=="},{"proxyPort":20004,"id":"c1df20cb-eadf-43d3-9136-b5baa2d37fbf","addr":"59.58.47.73","group":"cbb","token":"_vfuUwcDY4lUhySomDqNIRxJUQsoDbtP","serverPort":20005,"serverProxyIp":"221.227.122.182","nameInfo":"pBuShX7c1RikcQ==","password":"3HFmoeqHJrq7fw=="},{"proxyPort":20008,"id":"1e2843f6-95c4-474d-a4e7-fc9184eb833d","addr":"116.7.198.237","group":"cbb","token":"eEGanyiMrWByhbvbYuuNPuayHBK7EWct","serverPort":20009,"serverProxyIp":"221.227.122.182","nameInfo":"cWvBR7CtnekkVQ==","password":"jJw22hIr-gpEFg=="}]

                    )
print(response.text)

# okk
```

### 知识星球 交流讨论爬虫技术
https://t.zsxq.com/194IAl5UN




