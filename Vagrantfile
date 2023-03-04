Vagrant.configure(2) do |config|
    config.vm.box = "debian/buster64"
    config.vm.box_url = "https://app.vagrantup.com/debian/boxes/buster64"
    config.vm.define "iot" do |iot|
        iot.vm.hostname = "iot"
        iot.vm.provider :virtualbox do |vb|
            vb.memory = 4096
            vb.cpus = 6
            vb.gui = false
            vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"] # enable nested virtualization
        end

        iot.vm :ssh do |ssh|
            ssh.forward_agent = true
            ssh.forward_x11 = true
        end


        iot.vm.network "public_network", bridge: "bridge0", ip: "10.200.11.155"
        iot.vm.provision :shell, privileged: true, path: "./p1/scripts/deps.sh"
    end
end