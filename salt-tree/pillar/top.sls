base:
  '*':
    - pkgs/common-ubuntu-pkg
	- fail2ban/config
  'is_virtual:True':
    - users/vmuser
  'role:database':
    - match: grains
    - mysql/defaults
  'role:webserver':
    - match: grains
    - vm/nginx
  'role:php':
    - pkgs/php-for-vm
