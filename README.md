# SMSTool3 Dockerized
This script create a container that run smstool3y.

Based on Ubuntu 16.04 LTS (https://www.ubuntu.com/)

Based on SMSTool3 sms gateway Version 3.1.21 (http://smstools3.kekekasvi.com/index.php?p=)

Supported on Docker 1.20 and above (https://www.docker.com/)

## Feature
Full SMSTool3 server based on Ubuntu, with cron, logrotate, wget and curl just installed.

## Usage
Download the files from github, and unzip in a forder called _/docker-sms3_, cd into this folder.

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
--name docker-sms3-container \
--device=/dev/ttyUSB1 \
-v /etc/smsd.conf:/etc/smsd.conf \
-v /etc/localtime:/etc/localtime:ro \
-t -i docker-sms3
```
Use option _--device_ to connect the GSM modem from the host, to docker container. This option is supported from Docker 1.2.0 and above.
In order to make smsd.conf editable, you shoud use _-v_ options to map the file from inside the container to a path on host.

Option _-v /etc/localtime:/etc/localtime:ro_ will setup the timezone of the container to same timezone of your host.

### Run the container
Copy _smsd.conf_ included into this repository to local _/etc_ folder, before running the container.
```shell
cp ./extra/smsd.conf /etc/smsd.conf
```
Then run the just created container
```shell
docker start docker-sms3-container
```
smsd logs, are redirected to container's stdout, so you can easily check whats happen
```shell
docker logs docker-sms3-container
```
### Sending an SMS
```shell
docker exec -i -t docker-sms3-container /bin/bash /etc/myscript/sms_send.sh +39XXXXXXXXXX "Sending of test message"
```
or
```shell
docker exec -i -t docker-sms3-container /bin/bash sendsms +39XXXXXXXXXX 'Sending of test message'
```
Please note, use the telefone number in E.164 format, using the international prefix with + ahead. Don't exeed 160 charaters for message.
### Receiving SMS

Still in working
