############################################################
# Dockerfile to build SMS3 container images
# Based on Ubuntu
############################################################

FROM ubuntu:16.04
MAINTAINER Marcolino <marco.pozzuolo@gmail.com>

################## BEGIN INSTALLATION ######################
# Update apt and install compilers, tar and wget
RUN apt-get update && \ 
    apt-get -y install gcc make tar wget nano curl logrotate cron sudo procmail && \
    apt-get -y install php7.0 libapache2-mod-php7.0

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

# Copy Setup script to folder and setting permission
ADD ./script/setup.sh /etc/myscript/setup.sh
RUN chmod 755 /etc/myscript/setup.sh

# Copy Logrotate configuration and setting security
ADD ./extra/smsd.logrotate /etc/logrotate.d/smsd.logrotate
RUN chmod 0644 /etc/logrotate.d/smsd.logrotate

# Copy PHP script to send SMS
ADD ./script/send_sms.php /var/www/html/send_sms.php

# Adding to sudoers www-data for run related script
RUN echo 'www-data ALL=NOPASSWD: /usr/local/bin/sendsms' >> /etc/sudoers

# Restarting Apache
RUN /etc/init.d/apache2 restart

# Sart the custom start script
ENTRYPOINT ["/etc/myscript/start.sh"]

