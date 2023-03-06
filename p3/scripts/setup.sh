#!/bin/bash
set -e

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

k3d cluster create mycluster