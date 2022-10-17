FROM public.ecr.aws/lambda/provided:al2-x86_64 as binary

# Work in a temporary /bref dir to avoid any conflict/mixup with other /opt files
# /bref will eventually be moved to /opt
RUN mkdir /bref \
&&  mkdir /bref/bin \
&&  mkdir /bref/lib \
&&  mkdir -p /bref/bref/extensions

RUN yum install -y \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
        https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
        yum-utils \
        epel-release \
        curl

RUN yum-config-manager --enable remi-php81

RUN yum update -y && yum upgrade -y

RUN yum install -y php81-php

# These files are included on Amazon Linux 2

# RUN cp /lib64/librt.so.1 /bref/lib/librt.so.1
# RUN cp /lib64/libstdc++.so.6 /bref/lib/libstdc++.so.6
# RUN cp /lib64/libutil.so.1 /bref/lib/libutil.so.1
# RUN cp /lib64/libxml2.so.2 /bref/lib/libxml2.so.2
# RUN cp /lib64/libssl.so.10 /bref/lib/libssl.so.10
# RUN cp /lib64/libz.so.1 /bref/lib/libz.so.1
# RUN cp /lib64/libselinux.so.1 /bref/lib/libselinux.so.1
# RUN cp /lib64/libssh2.so.1 /bref/lib/libssh2.so.1
# RUN cp /lib64/libunistring.so.0 /bref/lib/libunistring.so.0
# RUN cp /lib64/libsasl2.so.3 /bref/lib/libsasl2.so.3
# RUN cp /lib64/libssl3.so /bref/lib/libssl3.so
# RUN cp /lib64/libsmime3.so /bref/lib/libsmime3.so

# PHP Binary
RUN cp /opt/remi/php81/root/usr/bin/php /bref/bin/php && chmod +x /bref/bin/php
RUN cp /lib64/libtinfo.so.5 /bref/lib/libtinfo.so.5
RUN cp /lib64/libedit.so.0 /bref/lib/libedit.so.0
RUN cp /lib64/libncurses.so.5 /bref/lib/libncurses.so.5
#RUN cp /lib64/libcrypt.so.1 /bref/lib/libcrypt.so.1
#RUN cp /lib64/libresolv.so.2 /bref/lib/libresolv.so.2
#RUN cp /lib64/libm.so.6 /bref/lib/libm.so.6
#RUN cp /lib64/libdl.so.2 /bref/lib/libdl.so.2
#RUN cp /lib64/libgssapi_krb5.so.2 /bref/lib/libgssapi_krb5.so.2
#RUN cp /lib64/libkrb5.so.3 /bref/lib/libkrb5.so.3
#RUN cp /lib64/libk5crypto.so.3 /bref/lib/libk5crypto.so.3
#RUN cp /lib64/libcom_err.so.2 /bref/lib/libcom_err.so.2
#RUN cp /lib64/libcrypto.so.10 /bref/lib/libcrypto.so.10
#RUN cp /lib64/libc.so.6 /bref/lib/libc.so.6
#RUN cp /lib64/libpthread.so.0 /bref/lib/libpthread.so.0
#RUN cp /lib64/ld-linux-x86-64.so.2 /bref/lib/ld-linux-x86-64.so.2
#RUN cp /lib64/libgcc_s.so.1 /bref/lib/libgcc_s.so.1
#RUN cp /lib64/liblzma.so.5 /bref/lib/liblzma.so.5
#RUN cp /lib64/libkrb5support.so.0 /bref/lib/libkrb5support.so.0
#RUN cp /lib64/libkeyutils.so.1 /bref/lib/libkeyutils.so.1
#RUN cp /lib64/libtinfo.so.6 /bref/lib/libtinfo.so.6
#RUN cp /lib64/libpcre.so.1 /bref/lib/libpcre.so.1

# Default Extensions
RUN cp /opt/remi/php81/root/lib64/php/modules/ctype.so /bref/bref/extensions/ctype.so
RUN cp /opt/remi/php81/root/lib64/php/modules/exif.so /bref/bref/extensions/exif.so
RUN cp /opt/remi/php81/root/lib64/php/modules/fileinfo.so /bref/bref/extensions/fileinfo.so
RUN cp /opt/remi/php81/root/lib64/php/modules/ftp.so /bref/bref/extensions/ftp.so
RUN cp /opt/remi/php81/root/lib64/php/modules/gettext.so /bref/bref/extensions/gettext.so
RUN cp /opt/remi/php81/root/lib64/php/modules/iconv.so /bref/bref/extensions/iconv.so
RUN cp /opt/remi/php81/root/lib64/php/modules/sockets.so /bref/bref/extensions/sockets.so
RUN cp /opt/remi/php81/root/lib64/php/modules/tokenizer.so /bref/bref/extensions/tokenizer.so

