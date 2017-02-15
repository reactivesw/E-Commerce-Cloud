# 1, E-Commerce-Cloud
e-commerce cloud.

# 2, Repo status
 
# 3, Introduction

# 4, Build & Run
## 4.1 Build
Step one: clone the source

```
git clone https://github.com/reactivesw/E-Commerce-Cloud

cd E-Commerce-Cloud

git submodule update --recursive --init

```
Step two: build the source
E-Commerce-Cloud is an gradle project, so before you build, make sure you have installed gradle(recommend 3.*).

```
gradle wrapper

./gradlew clean build

```

## 4.2 Run
As we used micro-service architecture, so we got many micro-services. For now, each micro-service is build with spring-boot. 
You can run on your local machine, or run it on your k8s cluster(we recommend this way).

Step one: you should got an git repo for keep our configs(or you just keep the config on your local)

Step two: config the config-service, and then start up the config-service.(just as run an spring-boot project)

Step three: run the service you need.



# 5, Features

## 5.1, The techniques we choose
- config：config-server(git) + k8s(secret):
- service discovery: k8s(DNS)
- load balance: k8s(ingress)
- API gateway: k8s
- service security: Intranet + token, no center
- centralized logging: k8s(EFK)
- monitor & tracing: k8s
- auto scaling & self healing: k8s
- package, deploy: docker & k8s
- Event bus: kafka

# 6, Design


