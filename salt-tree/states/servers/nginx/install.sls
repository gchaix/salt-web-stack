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
