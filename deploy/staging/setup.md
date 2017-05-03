# Setup

1. namespace

```shell
kubectl create -f namespace_staging.yaml
```

2. secrets

Before create secrets, should edit the file and set secret config.

```shell
kubectl create -f secrets/secrets.yaml
```

3. database

```shell
kubectl create -f postgres/reactivesw_data.yaml
```

4. config server

```shell
kubectl create -f config/k8s.yaml
```

5. redis

```shell
kubectl create -f redis/redis_k8s.yaml
```

6. micro service

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

7. api gateway

```shell
kubectl create -f api-gateway/k8s.yaml
```

8. customer web

```shell
kubectl create -f customer-web/deployment.yaml
kubectl create -f customer-web/service.yaml
```