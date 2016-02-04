postfix:
  smtpd_banner: $myhostname ESMTP $mail_name
  biff: 'no'

  append_dot_mydomain: 'no'

  readme_directory: 'no'

  #smtpd_tls_cert_file: /etc/pki/tls/certs/dovecot.pem
  #smtpd_tls_key_file: /etc/pki/tls/private/dovecot.pem
  #smtpd_use_tls: 'yes'
  #smtpd_tls_session_cache_database: btree:${data_directory}/smtpd_scache
  #smtp_tls_session_cache_database: btree:${data_directory}/smtp_scache

  myhostname: {{ grains['fqdn'] }}
  alias_maps: hash:/etc/aliases
  alias_database: hash:/etc/aliases
  #mydestination: localhost.localdomain  add your own
  relayhost: 
  mynetworks: 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
  mailbox_size_limit: 0
  recipient_delimiter: +
  inet_interfaces: all

  #smtpd_sasl_auth_enable: 'yes'
  #smtpd_sasl_type: dovecot
  #smtpd_sasl_path: private/auth
  smtpd_relay_restrictions: permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination

  virtual_minimum_uid: 7
  virtual_uid_maps: static:8
  virtual_gid_maps: static:8
  #mailbox_command: /usr/bin/procmail -a "$EXTENSION" DEFAULT=$HOME/Maildir/ MAILDIR=$HOME/Maildir/
  #virtual_transport: vprocmail
  virtual_mailbox_base: /var/mail/vhosts
  virtual_destination_recipient_limit: 1
  vprocmail_destination_recipient_limit: 1
  #virtual_mailbox_domain: add your own
  #vmailbox: | add your own
