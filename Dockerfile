From ubuntu:15.04

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install build-essential \
                       autotools-dev \
                       glibc-source \
                       autoconf \
                       intltool \
                       libtool-bin \
                       libglib2.0-dev \
                       automake \
                       git \
                       gee-0.8 \
                       libxml2-dev \
                       libgirepository1.0-dev \
                       valac \
                       devscripts \
                       debhelper

WORKDIR /
RUN git clone https://github.com/GNOME/gxml.git --branch gxml-0-6 --single-branch /gxml-0.6/ \
    && mkdir -p /gxml-0.6/debian/source
WORKDIR /gxml-0.6/
RUN ./autogen.sh --prefix=/usr --enable-introspection=yes
RUN sed -i -e 's/@YELP_HELP_RULES@/\t@YELP_HELP_RULES@/g' docs/mallard/Makefile*
RUN tar cfvz /gxml_0.6.orig.tar.gz /gxml-0.6/
ADD ./debian/ /gxml-0.6/debian/
RUN debuild -us -uc
CMD cp /gxml_0.6* /build/build/
