#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo apt-get install build-essential libssl-dev -y
wget https://www.keepalived.org/software/keepalived-2.0.19.tar.gz
tar xzvf keepalived*
rm -rf keepalived*.tar.gz
cd keepalived*
./configure
make
sudo make install
keepalived -v
