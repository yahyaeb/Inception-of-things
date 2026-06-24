Vagrant.configure("2") do |config| #API version, always "2"

  # Global settings go here
  config.vm.box = "debian/bookworm64" #current stable
  config.vm.provider "libvirt" do |lv|
    lv.default_prefix = ""
  end
  #runs on all machines
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get upgrade -y
    apt-get install -y curl
    
  SHELL

  # First machine (Server)
  config.vm.define "yel-boukS" do |server|
    server.vm.hostname = "yel-boukS"
    server.vm.network "private_network", ip: "192.168.56.110"
    
    server.vm.provider "libvirt" do |vb|
      vb.memory = 1024
      vb.cpus = 1
      vb.machine_type = "pc"
      vb.driver = "qemu"
    end

    server.vm.provision "shell", inline: <<-SHELL
     # Server provisioning script:
     #when token is not defined, it's automatically generated at /var/lib/rancher/k3s/server/node-token
      curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --disable traefik --disable metrics-server" K3S_TOKEN=mytoken123 sh -s -
      #makes the k3s config file readable by all users
      chmod 644 /etc/rancher/k3s/k3s.yaml 
      cat /var/lib/rancher/k3s/server/node-token > /vagrant/token
     
    SHELL
  end

  # Second machine (Agent)
  config.vm.define "yel-boukSW" do |agent|
    agent.vm.hostname = "yel-boukSW"
    agent.vm.network "private_network", ip: "192.168.56.111"

    agent.vm.provider "libvirt" do |vb|
      vb.memory = 1024
      vb.cpus = 1
      vb.machine_type = "pc"
      vb.driver = "qemu"
    end

    agent.vm.provision "shell", inline: <<-SHELL
      # Agent provisioning script:
      while ! curl -sk https://192.168.56.110:6443 > /dev/null 2>&1; do
        echo "Waiting for server..."
        sleep 5
      done
      sleep 30
      curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=mytoken123 sh -s - || true
    SHELL
  end

end