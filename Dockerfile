FROM openresty/openresty:1.9.7.4-centos

RUN yum install -y unzip

ADD . /install/

RUN mkdir -p /usr/local/openresty/nginx/conf/conf.d/ &&\
    cp /install/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

RUN /install/install-consul.sh

COPY ./supervisor/ /etc/supervisor/
RUN /install/install-supervisor.sh

ENTRYPOINT ["/usr/bin/supervisord", \
     "-c", \
     "/etc/supervisor/supervisor.conf", \
     "--nodaemon"]
