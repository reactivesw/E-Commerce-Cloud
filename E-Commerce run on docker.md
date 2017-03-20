# E-Commerce run on docker

## 1. Introduce

todo

## 2. Run Environment

* OS X 10.11.3
* Docker version 17.03.0-ce
* postgresql 9.6.1

## 3. micro service introduce


## 4. postgres

```shell

docker pull postgres
docker run --name ecommerce-db -p 5452:5432 -e POSTGRES_PASSWORD=root -d postgres

```

PS : 使用本地端口5452是因为我本地的5432端口被本地postgres占了

在postgres启动之后，使用psql连接并执行创建数据库的命令：

```shell
# connect to postgres container, type in password root setted at run command
psql -h localhost -p 5452 -U postgres

# create database for each micro service
create database cart;
create database category;
create database customer_authentication;
create database customer_info;
create database inventory;
create database orders;
create database payment;
create database product;
create database product_type;
```

## 5. redis

```shell
docker pull redis
docker run --name redis -d redis
```

This image includes EXPOSE 6379 (the redis port), so standard container linking will make it automatically available to the linked containers (as the following examples illustrate).

## 6. export localhost ip address

```shell
export HOSTADDRESS=`ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1`
```

## 7. micro service

```shell
docker pull reactivesw/cart:0.0.1
docker pull reactivesw/category:0.0.1
docker pull reactivesw/customer-authentication:0.0.1
docker pull reactivesw/customer-info:0.0.1
docker pull reactivesw/inventory:0.0.1
docker pull reactivesw/order:0.0.1
docker pull reactivesw/payment:0.0.1
docker pull reactivesw/product:0.0.1
docker pull reactivesw/product-type:0.0.1
```


### category

```shell
docker run --name category -e "SPRING_DATASOURCE_URL=jdbc:postgresql://${HOSTADDRESS}:5452/category" -p 8082:8082 reactivesw/category:0.0.1
```

### product-type

```shell
docker run --name product-type -e "SPRING_DATASOURCE_URL=jdbc:postgresql://${HOSTADDRESS}:5452/product_type" -p 8089:8089 reactivesw/product-type:0.0.1
```

### inventory

```shell
docker run --name inventory -e "SPRING_DATASOURCE_URL=jdbc:postgresql://${HOSTADDRESS}:5452/inventory" -p 8085:8085 reactivesw/inventory:0.0.1
```

### payment

```shell
docker run --name payment -e "SPRING_DATASOURCE_URL=jdbc:postgresql://${HOSTADDRESS}:5452/payment" -e "BRAINTREE_ENVIRONMENT=sanbox" -e "BRAINTREE_MERCHANTID=zd4ykzzngrhgnbdv" -e "BRAINTREE_PUBLICKEY=j55k9vx4y7kp48yw" -e "BRAINTREE_PRIVATEKEY=e993538bfa75c350dac4f3c95b377e26" -p 8087:8087 reactivesw/payment:0.0.1
```

### product

```shell
docker run --name product -e "SPRING_DATASOURCE_URL=jdbc:postgresql://${HOSTADDRESS}:5452/product" -e "PRODUCTTYPE_SERVICE_URI=http://${HOSTADDRESS}:8089/" -e "INVENTORY_SERVICE_URI=http://${HOSTADDRESS}:8085/" -p 8088:8088 reactivesw/product:0.0.1
```

### customer-info

```shell
docker run --name customer-info -e "SPRING_DATASOURCE_URL=jdbc:postgresql://${HOSTADDRESS}:5452/customer_info" -p 8084:8084 reactivesw/customer-info:0.0.1
```

### customer-authentication

```shell
docker run --name customer-auth -e "SPRING_DATASOURCE_URL=jdbc:postgresql://${HOSTADDRESS}:5452/customer_authentication" --link redis:redis -p 8083:8083 reactivesw/customer-authentication:0.0.1
```

### cart

```shell
docker run --name cart -e "SPRING_DATASOURCE_URL=jdbc:postgresql://${HOSTADDRESS}:5452/cart" -e "PRODUCT_SERVICE_URI=http://${HOSTADDRESS}:8088/" -e "CUSTOMER_SERVICE_URI=http://${HOSTADDRESS}:8084/" -p 8081:8081 reactivesw/cart:0.0.1
```

172.17.0.7

### order

```shell
docker run --name order -e "SPRING_DATASOURCE_URL=jdbc:postgresql://${HOSTADDRESS}:5452/orders" -e "CART_SERVICE_URI=http://${HOSTADDRESS}:8081/" -e "PAYMENT_SERVICE_URI=http://${HOSTADDRESS}:8087/" -e "INVENTORY_SERVICE_URI=http://${HOSTADDRESS}:8085/" -p 8086:8086 reactivesw/order:0.0.1
```

## 8. api-gateway

```shell
docker pull reactivesw/api-gateway:0.0.1
```

run api-gateway

```shell
docker run --name api-gateway -p 8889:8889 \
-e "zuul.routes.cart.path=/carts/**" \
-e "zuul.routes.cart.url=http://${HOSTADDRESS}:8081/" \
-e "zuul.routes.category.path=/categories/**" \
-e "zuul.routes.category.url=http://${HOSTADDRESS}:8082/" \
-e "zuul.routes.auth.path=/auth/**" \
-e "zuul.routes.auth.url=http://${HOSTADDRESS}:8083/" \
-e "zuul.routes.customer.path=/customers/**" \
-e "zuul.routes.customer.url=http://${HOSTADDRESS}:8084/" \
-e "zuul.routes.inventory.path=/inventory/**" \
-e "zuul.routes.inventory.url=http://${HOSTADDRESS}:8085/" \
-e "zuul.routes.order.path=/orders/**" \
-e "zuul.routes.order.url=http://${HOSTADDRESS}:8086/" \
-e "zuul.routes.payment.path=/payments/**" \
-e "zuul.routes.payment.url=http://${HOSTADDRESS}:8087/" \
-e "zuul.routes.product.path=/products/**" \
-e "zuul.routes.product.url=http://${HOSTADDRESS}:8088/" \
-e "zuul.routes.product-type.path=/product-types/**" \
-e "zuul.routes.product-type.url=http://${HOSTADDRESS}:8089/" \
reactivesw/api-gateway:0.0.1
```
