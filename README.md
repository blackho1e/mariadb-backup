# blackho1e/mariadb-backup
[![Docker Size](https://img.shields.io/badge/docker%20size-373%20MB-blue.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/blackho1e/mariadb-backup/)
[![Docker Pulls](https://img.shields.io/docker/pulls/blackho1e/mariadb-backup.svg)](https://hub.docker.com/r/blackho1e/mariadb-backup/)
[![Docker Stars](https://img.shields.io/docker/stars/blackho1e/mariadb-backup.svg)](https://hub.docker.com/r/blackho1e/mariadb-backup/)


MariaDB 백업을 위한 Docker Image

## Usage
```
# mariadb를 1시간마다 백업하는 예
# 마지막 백업 시간은 18080 포트로 확인 가능하다.
$ docker run --link mariadb:mysql --name mariadb-backup \
    -v /backup:/data \
    -v /var/lib/mysql:/var/lib/mysql \
    -e TIMEZONE="Asia/Seoul" \
    -e SCHEDULE="* 1 * * *" \
    -d -p 18080:18080 blackho1e/mariadb-backup
```
