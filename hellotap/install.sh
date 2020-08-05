#!/usr/bin/env bash
echo "#############################################"
echo "#                                           #"
echo "#            hello world !                  #"
echo "#                                           #"
echo "#############################################"

echo "hello world" > /tmp/hello_world
cat /tmp/hello_world
if [ -f /usr/bin/say and -f /tmp/hello_world ];then
    say "hello world ! welcome to the brew tap installer example by Dev Ops"
fi