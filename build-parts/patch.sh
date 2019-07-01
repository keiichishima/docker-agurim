#!/bin/sh

/bin/cp /build-parts/000-default.conf /etc/apache2/sites-enabled/000-default.conf

/bin/cat /agurim-master/cgi-bin/myagurim.cgi \
	| /bin/sed -e "s:data_dir = \"../\":data_dir = \"../datasets/\":" \
	| /bin/sed -e "s/def_dsname = \"dataset\"/def_dsname = \"DEFAULT_DATASET_NAME\"/" \
	| /bin/sed -e "s:^#!/usr/local/bin/python:#!/usr/bin/python:" \
	> /var/www/cgi-bin/myagurim.cgi
/bin/chmod +x /var/www/cgi-bin/myagurim.cgi

/bin/cat /agurim-master/index.html \
	| /bin/sed -e "s/var ourDatasets = \[\];/var ourDatasets = \[DATASET_NAMES\];/" \
	> /var/www/agurim/index.html
