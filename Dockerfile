# Produce & Publish Server (pypi.python.org/pypi/pp.server)
# with pre-installed PDFreactor demo version

FROM dockerfile/java:oracle-java7

MAINTAINER Andreas Jung <info@zopyx.com>

RUN apt-get update
RUN apt-get install -y \
    python-virtualenv \
    python \
    curl \
    build-essential \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libbz2-dev \
    zlib1g-dev \
    python-setuptools \
    python-dev \
    libjpeg62-dev \
    libreadline-gplv2-dev \
    python-imaging \
    python-dev \
    libxml2-dev \
    libxslt1-dev \
    wget 

RUN wget -O p.tgz "http://www.pdfreactor.com/download/get/?product=pdfreactor&type=unix&jre=false"
RUN tar xfvz p.tgz
RUN export PATH=$PATH:$PWD/PDFreactor
RUN virtualenv .
RUN bin/pip install pp.server
ADD development.ini  /tmp/development.ini
EXPOSE 6543
CMD PATH=$PATH:$PWD/PDFreactor/bin; echo $PATH; bin/pserve /tmp/development.ini
