nginx_install:
  pkg.installed:
    - name: nginx

nginx_ppa_repo:
  pkgrepo:
    - managed
    - humanname: nginx-ppa-{{ grains['oscodename'] }}
    - name: deb http://ppa.launchpad.net/nginx/stable/ubuntu {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/nginx-stable-{{ grains['oscodename'] }}.list
    - dist: {{ grains['oscodename'] }}
    - keyid: C300EE8C
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: nginx_install
    - watch_in:
      - pkg: nginx_install

nginx_sv:
  file.managed:
    - name: /etc/service/nginx/run
    - source: salt://servers/nginx/files/nginx-runit.sh
    - user: www-data
    - group: www-data
    - makedirs: True
    - mode: 744
    - require:
      - pkg: nginx_install

nginx_stop_unsupervised_service:
  service.dead:
    - name: nginx
    - require_in: nginx_run

nginx_run:
  service.running:
    - name: nginx
    - enable: True
    - provider: runit
