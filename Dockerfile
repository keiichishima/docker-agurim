FROM ubuntu:18.04
MAINTAINER keiichi@iijlab.net

RUN /usr/bin/apt-get update \
	&& /usr/bin/apt-get install -y python apache2 \
	&& /usr/bin/apt-get install -y git make gcc libpcap-dev

# copy some build scripts
COPY build-parts /build-parts

# enable mod_cgi
RUN /usr/sbin/a2enmod cgi
# copy httpd configuration file
RUN /bin/cp /build-parts/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# build aguri3 and agurim
RUN /usr/bin/git clone https://github.com/necoma/agurim.git /agurim-master
WORKDIR /agurim-master/src
RUN /usr/bin/make && /usr/bin/make install

# fix index.html and myagurim.cgi to support environment variable based
# dataset configuration
WORKDIR /agurim-master
RUN /usr/bin/patch -p1 < /build-parts/agurim.patch
#RUN /usr/bin/patch -p1 < /build-parts/agurim_day_offset.patch

# copy web contents and cgi scrips
RUN /bin/mkdir /var/www/agurim
WORKDIR /agurim-master
RUN /bin/cp -r index.html detail.html about.html css img js fonts /var/www/agurim/
RUN /bin/cp -r cgi-bin /var/www/cgi-bin

CMD ["/build-parts/entrypoint.sh"]
