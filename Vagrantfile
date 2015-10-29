# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.synced_folder "salt-tree/", "/srv/salt/"
  config.vm.synced_folder "etc/", "/etc/salt/"

  config.ssh.private_key_path = "./insecure_key"
  config.ssh.username = "root"

  config.vm.define "master" do |master|

    master.vm.provider "virtualbox" do |v|
      v.name = "saltwebmaster"
      v.gui  = true
      v.vm.box = "ubuntu/trusty64"
    end

    master.vm.provider "docker" do |d|
      master.vm.box = nil
      # Don't boot with headless mode
      d.remains_running = true;
      d.image = 'phusion/baseimage:0.9.15'
      d.create_args = ['--name', 'saltwebmaster',  '-t', '-p','4505', '-p', '4506', '-h', 'saltwebmaster', '--link', 'saltweb:saltweb', '--cap-add=SYS_PTRACE']
      d.cmd = ['/sbin/my_init', '--enable-insecure-key']
      d.has_ssh = true;

      # only phusion/baseimage has this insecure_key already installed
      master.ssh.private_key_path = "./insecure_key"
      master.ssh.username = "root"
    end

    ## Use all the defaults:
    master.vm.provision :salt do |salt|
      salt.no_minion = true
      salt.master_config = "etc/salt_master"
      salt.install_master = true
      salt.verbose = true
	  salt.bootstrap_options = "-P -n"
      salt.install_type = "git"
      salt.install_args = "v2015.8.1"
      salt.run_overstate = false
    end
  end

  config.vm.define "web" do |web|
#    web.vm.synced_folder "salt-tree/", "/srv/salt/"

    web.vm.provider "virtualbox" do |v|
      v.name = "saltweb"
      v.gui  = true
      v.vm.box = "ubuntu/trusty64"
    end

    web.vm.provider "docker" do |d|
      web.vm.box = nil
      # Don't boot with headless mode
      d.remains_running = true;
      d.image = 'phusion/baseimage:0.9.15'
      d.create_args = ['--name', 'saltweb',  '-t', '-p','4505', '-p', '4506', '-h', 'saltweb', '--cap-add=SYS_PTRACE']
      d.cmd = ['/sbin/my_init', '--enable-insecure-key']
      d.has_ssh = true;

      # only phusion/baseimage has this insecure_key already installed
      web.vm.ssh.private_key_path = "./insecure_key"
      web.vm.ssh.username = "root"
    end

    web.vm.provision :shell, path: "install_python_27.sh"
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
