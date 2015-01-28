{% from "xymon/package-map.jinja" import pkgs with context %}
{% set xymon = pillar.get('xymon', {}) -%}

include:
  - apache

xymon-server:
  pkg.installed:
    - name: {{ pkgs['xymon-server'] }}
    - service.running:
      - enable: True
      - name: {{ pkgs.get('server-service', 'xymon') }}
      - watch:
        - pkg: xymon-server
      - watch_in:
        - pkg: apache
        - file: xymon-server-hosts-directory

{{ pkgs.get('config-path', '/etc/xymon') }}/hosts.d:
  file.directory

xymon-server-hosts-directory:
  file.append:
    - name: {{ pkgs.get('config-path', '/etc/xymon') }}/{{ pkgs.get('hosts-file', 'hosts.cfg') }}
    - text:
      - "directory      {{ pkgs.get('config-path', '/etc/xymon') }}/hosts.d"

#xymon-server-admin-user:
#  module.run:
#    - name: apache.useradd
#    - pwfile: /etc/hobbit/hobbitpasswd
#    - user: "{{ xymon.get('adminuser', 'hobbit') }}"
#    - password: "{{ xymon.get('adminpassword', 'hobbit') }}"

xymon-apache-conf:
    file.managed:
        - source: salt://xymon/files/hobbit-apache.conf
        - name: /etc/apache2/conf.d/hobbit
        - watch_in:
          - service: apache
