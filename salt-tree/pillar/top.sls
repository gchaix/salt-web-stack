base:
  '*':
    - pkgs/common-ubuntu-pkg
  '*web*':
    - users/vmuser
    - vm/nginx
    - pkgs/php-for-vm
