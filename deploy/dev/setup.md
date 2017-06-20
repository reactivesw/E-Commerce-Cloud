# reactivesw setup on gke

## 1. gke project setup

创建一个project，参考 [reference](https://cloud.google.com/resource-manager/docs/creating-managing-projects)

创建之后，记录project id，在gcloud sdk和pub sub的配置中都需要使用。

### 配置本地gcloud sdk

project创建之后，本地访问需要设置该project

```shell
# reactivesw-project2为project id
 gcloud config set project reactivesw-project2
```

## 2. container cluster setup

启动container engine，参考[reference](https://cloud.google.com/container-engine/docs/quickstart)

注意要启动 cloud pubsub api

### 本地连接container cluster

在container engine启动后，可以获取到对应的连接脚本

```shell
gcloud container clusters get-credentials cluster-1 --zone us-central1-a --project reactivesw-project1
kubectl proxy -&
```

## 3. pub sub

pubsub的topic和subscription已经写在脚本中，直接执行该脚本即可：

```shell
sh ./topic/create.sh
```

## 4. 启动服务

### namespace

```shell
kubectl create -f namespace_dev.yaml
```

### secrets

Before create secrets, should edit the file and set secret config.

```shell
kubectl create -f secrets/secrets.yaml
```

### database

```shell
kubectl create -f postgres/reactivesw_data.yaml
```

### config server

```shell
kubectl create -f config/k8s.yaml
```

### redis

```shell
kubectl create -f redis/redis_k8s.yaml
```

### micro service

启动后台服务前，需要修改脚本内的io_reactivesw_message_google_project_id配置，设置该值为新建的project id

```shell
kubectl create -f micro-service/cart_k8s.yaml
kubectl create -f micro-service/authentication_k8s.yaml
kubectl create -f micro-service/category_k8s.yaml
kubectl create -f micro-service/customer_k8s.yaml
kubectl create -f micro-service/inventory_k8s.yaml
kubectl create -f micro-service/order_k8s.yaml
kubectl create -f micro-service/payment_k8s.yaml
kubectl create -f micro-service/product_k8s.yaml
kubectl create -f micro-service/producttype_k8s.yaml
```

### api gateway

```shell
kubectl create -f api-gateway/k8s.yaml
```

### customer web

需要使用api gateway地址重新打包编译

```shell
kubectl create -f customer-web/deployment.yaml
kubectl create -f customer-web/service.yaml
```

### insert data

use project test-data

### setup payment and restart deployment

post config to url: `http://{api-gateway url}/payments/config`

```markdown
{
  "environment": "",
  "merchantId": "",
  "publicKey": "",
  "privateKey": ""
}
```
