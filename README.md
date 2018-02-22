# sms3 Gateway Dockerized
This script create a container that run sms3 gateway.

Based on Ubuntu 16.04 LTS (https://www.ubuntu.com/)

Based on SMS3 sms gateway Version 3.1.21 (http://smstools3.kekekasvi.com/index.php?p=)

## Usage

### Build the image
```shell
docker build -t="docker-sms3" .
```
This create the image on your docker. To show list of your images:
```shell
docker images
```
### Create the container
```shell
docker create \
--name sms3 \
--device=/dev/ttyUSB1 \
-t -i docker-sms3
```
Use option _--device_ to connect the GSM modem from the host, to docker container. This option is supported from Docker 1.2.0 and above.
