{% from "xymon/package-map.jinja" import pkgs with context %}
{% set xymon = pillar.get('xymon', {}) -%}

xymon-client:
  pkg.installed:
    - name: {{ pkgs['xymon-client'] }}
    - service.running:
      - enable: True
      - name: {{ pkgs.get('client-service', 'xymon-client') }}
      - watch:
        - pkg: xymon-client
  file.replace:
    - name: {{ pkgs.get('sysconfig', '/etc/default') }}/{{ pkgs.get('client-default-file', 'xymon-client') }}
    - pattern: ^{{ pkgs.get('client-default-pattern', 'XYMONSERVERS=') }}.*
    - repl: {{ pkgs.get('client-default-pattern', 'XYMONSERVERS=') }}"{{ xymon.get('server', '127.0.0.1') }}"
    - watch_in:
      - service: xymon-client
