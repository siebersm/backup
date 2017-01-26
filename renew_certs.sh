#!/bin/bash


# Allow USA (Letsencrypt) tijdelijk ivm renew certificates
/bin/firewall-cmd --direct --remove-rule ipv4 filter INPUT 0 -m geoip ! --src-cc AT,BE,CH,DE,DK,ES,FI,FR,GB,IT,LU,NL,NO,PT,SE -j DROP
/bin/firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -m geoip ! --src-cc AT,BE,CH,DE,DK,ES,FI,FR,GB,IT,LU,NL,NO,PT,US -j DROP


# Renew Certificates
/usr/local/letsencrypt/letsencrypt-auto renew


# Disallow USA
/bin/firewall-cmd --direct --remove-rule ipv4 filter INPUT 0 -m geoip ! --src-cc AT,BE,CH,DE,DK,ES,FI,FR,GB,IT,LU,NL,NO,PT,US -j DROP
/bin/firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -m geoip ! --src-cc AT,BE,CH,DE,DK,ES,FI,FR,GB,IT,LU,NL,NO,PT,SE -j DROP


/bin/systemctl restart httpd.service
/bin/systemctl restart fail2ban.service

