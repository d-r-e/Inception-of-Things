#!/bin/bash

set -eu

# This script is run on the server node for the alpine vagrant machine

apk add --update --no-cache curl

if [ -z "$(which k3s)" ]; then
    echo "Installing k3s..."
    curl -sfL https://get.k3s.io | sh -
    echo -e [+] "\e[32mK3s installed successfully!\e[0m"
else
    echo -e [+] "\e[32mK3s already installed.\e[0m"
fi

