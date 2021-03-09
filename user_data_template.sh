#!/bin/bash -vx
# 
# this is a terraform template file.
# all ${var_name} occurences will be replaced during TF apply.
# see the TF files for their values.

# install nginx if not already
if [ $(which nginx) ] ; then
	echo "NGINX already installed";
else
	echo "configuring apt to install nginx and its plugins..."
	apt-get update
	apt-get -yq install curl gnupg2 ca-certificates lsb-release
	echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list
	curl -o /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key
	mv /tmp/nginx_signing.key /etc/apt/trusted.gpg.d/nginx_signing.asc

	echo "installing nginx and plugins..."
	apt-get update
	apt-get -yq install nginx nginx-module-njs
fi

# create conf directory and add config file
mkdir -p  /usr/local/etc/nginx
cat <<NGINCONF > /usr/local/etc/nginx/nginx.conf
load_module modules/ngx_http_js_module.so;

events {}

http {
	js_import http.js;

	server {
		listen 8000;

		location / {
			js_content http.hello;
		}
	}
}
NGINCONF

# add the JS file to the conf directory
cat <<JSFILE > /usr/local/etc/nginx/http.js
'use strict'

function hello(r) {
	r.return(200,'Hello, world!')
}

export default { hello }
JSFILE

# TODO start the service if not already
# TODO register the service to run on start

