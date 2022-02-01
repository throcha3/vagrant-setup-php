Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.synced_folder "www/", "/var/www", owner: "www-data", group: "www-data", mount_options: ['dmode=777','fmode=666']
  config.vm.synced_folder "~", "/vagrant", owner: "vagrant", group: "vagrant"
  config.vm.provider "virtualbox" do |machine|
    machine.memory = 1024
    machine.name = "ubuntu-server-php"
  end
  config.vm.provision :shell, path: "setup.sh"
end
