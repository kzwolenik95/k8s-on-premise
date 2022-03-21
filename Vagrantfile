Vagrant.configure("2") do |config|

  # install public ssh key on each VM machine
  ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
  config.vm.provision 'shell', inline: "echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys", privileged: false

  # add host names
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update -y
    echo "10.0.0.10  master-node01" >> /etc/hosts
    echo "10.0.0.11  master-node02" >> /etc/hosts
    echo "10.0.0.12  master-node03" >> /etc/hosts
    echo "10.0.0.13  worker-node01" >> /etc/hosts
    echo "10.0.0.14  worker-node02" >> /etc/hosts
  SHELL

  # create master nodes
  (1..3).each do |i|
    config.vm.define "master0#{i}" do |master|
      master.vm.box = "bento/ubuntu-20.04"
      master.vm.hostname = "master-node0#{i}"
      master.vm.network "private_network", ip: "10.0.0.1#{i-1}"
      master.vm.provider "virtualbox" do |vb|
        vb.memory = 4048
        vb.cpus = 2
      end
    end
  end
  
  # create worker nodes
  (1..2).each do |i|
    config.vm.define "node0#{i}" do |node|
      node.vm.box = "bento/ubuntu-20.04"
      node.vm.hostname = "worker-node0#{i}"
      node.vm.network "private_network", ip: "10.0.0.1#{i+2}"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 1
      end
    end
  end
end
