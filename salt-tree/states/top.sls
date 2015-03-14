base:
   '*':
       - common-pkg
   'saltweb':
       - servers.nginx.install
       - servers.phpfpm.install
       - dev-tools.php
