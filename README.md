# Inception-of-Things


To start, export the VAGRANT_HOME env as /goinfre/darodrig/.vagrant.d

USER=darodrig
```
# first reset all possible vagrant machines
vagrant destroy -f
# then remove the .vagrant.d folder


rm -rf $HOME/.vagrant.d
mkdir -p /goinfre/$USER/.vagrant.d
mkdir -p /goinfre/$USER/.vbox
rm -rf $HOME/VirtualBox\ VMs
ln -s $HOME/VirtualBox\ VMs /goinfre/$USER/.vbox
ln -s /goinfre/$USER/.vagrant.d $HOME/.vagrant.d
VAGRANT_HOME=/goinfre/$USER/.vagrant.d vagrant up --provision

```

To get the ssh-config file, run the following command:

```
vagrant ssh-config iot
```

It can be copied to your local .ssh/config file to allow you to connect to the VM using the following command:

```
ssh iot
```