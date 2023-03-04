#!/bin/bash
set -euo pipefail

DEPENDENCIES=(lynx wget)

# Install dependencies
for dep in "${DEPENDENCIES[@]}"; do
    if [ -z "$(which $dep)" ]; then
        echo "Installing $dep..."
        apt install -y $dep >/dev/null 2>&1
        echo -e [+] "\e[32m$dep installed successfully!\e[0m"
    else
        echo -e [+] "\e[32m$dep already installed.\e[0m"
        sleep 0.2
    fi
done

# Install virtualbox
if [ -z "$(which virtualbox)" ]; then
    echo "Installing virtualbox..."
    wget https://download.virtualbox.org/virtualbox/7.0.6/virtualbox-7.0_7.0.6-155176~Debian~bullseye_amd64.deb -O /tmp/virtualbox.deb >/dev/null 2>&1
    dpkg -i /tmp/virtualbox.deb >/dev/null 2>&1
    echo -e [+] "\e[32mVirtualbox installed successfully!\e[0m"
    # Clean up
    rm /tmp/virtualbox.deb >/dev/null 2>&1 && echo -e [+] "\e[32mCleaned up successfully!\e[0m" || true
else
    echo -e [+] "\e[32mVirtualbox already installed.\e[0m"
    sleep 0.2
fi

# Install vagrant
if [ -z "$(which vagrant)" ]; then
    echo "Installing vagrant..."
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null 2>&1
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list >/dev/null 2>&1
    apt update >/dev/null 2>&1
    apt install -y vagrant >/dev/null 2>&1
    echo -e [+] "\e[32mVagrant installed successfully!\e[0m"
else
    echo -e [+] "\e[32mVagrant already installed.\e[0m"
    sleep 0.2
fi

# Generate iot.pub and iot.key for the server in $HOME/.ssh
if [ ! -f $HOME/.ssh/iot.pub ]; then
    echo "Generating SSH keys..."
    ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/iot -N "" >/dev/null 2>&1
    echo -e [+] "\e[32mSSH keys generated successfully!\e[0m"
    sleep 0.2
else
    echo -e [+] "\e[32mSSH keys already generated.\e[0m"
    sleep 0.2
fi
