FROM debian:jessie

RUN apt-get update && apt-get install -y apache2 cgi-mapserver
COPY map /map

RUN a2enmod cgid

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
