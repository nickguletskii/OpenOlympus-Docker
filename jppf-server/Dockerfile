FROM ubuntu
MAINTAINER nick@nickguletskii.com

RUN sudo sed 's@http://archive.ubuntu.com/ubuntu@mirror://mirrors.ubuntu.com/mirrors.txt@' -i /etc/apt/sources.list
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

RUN sudo apt-get -y update
RUN sudo apt-get -y install software-properties-common
RUN sudo add-apt-repository -y ppa:webupd8team/java
RUN sudo apt-get -y update
RUN sudo apt-get -y install oracle-java8-installer
RUN sudo apt-get -y install unzip rsync

RUN wget -c http://master-dl.sourceforge.net/project/jppf-project/jppf-project/jppf%204.2.5/JPPF-4.2.5-driver.zip
RUN unzip JPPF-4.2.5-driver.zip

RUN mkdir -p /opt/jppfserver/
RUN rsync -r JPPF-4.2.5-driver /opt/jppfserver/
RUN chmod +x /opt/jppfserver/JPPF-4.2.5-driver/startDriver.sh

COPY config /opt/jppfserver/JPPF-4.2.5-driver/config

EXPOSE 11111
EXPOSE 11198

WORKDIR /opt/jppfserver/JPPF-4.2.5-driver
CMD ["/opt/jppfserver/JPPF-4.2.5-driver/startDriver.sh"]
 
