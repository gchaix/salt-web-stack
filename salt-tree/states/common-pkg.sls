common-pkg:
  pkg:
    - installed
    - pkgs:
{% for name in pillar.get('common-pkg', []) %}
      - {{ name }}
{% endfor %}
