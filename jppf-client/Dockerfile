FROM ubuntu
MAINTAINER nick@nickguletskii.com

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

RUN sudo apt-get -y update
RUN sudo apt-get -y install software-properties-common rsync git build-essential cmake
RUN sudo add-apt-repository -y ppa:webupd8team/java
RUN sudo apt-get -y update
RUN sudo apt-get -y -q install fp-compiler-2.6.2 fp-units-base-2.6.2 fp-units-math-2.6.2 fp-units-misc-2.6.2
RUN sudo apt-get --no-install-recommends -y install oracle-java8-installer g++ unzip rsync wget

RUN wget -c http://downloads.sourceforge.net/project/jppf-project/jppf-project/jppf%204.2.5/JPPF-4.2.5-node.zip
RUN unzip JPPF-4.2.5-node.zip

RUN mkdir -p /opt/jppfnode/
RUN rsync -r JPPF-4.2.5-node /opt/jppfnode/
RUN chmod +x /opt/jppfnode/JPPF-4.2.5-node/startNode.sh

RUN echo "deb http://download.opensuse.org/repositories/home:/xtreemfs/xUbuntu_14.04/ ./" >> /etc/apt/sources.list
RUN bash -c "wget -q http://download.opensuse.org/repositories/home:/xtreemfs/xUbuntu_13.10/Release.key -O - | sudo apt-key add -"
RUN sudo apt-get update

RUN sudo apt-get -y install xtreemfs-client

COPY config /opt/jppfnode/JPPF-4.2.5-node/config
COPY runNode.sh /opt/jppfnode/JPPF-4.2.5-node/runNode.sh

COPY createChroot.sh /usr/sbin/createChroot.sh


RUN wget -c http://downloads.sourceforge.net/project/libsandbox/0.3.5/libsandbox_0.3.5-3_amd64.deb
RUN dpkg -i libsandbox_0.3.5-3_amd64.deb

RUN createChroot.sh

WORKDIR /opt/jppfnode/JPPF-4.2.5-node
CMD ["./runNode.sh"]
