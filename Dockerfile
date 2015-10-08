FROM debian:latest
MAINTAINER JJ Asghar <jjasghar@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV PDNS_RCURSOR_VERSION 3.7.3-1
ENV DATA_DIR /conf

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
	&& apt-get update \
	&& apt-get install -y wget unzip python-virtualenv \
	&& pushd /tmp \
	&& wget http://downloads.sourceforge.net/project/supybot/supybot/Supybot-0.83.4.1/Supybot-0.83.4.1.zip \
	&& wget http://code.zgib.net/MeetBot/MeetBot-current.tar.gz \
	&& unzip Supybot-0.83.4.1.zip \
	&& tar xvzf MeetBot-current.tar.gz \
	&& mv MeetBot-current/ircmeeting MeetBot-current/MeetBot/ \
	&& pushd \
	&& mkdir ircbot && cd ircbot \
	&& mkdir -p /root/ircbot/logs \
	&& virtualenv ircbot \
	&& source ircbot/bin/activate \
	&& which python pip \
	&& pushd /tmp/Supybot-0.83.4.1/ \
	&& python setup.py install \
	&& popd \
	&& mv /tmp/MeetBot-current/MeetBot ./ircbot/lib/python2.7/site-packages/supybot/plugins/MeetBot \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE     80/tcp
VOLUME  ["${DATA_DIR}"]
CMD [ "/ircbot/ircbot/bin/supybot","/conf/meetbot.conf","--allow-root" ]
