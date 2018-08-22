FROM mariadb:10.3
MAINTAINER Min Ju Kang <blackdole@naver.com>

ENV GO_CRON_VERSION v0.0.7
ENV TZ Asia/Seoul

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L https://github.com/odise/go-cron/releases/download/${GO_CRON_VERSION}/go-cron-linux.gz \
        | zcat > /usr/local/bin/go-cron \
    && chmod u+x /usr/local/bin/go-cron

ADD ./backuptool /usr/local/bin/backuptool

ADD ./entrypoint.sh /entrypoint.sh

RUN chmod u+x /entrypoint.sh

EXPOSE 18080

VOLUME /data
VOLUME /var/lib/mysql

ENTRYPOINT ["/entrypoint.sh"]

CMD ["go-cron"]
