create_directories:
	mkdir -p /opt/openolympus/storage/
	mkdir -p /opt/openolympus/docker/
	mkdir -p /opt/OpenOlympus/go/
pull-repos:
	test -d OpenOlympus-Cerberus || git clone https://github.com/nickguletskii/OpenOlympus-Cerberus
	test -d OpenOlympus ||git clone https://github.com/nickguletskii/OpenOlympus
install-cerberus: pull-repos
	cd OpenOlympus-Cerberus; \
	git checkout development;\
	git pull;\
	mvn install
install-olympus: pull-repos install-cerberus
	cd OpenOlympus;\
	git checkout development;\
	git pull;\
	mvn install
copy-olympus: install-olympus
	cp OpenOlympus/target/openolympus-0.1.0-SNAPSHOT.jar openolympus-web-docker/openolympus.jar
build-jppf-client:
	cd jppf-client;\
	docker build -t "openolympus_jppf_client" .
build-jppf-server:
	cd jppf-server;\
	docker build -t "openolympus_jppf_server" .
build-database:
	cd openolympus-postgres;\
	docker build -t "openolympus_postgres" .
build-web-server: install-olympus
	cd openolympus-web-docker;\
	docker build -t "openolympus_web" .
build-docker: build-jppf-client build-jppf-server build-database build-web-server
install-systemd-docker: create_directories
	wget --output-document=/usr/local/bin/systemd-docker -c https://github.com/ibuildthecloud/systemd-docker/releases/download/v0.2.0/systemd-docker && chmod +x /usr/local/bin/systemd-docker
install-services:
	cp systemd/openolympus_postgres.service /etc/systemd/system/openolympus_postgres.service
	cp systemd/openolympus_web.service /etc/systemd/system/openolympus_web.service
	cp systemd/openolympus_jppf_server.service /etc/systemd/system/openolympus_jppf_server.service
	cp systemd/openolympus_jppf_client.service /etc/systemd/system/openolympus_jppf_client.service
	systemctl daemon-reload