base:
  '*':
    - pkgs/common-ubuntu-pkg
    - fail2ban/config
  'supervisor:runit':
    - match: grain
    - runit/package
  'is_virtual:True':
    - match: grain
    - users/vmuser
  'role:database':
    - match: grain
    - mysql/defaults
  'role:mail':
    - match: grain
    - postfix/config
  'role:webserver':
    - match: grain
    - vm/nginx
    - vm/logrotate
  'role:php':
    - match: grain
    - pkgs/php-for-vm

