#!/bin/bash

#!/bin/bash

set -ex
S_IP=$1
TOKEN=$2

# Install required packages
sudo apt-get update && sudo apt-get install -y curl

if [ -z "$(which k3s)" ]; then
    echo "Installing k3s agent..."
    curl -sfL https://get.k3s.io | K3S_URL="https://${S_IP}:6443" K3S_TOKEN="${TOKEN}" sh -
    sudo systemctl status k3s-agent >/dev/null 2>&1 && echo -e [+] "\e[32mK3s agent started successfully!\e[0m" || echo -e [+] "\e[31mK3s agent failed to start!\e[0m"
    echo -e [+] "\e[32mK3s agent installed successfully!\e[0m"
else
    echo -e [+] "\e[32mK3s agent already installed.\e[0m"
fi