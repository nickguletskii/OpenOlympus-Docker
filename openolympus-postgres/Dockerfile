FROM postgres:9.3
MAINTAINER nick@nickguletskii.com
COPY setup-schema.sh /docker-entrypoint-initdb.d/
COPY fix-acl.sh /docker-entrypoint-initdb.d/
EXPOSE 5433:5432