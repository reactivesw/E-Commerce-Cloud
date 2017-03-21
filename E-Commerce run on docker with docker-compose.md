# E-Commerce run on docker with docker-compose

## 1. Introduce

todo

## 2. Run Environment

* OS X 10.11.3
* Docker version 17.03.0-ce ([install refence](https://www.docker.com/community-edition#/download))
* Docker Compose version 1.8.0 ([install refence](https://docs.docker.com/compose/install/))

## 3. export localhost ip address

```shell
export HOSTADDRESS=`ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1`
```

## 4. run micro service with docker compose

cd to `docker-compose.yaml` directory, use docker compose command to setup E-Commerce:

`docker-compose up`

setup will take a long time (download images and setup container), after it, visit each micro service health api, and get correct response

```
http://localhost:8889/carts/health
# cart, system time: 1488952103544

http://localhost:8889/categories/health
# category, system time: 1488952103544

```