#!/bin/bash

echo "Build docker image:"
ssh docker-vm "cd /vagrant; docker build -t serverspec ."
echo

echo "Run container:"
ssh docker-vm docker run -p 7654:22 -d serverspec /usr/sbin/sshd -D
echo

echo "Run rspec test:"
bundle exec rspec
echo

echo "Delete container:"
ssh docker-vm "docker stop `ssh docker-vm docker ps -l -q`"
ssh docker-vm "docker rm `ssh docker-vm docker ps -l -q`"
