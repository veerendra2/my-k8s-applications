FROM httpd:2.4.38-alpine
MAINTAINER Veerendra Kakumanu
RUN apk --update --no-cache add build-base python-dev py-pip \
            && pip install flask
ADD https://github.com/GrahamDumpleton/mod_wsgi/archive/4.6.5.tar.gz 4.6.5.tar.gz
RUN tar -xf 4.6.5.tar.gz \
    && cd mod_wsgi-4.6.5 \
	&& ./configure \
	&& make install \
	&& rm -rf /mod_wsgi-4.6.5 \
	&& rm -rf 4.6.5.tar.gz \
    && rm -rf /var/cache/apk/* \
    && apk del py-pip build-base
COPY /myapp /usr/local/apache2/htdocs/myapp
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
