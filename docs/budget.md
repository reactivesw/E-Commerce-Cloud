
# 系统预算报告



## 正在使用的需要付费的服务/资源

-   custom machine type (vm instance 1 vCpu,4 GB ram)x3
-   standard provisioned space (standard persistent disk 100GB)x3
-   load balancing (load balance rules)x8
-   cloud pub/sub service
-   Internet egress



## 相应资源的报价

-   Custom machine types
    
    | item   | price(USD)            |
	|----|----|
    | vCPU   | $16.96/vCPU month     |
    | Memory | $2.35/GB month        |
    | vCPU   | $0.033174 / vCPU hour |
    | Memory | $0.004446 / GB hour   |
-   Network

egress

| Monthly Usage | Network(Egress)worldwide excluding China,Australia | Network(Egress)China | Network(Egress)Australia |
|----|----|----|----|
| 0-1TB         | $0.12(per Gb)                                      | $0.23(per Gb)        | $0.19                    |
| 1-10TB        | $0.11(per Gb)                                      | $0.22(per Gb)        | $0.18                    |
| 10+TB         | $0.08(per Gb)                                      | $0.15(per Gb)        | $0.15                    |

general network pricing

| General type                                       | price |
|----|----|
| Egress\* between zones in the same region (per GB) | $0.01 |
| Egress between regions within the US (per GB)      | $0.01 |

-   Storage disk pricing
    
    | Type                       | Price(Per GB/month) |
	|----|----|
    | Standard provisioned space | $ 0.040             |
    | SSD provisioned space      | $ 0.170             |
    | Snapshot storage           | $ 0.026             |

-   Load balancing and protocol forwarding

| Item                           | Price per Unit($) | Pricing Unit |
|----|----|----|
| First 5 forwarding rules       | $ 0.025           | Per Hour     |
| Per additional forwarding rule | $ 0.010           | Per hour     |
| Data processed                 | $ 0.008           | Per GB       |

-   Cloud pub/sub service
    
    | Monthly data volume | Price Per GB |
	|----|----|
    | First 10Gb          | $0.00        |
    | Next 50TB           | $0.06        |
    | Next 100TB          | $0.05        |
    | Beyond 150TB        | $0.04        |



## 计算月预算

因为大部分费用是以每小时的使用情况进行计算的，而某些资源应该 7x24 被使用的， 例如 vCPU,RAM,Disk. 而另外的资源则是根据实际的请求情况进行费用计算，例如 load balancing 就是根据请求的小时数计算费用，但是一天中请求的时间并不固定，所以只 能通过以往的数据进行估算。其次，例如 Egress 所产生的流量费用情况也是不固定的， 所以根据以往数据进行估算。

1.  Static 7x24

    假定这些服务都是 7x24 运行的。
    
    -   CPU (customer machine type vCPU)x3=3x24x30x0.033174~=71.6
    -   RAM (customer machine type Memory)x4x3=3x4x24x30x0.004446~=38.41
    -   Disk standard space x 300GB=300x0.04=12

2.  Dynamic

    -   Load balancing 负载均衡 5个以内的规则是每小时 $0.025,如果超出5 个规则，则每个规则每小时按 $0.01 计算。 5个规则一个月的服务时间估算得约 700 小时： ~700x0.025~=17.5
        
        额外的3个规则一个月的服务时间估算得约等于共 1200 小时 ~1200x0.01~=12.0
    
    -   Egress 流量的出口除了到中国和澳洲是不同价格以外，其他都是统一价格 到中国的流量费用是每GB $0.023; 而每个月从美国到中国的流量估算约为 0.1GB: ~0.1x 0.23 ~=0.03 同一区域的费用是每 GB $0.01; 而每个月同一区域产生的流量约为 7GB: ~7x 0.01~=0.07
    
    -   Cloud pub/sub Google cloud platform 提供的 publish/subscribe 服务开始使用的 10GB 是免费， 在此以后，按阶段收费。估算得，现阶段每个月 publish/subscribe 产生得流量大 概是0.040TB (但是这个数字肯定会随着启用 event 服务的增多而增加). 因为现在 (2017-05) 刚启用 pub/sub 服务，所以最初的 10GB 免费:
        
        -   first month (0.04x1024-10)x0.06~=1.8
        
        -   later (Next 50TB)
        
        0.04x1024x0.06~=2.4576
    
    总费用约等于 $154.06 每月。
