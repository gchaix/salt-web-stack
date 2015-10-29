base:
   '*':
       - common-pkg
       - managed-files
   'standard_users:True':
       - match: grain
       - users
   'role:webserver':
       - match: grain
       - servers.nginx.install
       - servers.phpfpm.install
   'role:php':
       - dev-tools.php
