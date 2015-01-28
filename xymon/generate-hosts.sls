{% from "xymon/package-map.jinja" import pkgs with context %}
{% set m_env = salt['grains.get']('environment') %}
{% for host, hostinfo in salt['mine.get']('environment:' + m_env, 'network.interfaces', expr_form='grain').items() %}
xymon-client-{{ host }}:
    file.append:
      - append_if_not_found: True
      - name: {{ pkgs.get('config-path', '/etc/xymon') }}/hosts.d/salt-mine
      - text:
        - "{{ hostinfo['eth0']['inet'][0]['address'] if hostinfo['eth0'].has_key('inet') }} {{ host }} # CLIENT:{{ host }}"
{% endfor %}
