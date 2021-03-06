FROM ubuntu
MAINTAINER nick@nickguletskii.com

RUN useradd -ms /bin/nologin openolympus

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

RUN sudo sed 's@http://archive.ubuntu.com/ubuntu@mirror://mirrors.ubuntu.com/mirrors.txt@' -i /etc/apt/sources.list

RUN apt-get -y update
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN apt-get -y install oracle-java8-installer g++ unzip rsync git \
			make ant build-essential cmake libfuse-dev \
			libattr1-dev libssl-dev libboost-system-dev \
			libboost-thread-dev libboost-regex-dev \
			libboost-program-options-dev
    
WORKDIR /install

RUN mkdir /install/openolympus    

RUN mkdir -p /opt/openolympus/storage

COPY openolympus.jar /opt/openolympus/openolympus.jar

COPY jppf.properties /opt/openolympus/jppf.properties
COPY openolympus.properties /opt/openolympus/openolympus.properties

RUN ln -s /opt/openolympus/openolympus.properties /opt/openolympus/application.properties
RUN ln -s /opt/openolympus/openolympus.properties /opt/openolympus/spring.properties

WORKDIR /opt/openolympus/

CMD ["/usr/bin/java", "-jar", "-Dlogging.file=/var/log/openolympus.log", "-Djppf.config=/opt/openolympus/jppf.properties", "/opt/openolympus/openolympus.jar"]