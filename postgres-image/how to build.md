# Build Postgres Image

## 1. Build

```shell
# build image
docker build -t reactivesw/postgres:{version} .
```

## 2. Push

Before push image to docker hub, you need to login docker hub.

```shell
docker push {image name}
```