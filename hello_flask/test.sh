#!/usr/bin/env bash

app=hello_flask
key="${hello_flask}_ip"

chain="Hello, World!"

app_ip=$(terraform output | grep $key | awk '{print $3}')

test=$(curl -s http://${app_ip})

if [  "$test" == "$chain" ]; then
echo "Ok"
else
echo "Nok"
fi