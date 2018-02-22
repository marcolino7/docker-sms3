# sms3 Gateway Dockerized
This script create a container that run sms3 gateway.

Based on Ubuntu 16.04 LTS (https://www.ubuntu.com/)

Based on SMS3 sms gateway Version 3.1.21 (http://smstools3.kekekasvi.com/index.php?p=)

Supported on Docker 1.20 and above (https://www.docker.com/)

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
-t -i docker-sms3
```
Use option _--device_ to connect the GSM modem from the host, to docker container. This option is supported from Docker 1.2.0 and above.
In order to make smsd.conf editable, you shoud use _-v_ options to map the file from inside the container to a path on host.
### Run the container
Copy _smsd.conf_ included into this repository to local _/etc_ folder, before running the container.
```shell
cp smsd.conf /etc/smsd.conf
```
Then run the just created container
```shell
docker start docker-sms3-container
```
smsd logs, are redirected to container's stdout, so you can easily check whats happen
```shell
docker start docker-sms3-container
```
