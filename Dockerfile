FROM golang:1.10.1-stretch    

RUN mkdir /oracle
ADD package/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /oracle/ 
ADD package/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm /oracle/
ADD package/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /oracle/

WORKDIR /oracle
RUN apt-get update && \
  apt-get install libaio1 alien prelink -y && \
  alien oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
  alien oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm && \ 
  alien oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm && \
  rm -f oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
  rm -f oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm && \ 
  rm -f oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm && \
  dpkg -i oracle-instantclient12.2-basic_12.2.0.1.0-2_amd64.deb && \
  dpkg -i oracle-instantclient12.2-devel_12.2.0.1.0-2_amd64.deb && \
  dpkg -i oracle-instantclient12.2-sqlplus_12.2.0.1.0-2_amd64.deb && \
  rm -f oracle-instantclient12.2-basic_12.2.0.1.0-2_amd64.deb && \
  rm -f oracle-instantclient12.2-devel_12.2.0.1.0-2_amd64.deb && \
  rm -f oracle-instantclient12.2-sqlplus_12.2.0.1.0-2_amd64.deb

ENV LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib
ENV NLS_LANG=Japanese_Japan.UTF8
ENV PATH=$PATH:/usr/lib/oracle/12.2/client64/bin

RUN echo $LD_LIBRARY_PATH
ADD oci8.pc /usr/lib/pkgconfig/
RUN go get github.com/mattn/go-oci8

WORKDIR /go
