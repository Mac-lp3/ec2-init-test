#!/bin/bash -vx
# 
# this is a terraform template file.
# all var_name occurences will be replaced during TF apply.
# see the TF files for their values.

APP_NAME=ec2app
LISTEN_PORT=${listen_port}
echo "value of listen port: $LISTEN_PORT, ${listen_port}"

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

# replace default nginx config
cp /etc/nginx/nginx.conf /etc/nginx/nginx_original.conf
cat <<NGINCONF > /etc/nginx/nginx.conf
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
cat <<JSFILE > /etc/nginx/http.js
'use strict'

function hello(r) {
	r.return(200,'Hello, world!')
}

export default { hello }
JSFILE

# run the service on start up
chmod +x /etc/init.d/nginx
update-rc.d nginx enable 

# start the service
/etc/init.d/nginx start

