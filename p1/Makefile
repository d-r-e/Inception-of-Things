# makefile for two vagrant machines

NAME=iot
$(NAME): darodrigS darodrigSW

# Create the machines
darodrigS:
	VAGRANT_HOME=/goinfre/$USER/.vagrant.d vagrant up darodrigS

darodrigSW:
	VAGRANT_HOME=/goinfre/$USER/.vagrant.d vagrant up darodrigSW

stop:
	vagrant halt

clean: stop
	vagrant destroy -f

re: clean $(iot)

all: $(iot)