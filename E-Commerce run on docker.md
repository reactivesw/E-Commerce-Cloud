# E-Commerce run on docker

## 1. Introduce

todo

## 2. Run Environment

* OS X 10.11.3
* Docker version 17.03.0-ce

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

## 6. api-gateway

```shell
docker pull reactivesw/api-gateway

```

## 7. micro service