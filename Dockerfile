FROM ubuntu:18.04
MAINTAINER keiichi@iijlab.net

RUN /usr/bin/apt-get update \
	&& /usr/bin/apt-get install -y python apache2 \
	&& /usr/bin/apt-get install -y git make gcc libpcap-dev

# enable mod_cgi
RUN /usr/sbin/a2enmod cgi

# build aguri3 and agurim
RUN /usr/bin/git clone -b file_parse-fix --single-branch https://github.com/keiichishima/agurim.git /agurim-master
WORKDIR /agurim-master/src
RUN /usr/bin/make && /usr/bin/make install

# copy web contents to /var/www/agurim
WORKDIR /agurim-master
RUN /bin/mkdir /var/www/agurim
RUN /bin/cp -r index.html detail.html about.html css img js fonts /var/www/agurim/
# copy cgi-bin script to /var/www/cgi-bin
RUN /bin/cp -r cgi-bin /var/www/cgi-bin

# copy some build scripts
COPY build-parts /build-parts
# fix index.html and myagurim.cgi to support environment variable based
# dataset configuration
RUN /build-parts/patch.sh
# copy httpd configuration file
RUN /bin/cp /build-parts/000-default.conf /etc/apache2/sites-enabled/000-default.conf

CMD ["/build-parts/entrypoint.sh"]
