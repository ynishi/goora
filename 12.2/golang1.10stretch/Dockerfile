FROM golang:1.10.1-stretch

ENV ORA_VERSION 12.2
ENV ORA_VERSION_FULL ${ORA_VERSION}.0.1.0-1
ENV ORA_PREFIX oracle-instantclient${ORA_VERSION}
RUN mkdir /oracle
ADD package/${ORA_PREFIX}-basic-${ORA_VERSION_FULL}.x86_64.rpm /oracle/
ADD package/${ORA_PREFIX}-sqlplus-${ORA_VERSION_FULL}.x86_64.rpm /oracle/
ADD package/${ORA_PREFIX}-devel-${ORA_VERSION_FULL}.x86_64.rpm /oracle/

WORKDIR /oracle
RUN apt-get update && apt-get install -y \
    libaio1 \
    alien \
    prelink \
  && alien ${ORA_PREFIX}-basic-${ORA_VERSION_FULL}.x86_64.rpm \
  && alien ${ORA_PREFIX}-devel-${ORA_VERSION_FULL}.x86_64.rpm \
  && alien ${ORA_PREFIX}-sqlplus-${ORA_VERSION_FULL}.x86_64.rpm \
  && rm -f ${ORA_PREFIX}-basic-${ORA_VERSION_FULL}.x86_64.rpm \
  && rm -f ${ORA_PREFIX}-devel-${ORA_VERSION_FULL}.x86_64.rpm \
  && rm -f ${ORA_PREFIX}-sqlplus-${ORA_VERSION_FULL}.x86_64.rpm \
  && dpkg -i ${ORA_PREFIX}-basic_${ORA_VERSION}.0.1.0-2_amd64.deb \
  && dpkg -i ${ORA_PREFIX}-devel_${ORA_VERSION}.0.1.0-2_amd64.deb \
  && dpkg -i ${ORA_PREFIX}-sqlplus_${ORA_VERSION}.0.1.0-2_amd64.deb \
  && rm -f ${ORA_PREFIX}-basic_${ORA_VERSION}.0.1.0-2_amd64.deb \
  && rm -f ${ORA_PREFIX}-devel_${ORA_VERSION}.0.1.0-2_amd64.deb \
  && rm -f ${ORA_PREFIX}-sqlplus_${ORA_VERSION}.0.1.0-2_amd64.deb

ENV LD_LIBRARY_PATH /usr/lib/oracle/${ORA_VERSION}/client64/lib
ENV NLS_LANG Japanese_Japan.UTF8
ENV PATH $PATH:/usr/lib/oracle/${ORA_VERSION}/client64/bin

ADD oci8.pc /usr/lib/pkgconfig/
RUN go get github.com/mattn/go-oci8

WORKDIR /go
