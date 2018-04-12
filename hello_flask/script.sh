#!/bin/bash

function set_nginx () {
# Configure Nginx proxy pass
nginx_conf=/etc/nginx/sites-available/hello

cat>>$nginx_conf<<NGINX_EOF
server {
    listen 80;
    server_name hello;
    location / {
        proxy_pass         http://127.0.0.1:5000/;
    }
}
NGINX_EOF
rm /etc/nginx/sites-enabled/default
ln -s $nginx_conf /etc/nginx/sites-enabled
}

function set_hello () {
# Configure Flask App
flask_dir=/opt/flask
flask_app=hello.py

export LC_ALL=C
pip install --upgrade pip
pip install Flask

mkdir $flask_dir
cd $flask_dir
cat>>$flask_app<<EOF
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'
EOF

export FLASK_APP=$flask_app
nohup python -m flask run 2>/dev/null &
}

set_hello
set_nginx

# Restart nginx
/etc/init.d/nginx restart


