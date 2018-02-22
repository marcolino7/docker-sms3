############################################################
# Dockerfile to build SMS3 container images
# Based on Ubuntu
############################################################

FROM ubuntu:16.04
MAINTAINER Marcolino <marco.pozzuolo@gmail.com>

################## BEGIN INSTALLATION ######################
# Update apt and install compilers, tar and wget
RUN apt-get update
RUN apt-get -y install gcc make tar wget nano curl logrotate cron

# Download source version 3.1.21
RUN wget http://smstools3.kekekasvi.com/packages/smstools3-3.1.21.tar.gz
RUN tar -xzf smstools*.tar.gz

# Make and install 
RUN make -C /smstools3
RUN make install -C /smstools3

# Clean apt, files and Directory
RUN rm -r /smstools*
RUN apt-get clean
##################### INSTALLATION END #####################

# Redirect sms3 logs to stdout
RUN ln -sf /dev/stdout /var/log/smsd.log

# Create a script folder into /etc
RUN mkdir /etc/myscript

# Copy start script to folder and setting permission
ADD ./script/start.sh /etc/myscript/start.sh
RUN chmod 755 /etc/myscript/start.sh

# Copy sms_send script to folder and setting permission
ADD ./script/sms_send.sh /etc/myscript/sms_send.sh
RUN chmod 755 /etc/myscript/sms_send.sh

# Copy Logrotate configuration and setting security
ADD ./extra/smsd.logrotate /etc/logrotate.d/smsd.logrotate
RUN chmod 0644 /etc/logrotate.d/smsd.logrotate

# Sart the custom start script
ENTRYPOINT ["/etc/myscript/start.sh"]

