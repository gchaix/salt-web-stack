{% for fname, info in pillar.get('managed-files', {}).iteritems() %}
  {{ fname }}:
    file.managed:
      - source: {{ info['source'] }}
      {% if 'user' in info %}- user: {{ info['user'] }}{% endif %}
      {% if 'mode' in info %}- mode: {{ info['mode'] }}{% endif %}
      {% if 'makedirs' in info %}- makedirs: {{ info['makedirs'] }}{% endif %}
{% endfor %}
