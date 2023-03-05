#!/bin/sh

set -e

sudo echo "127.0.0.1" app1.com >> /etc/hosts
sudo echo "127.0.0.1" app2.com >> /etc/hosts
sudo echo "127.0.0.1" app3.com >> /etc/hosts
echo -e [+] "Hosts file updated successfully."