#!/bin/bash

echo "Build docker image:"
ssh docker-vm docker -H :4567 build -t tcnksm/sample /vagrant/.
echo

echo "Run rspec test:"
bundle exec rspec
