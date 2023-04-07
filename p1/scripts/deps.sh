#!/bin/bash
set -e


function install_deps(){
    apt-get update && apt-get upgrade -y >/dev/null

    DEPENDENCIES=(zsh firefox-esr git wget gnupg curl ncdu linux-headers-amd64  linux-headers-5.10.0-20-amd64)
    apt-get install -yq ${DEPENDENCIES[@]} >/dev/null
}

install_deps


chsh -s /bin/zsh vagrant

# Install virtualbox
if [ -z "$(which virtualbox)" ]; then
    echo "Downloading virtualbox..."
    if [ ! -f /tmp/virtualbox.deb ]; then
        wget https://download.virtualbox.org/virtualbox/7.0.6/virtualbox-7.0_7.0.6-155176~Debian~bullseye_amd64.deb -O /tmp/virtualbox.deb  2>&1
    fi
    echo "Installing virtualbox..."
    apt-get install -y linux-headers-5.10.0-20-amd64
    apt-get install -y /tmp/virtualbox.deb
    /sbin/vboxconfig
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
    apt update && apt-get install -yq vagrant >/dev/null
    /sbin/usermod -aG vboxusers vagrant
    echo -e [+] "\e[32mVagrant installed successfully!\e[0m"
else
    echo -e [+] "\e[32mVagrant already installed.\e[0m"
    sleep 0.2
fi

if [ -z "$(which k)" ]; then
    echo 'alias k=kubectl' >> /home/vagrant/.bashrc
fi

echo "192.168.56.110" app1.com >> /etc/hosts
echo "192.168.56.110" app2.com >> /etc/hosts
echo "192.168.56.110" app3.com >> /etc/hosts
echo "127.0.0.1" argocd.local >> /etc/hosts
echo "127.0.0.1" wil42.local >> /etc/hosts
echo "Hosts file updated"

# Install argocd cli
# https://github.com/argoproj/argo-cd/releases/download/v2.6.7/argocd-linux-amd64



if [ -z "$(which startxfce4)" ]; then
    echo "Installing xfce..."

    cat << EOF > /home/vagrant/.xsessionrc
/home/vagrant/.xsessionrc
# Lightdm sources .xsessionrc
# Add env variables here

# source the system profile
# if [ -f /etc/profile ]; then
#     . /etc/profile
# fi

# QT5 qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

# QT5 scaling
# Uncomment for hidpi display
# export QT_AUTO_SCREEN_SCALE_FACTOR=1
# export QT_SCREEN_SCALE_FACTORS=2

EOF

    chown vagrant:vagrant /home/vagrant/.xsessionrc
    apt install -y \
        libxfce4ui-utils \
        thunar \
        xfce4-appfinder \
        xfce4-panel \
        xfce4-pulseaudio-plugin \
        xfce4-whiskermenu-plugin \
        xfce4-session \
        xfce4-settings \
        xfce4-terminal \
        xfconf \
        xfdesktop4 \
        xfwm4 \
        adwaita-qt \
        qt5ct \
        xorg
else
    echo -e [+] "\e[32mXfce already installed.\e[0m"

# set resolution for "root" user to 1280x1024
xrandr --newmode "1280x1024_60.00"  108.00  1280 1368 1504 1712  1024 1027 1034 1063 -hsync +vsync
    sleep 0.2
fi

