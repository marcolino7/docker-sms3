FROM ubuntu:16.04
MAINTAINER Marcolino <marco.pozzuolo@gmail.com>

# Update apt and Install Compiler and wget
RUN apt-get update
RUN apt-get -y install gcc make tar wget


# Download source version 3.1.21
RUN wget http://smstools3.kekekasvi.com/packages/smstools3-3.1.21.tar.gz
RUN tar -xzf smstools*.tar.gz

# Make and install 
RUN make -C /smstools3
RUN make install -C /smstools3

# Clean files and Directory
RUN rm -r /smstools*




# Use a volume for sms3 configuration files
#VOLUME ["/etc/smsd.conf"]

# Copy backup script and add permission
#COPY my-influx-backup.sh /usr/bin/my-influx-backup
#RUN chmod 0755 /usr/bin/my-influx-backup

#ENTRYPOINT ["/usr/bin/my-influx-backup"]
#CMD ["cron", "0 1 * * *"]
