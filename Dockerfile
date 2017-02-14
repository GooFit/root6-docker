FROM centos:latest
MAINTAINER Henry Scheiner <henry.schreiner@uc.edu>

# Updated base dist 2017-02-14

RUN yum -y install epel-release
RUN yum -y install bzip2 vim libpng libjpeg python-pip python-numpy python-pandas python-jupyter \
git cmake3 gcc-c++ gcc binutils make ninja-build \
libX11-devel libXpm-devel libXft-devel libXext-devel \
gcc-gfortran openssl-devel pcre-devel \
mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel \
fftw-devel cfitsio-devel graphviz-devel \
avahi-compat-libdns_sd-devel libldap-dev python-devel \
libxml2-devel gsl-static && yum -y clean all

RUN pip install --upgrade pip

ARG version="6.08.04"
LABEL description="CERN ROOT framework - development"
LABEL version="${version}"

ENV ROOTSYS         "/opt/root"
ENV PATH            "$ROOTSYS/bin:$PATH"
ENV LD_LIBRARY_PATH "$ROOTSYS/lib:$LD_LIBRARY_PATH"
ENV PYTHONPATH      "$ROOTSYS/lib:PYTHONPATH"

ADD https://root.cern.ch/download/root_v${version}.Linux-centos7-x86_64-gcc4.8.tar.gz /var/tmp/root.tar.gz
RUN tar xzf /var/tmp/root.tar.gz -C /opt && rm /var/tmp/root.tar.gz

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

RUN pip install rootpy
