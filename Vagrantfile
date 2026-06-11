Vagrant.configure("2") do |config|

  # Global settings go here
  config.vm.box = "debian/bookworm64" #current stable

  # First machine (Server)
  config.vm.define "yel-boukS" do |server|
    server.vm.hostname = "yel-boukS"
    server.vm.network "private_network", ip: "192.168.56.110"
    
    server.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end

    server.vm.provision "shell", inline: <<-SHELL
      # Your server provisioning script goes here
    SHELL
  end

  # Second machine (Agent)
  config.vm.define "yel-boukSW" do |agent|
    agent.vm.hostname = "yel-boukSW"
    agent.vm.network "private_network", ip: "192.168.56.111"

    agent.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end

    agent.vm.provision "shell", inline: <<-SHELL
      # Your agent provisioning script goes here
    SHELL
  end

end