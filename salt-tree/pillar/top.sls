base:
  'u*':
    - pkgs/common-ubuntu-pkg

  '*vm':
    - users/vmuser

  '*devweb*':
    - vm/nginx
    - pkgs/php-for-vm
