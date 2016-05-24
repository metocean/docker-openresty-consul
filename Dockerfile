FROM openresty/openresty:1.9.7.4-centos

RUN yum install -y unzip

COPY . /tmp/

RUN mkdir -p /usr/local/openresty/nginx/conf/conf.d/ &&\
    cp /tmp/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

RUN /tmp/install-consul.sh

COPY ./supervisor/ /etc/supervisor/
RUN /tmp/install-supervisor.sh

RUN rm -rf /tmp/*

ENTRYPOINT ["/usr/bin/supervisord", \
     "-c", \
     "/etc/supervisor/supervisor.conf", \
     "--nodaemon"]
