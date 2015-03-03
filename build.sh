 #! /bin/bash
 mkdir -p /opt/openolympus/xtreemfs_data/
 rsync openolympus-xtreemfs/* /opt/openolympus/xtreemfs_data/
 cd xtreemfs-docker
 ./build.sh
 cd ..
 git clone http://github.com/nickguletskii/OpenOlympus-Cerberus
 git clone http://github.com/nickguletskii/OpenOlympus
 cd OpenOlympus-Cerberus
 git checkout development
 mvn clean install
 cd ../OpenOlympus
 git checkout newdevelopment
 mvn clean install
 cd ..
 cp OpenOlympus/target/openolympus-0.1.0-SNAPSHOT.jar openolympus-web-docker/openolympus.jar
 docker-compose build
