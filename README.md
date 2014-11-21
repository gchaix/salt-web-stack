salt-web-stack
==============

My salt repo for building VMs for PHP development


Vagrant
=======
You can spin up a docker image based on ubuntu 14.04 with phusion/baseimage additions on it with
```
vagrant up --provider docker
```

Provision the Image
===================
Bring up any other VM, docker or anything else.  Add this VM's IP to /etc/salt/roster like so

```
mydevvm01:
   host: xxx.xxx.xxx.xxx
   user: root
   priv: /etc/salt/my-vms-root-private-key
```

Salt-SSH
===========
You don't need the salt master running or a salt minion deamon on your other machine.  Salt-SSH can connect to your
other VM and run any state files.  This is useful for developing your state files, which can be used in production
from another salt setup.

```
salt-ssh mydevvm01 test.ping
salt-ssh mydevvm01 state.sls servers.phpfpm.install  ;#runs the servers/phpfpm/install.sls file
```
