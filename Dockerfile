############################################################
# Dockerfile to build SMS3 container images
# Based on Ubuntu
############################################################

FROM ubuntu:16.04
MAINTAINER Marcolino <marco.pozzuolo@gmail.com>

################## BEGIN INSTALLATION ######################
# Update apt and install compilers, tar and wget
RUN apt-get update
RUN apt-get -y install gcc make tar wget nano

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

# Create a script folder into /etc
RUN mkdir /etc/myscript

# Copy scripts to folder and setting permission
ADD ./script/start.sh /etc/myscript/start.sh
RUN chmod 755 /etc/myscript/start.sh

# Sart the custom start script
ENTRYPOINT ["/etc/myscript/start.sh"]

