managed-files:
  /etc/logrotate.d/vhosts
    source: salt://logrotate/vhosts.txt
    user: root
    mode: 544
    makedirs: True
