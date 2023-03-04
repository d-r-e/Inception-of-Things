# Inception-of-Things


To start, export the VAGRANT_HOME env as /goinfre/darodrig/.vagrant.d

USER=darodrig
```
mkdir -p /goinfre/$USER/.vagrant.d
mkdir -p /goinfre/$USER/.vbox
ln -s $HOME/VirtualBox\ VMs /goinfre/$USER/.vbox
VAGRANT_HOME=/goinfre/$USER/.vagrant.d vagrant up
vagrant ssh iot
```

To get the ssh-config file, run the following command:

```
vagrant ssh-config iot
```

It can be copied to your local .ssh/config file to allow you to connect to the VM using the following command:

```
ssh iot
```