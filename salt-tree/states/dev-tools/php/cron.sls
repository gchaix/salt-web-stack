include:
  - .init

update_composer:
  cron.present:
    - name: "/usr/local/bin/composer --self-update"
    - month: '*/2'
    - minute: random
    - hour: random
    - daymonth: random
    - identifier: update_composer
    - require:
      - cmd: install_composer
