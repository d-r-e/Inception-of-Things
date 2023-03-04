#!/bin/bash
set -e


DEPENDENCIES=(lynx wget gnupg ruby-full curl qemu-kvm libvirt-daemon-system ncdu)

# Install dependencies
for dep in "${DEPENDENCIES[@]}"; do
    if [ -z "$(which $dep)" ]; then
        echo "Installing $dep..."
        apt-get install -y $dep >/dev/null
        echo -e [+] "\e[32m$dep installed successfully!\e[0m"
    else
        echo -e [+] "\e[32m$dep already installed.\e[0m"
        sleep 0.2
    fi
done

# Install virtualbox
if [ -z "$(which virtualbox)" ]; then
    echo "Installing virtualbox..."
    if [ ! -f /tmp/virtualbox.deb ]; then
        wget https://download.virtualbox.org/virtualbox/7.0.6/virtualbox-7.0_7.0.6-155176~Debian~bullseye_amd64.deb -O /tmp/virtualbox.deb  2>&1
    fi
    apt install -yq /tmp/virtualbox.deb  2>&1
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
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt update && apt-get install -yq vagrant
    echo -e [+] "\e[32mVagrant installed successfully!\e[0m"
else
    echo -e [+] "\e[32mVagrant already installed.\e[0m"
    sleep 0.2
fi


# install kubectl
if [ -z "$(which kubectl)" ]; then
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    echo -e [+] "\e[32mKubectl installed successfully!\e[0m"
    if [ $(echo $SHELL | grep -c "zsh") -eq 1 ]; then
        echo "source <(kubectl completion zsh)" >> ~/.zshrc
    elif [ $(echo $SHELL | grep -c "bash") -eq 1 ]; then
        echo "source <(kubectl completion bash)" >> ~/.bashrc
    fi
else
    echo -e [+] "\e[32mKubectl already installed.\e[0m"
    sleep 0.2
fi

