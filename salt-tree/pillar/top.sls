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
  'role:webserver':
    - match: grain
    - vm/nginx
  'role:php':
    - pkgs/php-for-vm
