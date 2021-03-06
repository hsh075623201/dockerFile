#version 0.0.1
FROM ubuntu
MAINTAINER huangsihao "hsh.0223.ok@163.com"

# Get noninteractive frontend for Debian to avoid some problems: #    debconf: unable to initialize frontend: Dialog
ENV DEBIAN_FRONTEND noninteractive

#:RUN ln -snf /bin/bash /bin/sh

# install command tools
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe"> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y vim
RUN apt-get install -y ssh
RUN apt-get install -y openssh-server

#create directory of download software
RUN mkdir -p /usr/software

#install JDK
RUN wget  --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  -P /usr/software http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
RUN tar -xzvf /usr/software/jdk-7u79-linux-x64.tar.gz -C /usr/software/
ENV JAVA_HOME /usr/software/jdk1.7.0_79
ENV PATH ${PATH}:${JAVA_HOME}/bin
# install tomcat7
RUN apt-get install -y tomcat7

#change pwd
RUN echo "root:root" | chpasswd

# export port
EXPOSE 22
EXPOSE 8080

#add file
ADD start.sh ./start.sh
RUN chmod +x ./start.sh
# run
ENTRYPOINT ["./start.sh"] 