# cURL
RUN cp /opt/remi/php81/root/lib64/php/modules/curl.so /bref/bref/extensions/curl.so
#RUN cp /lib64/libcurl.so.4 /bref/lib/libcurl.so.4
#RUN cp /lib64/libnghttp2.so.14 /bref/lib/libnghttp2.so.14
#RUN cp /lib64/libidn2.so.0 /bref/lib/libidn2.so.0
#RUN cp /lib64/libldap-2.4.so.2 /bref/lib/libldap-2.4.so.2
#RUN cp /lib64/liblber-2.4.so.2 /bref/lib/liblber-2.4.so.2
#RUN cp /lib64/libnss3.so /bref/lib/libnss3.so
#RUN cp /lib64/libnssutil3.so /bref/lib/libnssutil3.so
#RUN cp /lib64/libplds4.so /bref/lib/libplds4.so
#RUN cp /lib64/libplc4.so /bref/lib/libplc4.so
#RUN cp /lib64/libnspr4.so /bref/lib/libnspr4.so

# sodium
RUN cp /opt/remi/php81/root/lib64/php/modules/sodium.so /bref/bref/extensions/sodium.so
RUN cp /usr/lib64/libsodium.so.23 /bref/lib/libsodium.so.23

FROM binary as extensions

RUN yum install -y \
    php81-php-mbstring \
    php81-php-bcmath \
    php81-php-dom \
    php81-php-mysqli \
    php81-php-mysqlnd \
    php81-php-opcache \
    php81-php-pdo \
    php81-php-pdo_mysql \
    php81-php-phar \
    php81-php-posix \
    php81-php-simplexml \
    php81-php-soap \
    php81-php-xml \
    php81-php-xmlreader \
    php81-php-xmlwriter \
    php81-php-xsl \
    php81-php-intl \
    php81-php-apcu \
    php81-php-pdo_pgsql

RUN cp /opt/remi/php81/root/lib64/php/modules/mbstring.so /bref/bref/extensions/mbstring.so
RUN cp /usr/lib64/libonig.so.105 /bref/lib/libonig.so.105

# mysqli depends on mysqlnd
RUN cp /opt/remi/php81/root/lib64/php/modules/mysqli.so /bref/bref/extensions/mysqli.so
RUN cp /opt/remi/php81/root/lib64/php/modules/mysqlnd.so /bref/bref/extensions/mysqlnd.so

#RUN cp /usr/lib64/libsqlite3.so.0 /bref/lib/libsqlite3.so.0
RUN cp /opt/remi/php81/root/lib64/php/modules/sqlite3.so /bref/bref/extensions/sqlite3.so

RUN cp /usr/lib64/libgpg-error.so.0 /bref/lib/libgpg-error.so.0
RUN cp /usr/lib64/libgcrypt.so.11 /bref/lib/libgcrypt.so.11
RUN cp /usr/lib64/libexslt.so.0 /bref/lib/libexslt.so.0
RUN cp /usr/lib64/libxslt.so.1 /bref/lib/libxslt.so.1
RUN cp /opt/remi/php81/root/lib64/php/modules/xsl.so /bref/bref/extensions/xsl.so

RUN cp /usr/lib64/libicuio.so.71 /bref/lib/libicuio.so.71
RUN cp /usr/lib64/libicui18n.so.71 /bref/lib/libicui18n.so.71
RUN cp /usr/lib64/libicuuc.so.71 /bref/lib/libicuuc.so.71
RUN cp /usr/lib64/libicudata.so.71 /bref/lib/libicudata.so.71
RUN cp /opt/remi/php81/root/lib64/php/modules/intl.so /bref/bref/extensions/intl.so

RUN cp /opt/remi/php81/root/lib64/php/modules/apcu.so /bref/bref/extensions/apcu.so

RUN cp /usr/lib64/libpq.so.5 /bref/lib/libpq.so.5
#RUN cp /usr/lib64/libldap_r-2.4.so.2 /bref/lib/libldap_r-2.4.so.2
RUN cp /opt/remi/php81/root/lib64/php/modules/pdo_pgsql.so /bref/bref/extensions/pdo_pgsql.so

