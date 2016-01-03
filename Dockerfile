FROM phusion/baseimage:

MAINTAINER ivan@lagunovsky.com

RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install git unzip nano

ADD install-ubuntu.sh /install-ubuntu.sh
RUN chmod +x /install-ubuntu.sh

RUN bash /install-ubuntu.sh \
 --nginx yes --apache yes --phpfpm no \
 --vsftpd no --proftpd no \
 --exim yes --dovecot yes --spamassassin yes --clamav yes \
 --named yes \
 --iptables no --fail2ban no \
 --mysql yes --postgresql no \
 --remi yes \
 --quota no \
 --password admin \
 -y no -f

ADD dovecot /etc/init.d/dovecot
RUN chmod +x /etc/init.d/dovecot

RUN cd /usr/local/vesta/data/ips && mv * 127.0.0.1 \
    && cd /etc/apache2/conf.d && sed -i -- 's/172.*.*.*:80/127.0.0.1:80/g' * && sed -i -- 's/172.*.*.*:8443/127.0.0.1:8443/g' * \
    && cd /etc/nginx/conf.d && sed -i -- 's/172.*.*.*:80 default;/80 default;/g' * && sed -i -- 's/172.*.*.*:8080/127.0.0.1:8080/g' *

RUN mkdir /vesta \
    && mv /home /vesta/home \
    && rm -rf /home \
    && ln -s /vesta/home /home \
    && mv /etc/apache2 /vesta/apache2 \
    && rm -rf /etc/apache2 \
    && ln -s /vesta/apache2 /etc/apache2 \
    && mv /etc/php5   /vesta/php5 \
    && rm -rf /etc/php5 \
    && ln -s /vesta/php5 /etc/php5 \
    && mv /etc/nginx   /vesta/nginx \
    && rm -rf /etc/nginx \
    && ln -s /vesta/nginx /etc/nginx \
    && mv /etc/bind    /vesta/bind \
    && rm -rf /etc/bind \
    && ln -s /vesta/bind /etc/bind \
    && mv /etc/exim4   /vesta/exim4 \
    && rm -rf /etc/exim4 \
    && ln -s /vesta/exim4 /etc/exim4 \
    && mv /etc/dovecot /vesta/dovecot \
    && rm -rf /etc/dovecot \
    && ln -s /vesta/dovecot /etc/dovecot \
    && mv /etc/clamav  /vesta/clamav \
    && rm -rf /etc/clamav \
    && ln -s /vesta/clamav /etc/clamav \
    && mv /etc/spamassassin    /vesta/spamassassin \
    && rm -rf /etc/spamassassin \
    && ln -s /vesta/spamassassin /etc/spamassassin \
    && mv /etc/roundcube   /vesta/roundcube \
    && rm -rf /etc/roundcube \
    && ln -s /vesta/roundcube /etc/roundcube \
    && mv /etc/mysql   /vesta/mysql \
    && rm -rf /etc/mysql \
    && ln -s /vesta/mysql /etc/mysql \
    && mv /root    /vesta/root \
    && rm -rf /root \
    && ln -s /vesta/root /root \
    && mv /usr/local/vesta /vesta/vesta \
    && rm -rf /usr/local/vesta \
    && ln -s /vesta/vesta /usr/local/vesta \
    && mv /etc/phpmyadmin  /vesta/phpmyadmin \
    && rm -rf /etc/phpmyadmin \
    && ln -s /vesta/phpmyadmin /etc/phpmyadmin \
    && mv /var/log /vesta/log \
    && rm -rf /var/log \
    && ln -s /vesta/log /var/log

VOLUME /vesta

RUN mkdir -p /etc/my_init.d
ADD startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

EXPOSE 22 80 8083 3306 443 25 993 110 53 54