# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "RAC-development-Vagrant"

   # The url from where the 'config.vm.box' box will be fetched if it
   # doesn't already exist on the user's system.
   # config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.box_url = "https://github.com/jose-lpa/packer-debian_7.6.0/releases/download/1.0/packer_virtualbox-iso_virtualbox.box"
  

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1", "--ioapic", "on"]
  end

  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.network :forwarded_port, guest: 80, host: 9000
  # config.vm.network :forwarded_port, guest: 3306, host: 3308

end