ARG MARIADB_VERSION=10.8.2
FROM mariadb:10.8.2

LABEL maintainer="Ilya Blagorodov <blagorodov@gmail.com>"

#####################################
# Set Timezone
#####################################

COPY my.cnf /etc/mysql/conf.d/my.cnf

RUN groupadd --gid 1000 user \
  && useradd --uid 1000 --gid user --create-home user

USER user

CMD ["mysqld"]

EXPOSE 3306
