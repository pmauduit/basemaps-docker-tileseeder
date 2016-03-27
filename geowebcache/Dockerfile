FROM jetty:9.2-jre8

ADD geowebcache.war /var/lib/jetty/webapps
RUN apt-get update && apt-get install -y unzip && \
  unzip /var/lib/jetty/webapps/geowebcache.war -d /var/lib/jetty/webapps/geowebcache && \
  rm -f /var/lib/jetty/webapps/geowebcache.war

ADD geowebcache.xml /var/lib/jetty/webapps/geowebcache/WEB-INF/classes

ADD docker-entrypoint.sh  /
ADD docker-entrypoint.d/  /docker-entrypoint.d

VOLUME [ "/tmp/defaultCache" ]

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "java","-Djava.io.tmpdir=/tmp/jetty", "-jar","/usr/local/jetty/start.jar" ]
