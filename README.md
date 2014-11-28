salt-web-stack
==============

My salt repo for building VMs for PHP development


Vagrant to provision the salt master
=======
You can spin up a docker image based on ubuntu 14.04 with phusion/baseimage additions on it with
```
vagrant up --provider docker
```

The Vagrantfile will automatically install Salt Stack for a master installation.

Provision developer image
===================
Bring up any other VM, docker or anything else (ubuntu flavored, tested only with 14.04).  
Add this second VM's IP to /etc/salt/roster like so

```
udevvm01:
   host: xxx.xxx.xxx.xxx
   user: root
   priv: /etc/salt/my-vms-root-private-key
```

Now SSH to that machine by IP (/etc/salt/roster != /etc/hosts) and accept the fingerprint.  Then install python 2.7

```
ssh -i /etc/salt/salt-rsa.ssh 172.17.0.X
apt-get update
apt-get install python2.7
```

Salt-SSH
===========
You don't need the salt master running or a salt minion deamon on your other machine.  Salt-SSH can connect to your
other VM and run any state files.  This is useful for developing your state files, which can be used in production
from another salt setup.

```
salt-ssh udevvm01 test.ping
salt-ssh udevvm01 state.sls servers.phpfpm.install  ;#runs the servers/phpfpm/install.sls file
```

You can install everything in the states/top.sls file by running the high state.

```
salt-ssh '*devvm*' state.highstate
```

That should get you nginx and php-fpm running under runit supervision.  Notice that the hostname is pattern matched
in this example.  I like to prefix the OS type in my hostnames with one letter (r = redhat, u = ubuntu, w = windows). 
