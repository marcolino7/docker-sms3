FROM ubuntu:16.04
MAINTAINER Marcolino <marco.pozzuolo@gmail.com>

# Update apt and Install Compiler and wget and clean
RUN apt-get update
RUN apt-get -y install gcc make tar wget
RUN apt-get clean


# Download source version 3.1.21
RUN wget http://smstools3.kekekasvi.com/packages/smstools3-3.1.21.tar.gz
RUN tar -xzf smstools*.tar.gz

# Make and install 
RUN make -C /smstools3
RUN make install -C /smstools3

# Clean files and Directory
RUN rm -r /smstools*

# Create a script folder into /etc
RUN mkdir /etc/myscript

# Copy scripts to folder and setting permission
ADD ./script/start.sh /etc/myscript/start.sh
RUN chmod 755 /etc/myscript/start.sh

# Sart the custom start script
#CMD ["/bin/bash", "/etc/myscript/start.sh"]
ENTRYPOINT ["/etc/myscript/start.sh"]


# Use a volume for sms3 configuration files
#VOLUME ["/etc/smsd.conf"]

# Copy backup script and add permission
#COPY my-influx-backup.sh /usr/bin/my-influx-backup
#RUN chmod 0755 /usr/bin/my-influx-backup

#ENTRYPOINT ["/usr/bin/my-influx-backup"]
#CMD ["cron", "0 1 * * *"]
