 #! /bin/bash
 mkdir -p /opt/openolympus/storage/
 git clone http://github.com/nickguletskii/OpenOlympus-Cerberus
 git clone http://github.com/nickguletskii/OpenOlympus
 cd OpenOlympus-Cerberus
 git checkout development
 git pull
 mvn install
 cd ../OpenOlympus
 git checkout newdevelopment
 git pull
 mvn install
 cd ..
 cp OpenOlympus/target/openolympus-0.1.0-SNAPSHOT.jar openolympus-web-docker/openolympus.jar
 docker-compose build
