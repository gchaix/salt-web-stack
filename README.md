salt-web-stack
==============

My salt repo for building VMs for PHP development.  These salt states will add Ondrej Sury's PHP 5.6 PPA and installs php-fpm, as well as tools like phpunit and composer (into /usr/local/bin/).  Nginx is installed, but with only the default vhost file.


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


Convert to Docker Image
===========
If you have brought up another docker container to provision you can convert that container to an image for sharing
with your dev team.  To convert your new container to a docker image you only need 1 step, but could benefit from 2.
```
docker commit xxxxx  dev-image-nginx-php56:1 # where xxxxx is the container ID
```

The second command involves exposing ports and volumes for your image.  Simply create a Dockerfile which pulls from
our newly created image and exposes any ports or volumes you want.

```
FROM dev-image-nginx-php56:1

VOLUME /app
VOLUME /etc/nginx/sites-enabled
EXPOSE 80
EXPOSE 443
EXPOSE 3000
EXPOSE 3306
EXPOSE 3309
EXPOSE 8080
```

Now build that Docker file into a new image.

```
docker build -t dev-image-nginx-php56:latest .
```
Notice how we keep the version number at 1 for building the 'crude' docker image?  This is because (I don't think) 
you can use any letters like alpha or beta (other than 'latest') when giving a version to your docker image.

Now, whenever we upgrade the image, the 'crude' image provisioned with salt can always remain version 1, and the 
'polished' image that was made with docker can be any version you want.
