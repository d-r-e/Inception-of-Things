NAME=iot
 
$(NAME):
	mkdir -p /goinfre/darodrig/.vagrant.d
	VAGRANT_HOME=/goinfre/darodrig/.vagrant.d vagrant up

all: $(NAME)

darodrigS:
	VAGRANT_HOME=/goinfre/darodrig/.vagrant.d vagrant up darodrigS

darodrigSW:
	VAGRANT_HOME=/goinfre/darodrig/.vagrant.d vagrant up darodrigSW

stop:
	vagrant halt

clean: stop
	vagrant destroy -f

re: clean $(iot)
