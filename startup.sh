#!/bin/bash

export TERM=xterm

if [ -z "`ls /vesta --hide='lost+found'`" ] 
then
	rsync -a /vesta-start/* /vesta
fi

chown root:root /var/run/sshd
service ssh start
#starting Vesta
cd /etc/init.d/ \
&& ./vesta start \
&& ./mysql start \
&& ./nginx start \
&& ./exim4 start \
&& ./php7.0-fpm start \
&& ./dovecot start
