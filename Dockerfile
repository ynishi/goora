FROM golang:1.10.1-stretch    

ENV ORA_VERSION 12.2 
ENV ORA_VERSION_FULL ${ORA_VERSION}.0.1.0-1
RUN mkdir /oracle
ADD package/oracle-instantclient${ORA_VERSION}-basic-${ORA_VERSION_FULL}.x86_64.rpm /oracle/ 
ADD package/oracle-instantclient${ORA_VERSION}-sqlplus-${ORA_VERSION_FULL}.x86_64.rpm /oracle/
ADD package/oracle-instantclient${ORA_VERSION}-devel-${ORA_VERSION_FULL}.x86_64.rpm /oracle/

WORKDIR /oracle
RUN apt-get update && \
  apt-get install libaio1 alien prelink -y && \
  alien oracle-instantclient${ORA_VERSION}-basic-${ORA_VERSION_FULL}.x86_64.rpm && \
  alien oracle-instantclient${ORA_VERSION}-devel-${ORA_VERSION_FULL}.x86_64.rpm && \ 
  alien oracle-instantclient${ORA_VERSION}-sqlplus-${ORA_VERSION_FULL}.x86_64.rpm && \
  rm -f oracle-instantclient${ORA_VERSION}-basic-${ORA_VERSION_FULL}.x86_64.rpm && \
  rm -f oracle-instantclient${ORA_VERSION}-devel-${ORA_VERSION_FULL}.x86_64.rpm && \ 
  rm -f oracle-instantclient${ORA_VERSION}-sqlplus-${ORA_VERSION_FULL}.x86_64.rpm && \
  dpkg -i oracle-instantclient${ORA_VERSION}-basic_${ORA_VERSION}.0.1.0-2_amd64.deb && \
  dpkg -i oracle-instantclient${ORA_VERSION}-devel_${ORA_VERSION}.0.1.0-2_amd64.deb && \
  dpkg -i oracle-instantclient${ORA_VERSION}-sqlplus_${ORA_VERSION}.0.1.0-2_amd64.deb && \
  rm -f oracle-instantclient${ORA_VERSION}-basic_${ORA_VERSION}.0.1.0-2_amd64.deb && \
  rm -f oracle-instantclient${ORA_VERSION}-devel_${ORA_VERSION}.0.1.0-2_amd64.deb && \
  rm -f oracle-instantclient${ORA_VERSION}-sqlplus_${ORA_VERSION}.0.1.0-2_amd64.deb

ENV LD_LIBRARY_PATH=/usr/lib/oracle/${ORA_VERSION}/client64/lib
ENV NLS_LANG=Japanese_Japan.UTF8
ENV PATH=$PATH:/usr/lib/oracle/${ORA_VERSION}/client64/bin

ADD oci8.pc /usr/lib/pkgconfig/
RUN go get github.com/mattn/go-oci8

WORKDIR /go
