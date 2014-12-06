# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.synced_folder "salt-tree/", "/srv/salt/"

  config.vm.provider "virtualbox" do |v|
    v.name = "saltmaster"
    v.gui  = true
    config.vm.box = "ubuntu/trusty64"
  end

  config.vm.provider "docker" do |d|
    # Don't boot with headless mode
    d.remains_running = true;
    d.image = 'phusion/baseimage:0.9.15'
    d.create_args = ['--name', 'saltwebmaster',  '-t', '-p','4505', '-p', '4506', '-h', 'saltwebmaster', '--cap-add=SYS_PTRACE']
    d.cmd = ['/sbin/my_init', '--enable-insecure-key']
    d.has_ssh = true;

    # only phusion/baseimage has this insecure_key already installed
    config.ssh.private_key_path = "./insecure_key"
    config.ssh.username = "root"
  end

  ## Use all the defaults:
  config.vm.provision :salt do |salt|
    salt.no_minion = true
    salt.master_config = "etc/salt_master"
    salt.install_master = true
    salt.verbose = true
    salt.install_type = "git"
    salt.install_args = "v2014.7.0"
    #salt.bootstrap_options = "git v2014.7.0rc6 "
  end
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true
end
