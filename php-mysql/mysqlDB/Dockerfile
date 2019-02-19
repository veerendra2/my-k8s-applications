FROM mysql:5.7
MAINTAINER Veerendra Kakumanu
COPY / /docker-entrypoint-initdb.d/
RUN chmod -R o+rw /docker-entrypoint-initdb.d
