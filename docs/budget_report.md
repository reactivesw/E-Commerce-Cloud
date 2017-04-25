# 系统预算报告

## 资源开销

每一套系统，实际包括了三套运行环境，分别是

* dev
* staging
* production

这三套运行环境的部署情况完全一样，均需要以下服务：

* k8s cluster
* Load Balance
* pub/sub

每个运行环境包括14个服务，以下是每个服务在正常运行时的资源开销：

| service name | memory | pub/sub | Load Balance |
|---|---|---|---|
| postgres database | 300M | | |
| redis | | 50M | | |
| config server | 200M | | |
| api gateway | 200M | | required |
| cart | 700M | required | |
| category | 700M | required | |
| customer-info | 400M | | |
| customer-authentication | 700M | required | |
| inventory | 700M | required | |
| order | 700M | required | |
| payment | 700M | required | |
| product | 700M | required | |
| product-type | 400M | | |
| customer-web | 100M | | required |

共需要memory为：5850M＝5.7G。

三套环境，理论上需要5.7*3=17.1G。加上k8s环境，需要申请20G的内存空间。

## 资金开销

对每一个project，使用的收费服务主要包括:

机器：vCPU ＋ instance Core ＋ instance Ram
硬盘：log＋Persistent Volumes
网络：load balance + egress

各项的预算：
vCPU：$100
instance Core: $20
instance Ram: $5
硬盘: $10
load balance: $25
egress: 暂时无法估算
总计：¥160