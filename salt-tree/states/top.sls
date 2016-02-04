base:
   '*':
       - common-pkg
       - managed-files
   'standard_users:True':
       - match: grain
       - users
   'G@role:database':
       - mariadb.server
       - mariadb.client
   'role:webserver':
       - match: grain
       - servers.nginx.install
       - servers.nginx.vhosts
       - servers.phpfpm.install
   'role:mail':
       - postfix
       - dovecot
       - postfix.config
   'role:php':
       - dev-tools.php
       - dev-tools.php.cron
