{% set vhostroot = salt['pillar.get']('postfix:virtual_mailbox_base', "/var/mail/vhosts") %}
{% for emailandpath in salt['pillar.get']('postfix:vmailbox', "a example.com/Maildir").split("\n") %}
{% if emailandpath != '' %}
{% set addr = emailandpath.split(" ")[0] %}
{% set path = emailandpath.split(" ")[1] %}
mailboxpath_for_{{ addr }}:
    file.directory:
      - name: {{ vhostroot }}/{{ path }}
      - user: mail
      - group: mail
      - dir_mode: 755
      - file_mode: 644
      - makedirs: True
{% endif %}
{% endfor %}
