{% set nginx = salt['pillar.get']('nginx', {}) %}

# Manage the actual vhost files
{% for vhost, settings in nginx.vhosts.managed.items() %}
{% set conf_state_id = 'vhost_conf_' ~ loop.index0 %}

{{ conf_state_id }}:
  file.managed:
    - name: /etc/nginx/sites-enabled/{{ vhost }}
    - source: salt://nginx/vhosts/{{vhost}}.conf
    - template: jinja
    - context:
        config: {{ settings.config|json() }}
{% endfor %}
