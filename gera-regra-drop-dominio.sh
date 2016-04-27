#!/bin/bash

DOMINIOS=("exemplo1.com" "exemplo2.net" "exemplo3.org" "wap.exemplo4.co.cn"  "a.root-servers.net")
REGRA1="/sbin/iptables -A INPUT -p udp --dport 53 -m string --algo bm --hex-string"
REGRA2="--to 255 -j DROP -m comment --comment \"DROP A"

for DOMINIO in "${DOMINIOS[@]}"; do

   echo -n "${DOMINIO} => ${REGRA1} '"

   while IFS='.' read -ra DOM ; do
      for i in "${DOM[@]}"; do
          hexa=`echo "obase=16; ${#i}"| bc | sed -e :a -e 's/^.\{0,1\}$/0&/;ta'`
          echo -n "|${hexa}|${i}"
      done
    done <<< "${DOMINIO}"

    echo "|000001|' ${REGRA2} ${DOMINIO}\""
done
