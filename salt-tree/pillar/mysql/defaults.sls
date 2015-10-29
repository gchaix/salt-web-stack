mysql:
  server:
    # root_password: False - to have root@localhost without password
    # override in specific machine sls
    root_password: False
    user: docker
    # my.cnf sections changes
    mysqld:
      # you can use either underscore or hyphen in param names
      bind-address: 0.0.0.0
      log_bin: /var/log/mysql/mysql-bin.log
      port: 3306
    mysql:
      # my.cnf param that not require value
      no-auto-rehash: noarg_present
