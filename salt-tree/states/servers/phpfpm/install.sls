php56_install:
  pkg.installed:
    - name: php5


{% for pkg, listkey in pillar.get('php-packages', {}).items() %}
{{pkg}}:
  pkg.installed:
    - require:
      - pkg: php56_install
{% endfor %}

php56_ppa_repo:
  pkgrepo:
    - managed
    - humanname: php56-ppa-{{ grains['oscodename'] }}
    - name: deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/php56-{{ grains['oscodename'] }}.list
    - dist: {{ grains['oscodename'] }}
    - keyid: E5267A6C
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: php56_install
    - watch_in:
      - pkg: php56_install

phpfpm_sv:
  file.managed:
    - name: /etc/service/phpfpm/run
    - source: salt://servers/phpfpm/files/phpfpm-runit.sh
    - user: www-data
    - group: www-data
    - makedirs: True
    - mode: 744
    - require:
      - pkg: php56_install
