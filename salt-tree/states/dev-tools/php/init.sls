install_composer:
  cmd.script:
    - cwd: /tmp
    - creates: /usr/local/bin/composer
    - source: salt://dev-tools/php/files/composer-install.sh
#    - name: "php --install-dir=/usr/local/bin --filename=composer"
#    - shell: "/usr/bin/php"

install_phpunit:
  file.managed:
    - name: /usr/local/bin/phpunit
    - source: https://phar.phpunit.de/phpunit-4.3.5.phar
    - source_hash: sha1=aec4d03b9bec8a1561569800355b7f5c5556afe3
    - mode: 555
