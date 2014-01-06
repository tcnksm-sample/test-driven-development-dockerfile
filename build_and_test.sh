#!/bin/bash

echo "Build docker image:"
ssh docker-vm "cd /vagrant; docker -H :5422 build -t tcnksm/sample ."
echo

echo "Run container:"
ssh docker-vm docker -H :5422 run -p 7654:22 -d tcnksm/sample /usr/sbin/sshd -D
echo

echo "Run rspec test:"
bundle exec rspec
echo

echo "Delete container:"
ssh docker-vm "docker -H :5422 stop `ssh docker-vm docker -H :5422 ps -l -q`"
ssh docker-vm "docker -H :5422 rm `ssh docker-vm docker -H :5422 ps -l -q`"
