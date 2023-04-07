Vagrant.configure(2) do |config|
    config.vm.box = "debian/bullseye64"
    config.vm.define "iot" do |iot|
        iot.vm.hostname = "iot"
        iot.vm.provider :virtualbox do |vb|
            vb.memory = 4096
            vb.cpus = 6
            vb.gui = true
            vb.customize [
                "modifyvm", :id,
                "--nested-hw-virt", "on",]
            vb.customize [
                "modifyvm", :id,
                "--vram", "256",
            ]
        end
        iot.vm.synced_folder ".", "/home/vagrant/iot/"
        iot.vm :ssh do |ssh|
            ssh.forward_agent = true
            ssh.forward_x11 = true
            ssh.shell = "/bin/zsh"
        end
        iot.vm.network "public_network", bridge: "bridge0", ip: "10.200.11.155"
        iot.vm.provision :shell, privileged: true, name: "dependencies", path: "./p1/scripts/deps.sh"
        iot.vm.provision :shell do |shell|
            shell.privileged = true
            shell.inline = 'echo Rebooting...'
            shell.reboot = true
        end
        # iot.vm.provision :shell, privileged: true, path: "./p1/scripts/after_install.sh"
        # iot.vm.provision :shell, privileged: true, path: "./p3/scripts/setup.sh"
        iot.vm.provision :shell, privileged: true, path: "./p3/scripts/up.sh"
    end
end