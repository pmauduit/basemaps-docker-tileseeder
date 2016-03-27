FROM debian:jessie

RUN apt-get update && apt-get install -y apache2 cgi-mapserver
COPY map /map

ADD 000-default.conf /etc/apache2/sites-available/
RUN a2enmod cgid

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
