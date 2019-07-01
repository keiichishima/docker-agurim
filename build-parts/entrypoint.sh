#!/bin/sh

DEFAULT_DATASET_NAME=${DEFAULT_DATASET_NAME:=dataset}
DS_NAMES=${DATASET_NAMES:="dataset"}
NDS_NAMES=`/bin/echo ${DS_NAMES} | /usr/bin/wc -w`

DS_NAMES_TMP=
set -f
for dsn in ${DS_NAMES}
do
	DS_NAMES_TMP="\"${dsn}\" ${DS_NAMES_TMP}"
done
set +f
DATASET_NAMES=`/bin/echo ${DS_NAMES_TMP} | /bin/sed -e "s/ /,/"`

/bin/cat /var/www/agurim/index.html | /bin/sed -e "s/DATASET_NAMES/${DATASET_NAMES}/" > /tmp/index.html
/bin/mv /tmp/index.html /var/www/agurim/index.html
/bin/cat /var/www/cgi-bin/myagurim.cgi | /bin/sed -e "s/DEFAULT_DATASET_NAME/${DEFAULT_DATASET_NAME}/" > /tmp/myagurim.cgi
/bin/mv /tmp/myagurim.cgi /var/www/cgi-bin/myagurim.cgi
/bin/chmod +x /var/www/cgi-bin/myagurim.cgi

/usr/sbin/apache2ctl -DFOREGROUND