RUN cp /opt/remi/php81/root/lib64/php/modules/bcmath.so /bref/bref/extensions/bcmath.so
RUN cp /opt/remi/php81/root/lib64/php/modules/dom.so /bref/bref/extensions/dom.so
RUN cp /opt/remi/php81/root/lib64/php/modules/opcache.so /bref/bref/extensions/opcache.so
RUN cp /opt/remi/php81/root/lib64/php/modules/pdo.so /bref/bref/extensions/pdo.so
RUN cp /opt/remi/php81/root/lib64/php/modules/pdo_mysql.so /bref/bref/extensions/pdo_mysql.so
RUN cp /opt/remi/php81/root/lib64/php/modules/pdo_sqlite.so /bref/bref/extensions/pdo_sqlite.so
RUN cp /opt/remi/php81/root/lib64/php/modules/phar.so /bref/bref/extensions/phar.so
RUN cp /opt/remi/php81/root/lib64/php/modules/posix.so /bref/bref/extensions/posix.so
RUN cp /opt/remi/php81/root/lib64/php/modules/simplexml.so /bref/bref/extensions/simplexml.so
RUN cp /opt/remi/php81/root/lib64/php/modules/soap.so /bref/bref/extensions/soap.so
RUN cp /opt/remi/php81/root/lib64/php/modules/xml.so /bref/bref/extensions/xml.so
RUN cp /opt/remi/php81/root/lib64/php/modules/xmlreader.so /bref/bref/extensions/xmlreader.so
RUN cp /opt/remi/php81/root/lib64/php/modules/xmlwriter.so /bref/bref/extensions/xmlwriter.so

FROM public.ecr.aws/lambda/provided:al2-x86_64 as isolation

COPY --from=extensions /bref /opt

FROM isolation as function

COPY layers/function/bref.ini /opt/bref/etc/php/conf.d/
COPY layers/function/bref-extensions.ini /opt/bref/etc/php/conf.d/

COPY layers/function/bootstrap.sh /opt/bootstrap
# Copy files to /var/runtime to support deploying as a Docker image
COPY layers/function/bootstrap.sh /var/runtime/bootstrap
RUN chmod +x /opt/bootstrap && chmod +x /var/runtime/bootstrap

COPY layers/function/bootstrap.php /opt/bref/bootstrap.php

FROM alpine:3.14 as zip-function

RUN apk add zip

COPY --from=function /opt /opt

WORKDIR /opt

RUN zip --quiet --recurse-paths /tmp/layer.zip .

# Up until here the entire file has been designed as a top-down reading/execution.
# Everything necessary for the `function` layer has been installed, isolated and
# packaged. Now we'll go back one step and start from the extensions so that we
# can install fpm. Then we'll start the fpm layer and quickly isolate fpm.

FROM extensions as fpm-extension

RUN yum install -y php81-php-fpm

FROM isolation as fpm

COPY --from=fpm-extension /opt/remi/php81/root/sbin/php-fpm /opt/bin/php-fpm

COPY --from=fpm-extension /usr/lib64/libsystemd.so.0 /opt/lib/libsystemd.so.0
COPY --from=fpm-extension /usr/lib64/liblz4.so.1 /opt/lib/liblz4.so.1
COPY --from=fpm-extension /usr/lib64/libgcrypt.so.11 /opt/lib/libgcrypt.so.11
COPY --from=fpm-extension /usr/lib64/libgpg-error.so.0 /opt/lib/libgpg-error.so.0
COPY --from=fpm-extension /usr/lib64/libdw.so.1 /opt/lib/libdw.so.1
#COPY --from=fpm-extension /usr/lib64/libacl.so.1 /opt/lib/libacl.so.1
#COPY --from=fpm-extension /usr/lib64/libattr.so.1 /opt/lib/libattr.so.1
#COPY --from=fpm-extension /usr/lib64/libcap.so.2 /opt/lib/libcap.so.2
#COPY --from=fpm-extension /usr/lib64/libelf.so.1 /opt/lib/libelf.so.1
#COPY --from=fpm-extension /usr/lib64/libbz2.so.1 /opt/lib/libbz2.so.1

COPY layers/fpm/bref.ini /opt/bref/etc/php/conf.d/
COPY layers/fpm/bref-extensions.ini /opt/bref/etc/php/conf.d/

COPY layers/fpm/bootstrap.sh /opt/bootstrap
# Copy files to /var/runtime to support deploying as a Docker image
COPY layers/fpm/bootstrap.sh /var/runtime/bootstrap
RUN chmod +x /opt/bootstrap && chmod +x /var/runtime/bootstrap

COPY layers/fpm/php-fpm.conf /opt/bref/etc/php-fpm.conf

COPY --from=bref/fpm-internal-src /opt/php-fpm-runtime /opt/php-fpm-runtime

FROM alpine:3.14 as zip-fpm

RUN apk add zip

COPY --from=fpm /opt /opt

WORKDIR /opt

RUN zip --quiet --recurse-paths /tmp/layer.zip .
