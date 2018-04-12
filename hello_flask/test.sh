#!/usr/bin/env bash
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

app=hello_flask
key="${hello_flask}_ip"

chain="Hello, World!"

app_ip=$(terraform output | grep $key | awk '{print $3}')

test=$(curl -s http://${app_ip})

if [  "$test" == "$chain" ]; then
printf " ${GREEN}\u2611 Ok${NORMAL}\n"
else
printf " ${RED}\u2610 Nok${NORMAL}\n"
fi