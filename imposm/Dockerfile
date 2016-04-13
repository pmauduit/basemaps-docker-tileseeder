FROM debian

RUN apt-get update && apt-get -y install python-pip axel  \
  libpq-dev libgeos-c1 python-protobuf libprotobuf-dev    \
  protobuf-compiler python-dev libtokyocabinet-dev netcat \
  postgresql-client  libgeos-dev && pip install imposm

ADD ./imposm-mapping.py /
ADD ./bootstrap.sh /

CMD /bootstrap.sh
