Vagrant.configure("2") do |config|

  # Global settings go here
  config.vm.box = "______"

  # First machine (Server)
  config.vm.define "______" do |server|
    server.vm.hostname = "______"
    server.vm.network "private_network", ip: "______"
    
    server.vm.provider "virtualbox" do |vb|
      vb.memory = ______
      vb.cpus = ______
    end

    server.vm.provision "shell", inline: <<-SHELL
      # Your server provisioning script goes here
    SHELL
  end

  # Second machine (Agent)
  config.vm.define "______" do |agent|
    agent.vm.hostname = "______"
    agent.vm.network "private_network", ip: "______"

    agent.vm.provider "virtualbox" do |vb|
      vb.memory = ______
      vb.cpus = ______
    end

    agent.vm.provision "shell", inline: <<-SHELL
      # Your agent provisioning script goes here
    SHELL
  end

end