base:
  '*':
    - pkgs/common-ubuntu-pkg
    - fail2ban/config
  'runit:True':
    - runit/package
  'is_virtual:True':
    - users/vmuser
  'role:database':
    - match: grain
    - mysql/defaults
  'role:webserver':
    - match: grain
    - vm/nginx
  'role:php':
    - pkgs/php-for-vm
