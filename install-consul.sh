#!/bin/sh
set -e

cd /tmp

CONSUL_VERSION=0.6.4

echo '----- Installing Consul $CONSUL_VERSION -----'
cd /tmp
curl -o consul.zip -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
unzip consul.zip
chmod +x consul
mv consul /usr/bin
mkdir /consul

echo '----- Installing Consul UI $CONSUL_VERSION -----'
cd /tmp
curl -o ui.zip -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip
unzip ui.zip  &&\
mv static /consul-ui
