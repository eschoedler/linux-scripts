#!/bin/bash

DOMINIOS=("app-softwares.com" "mc.sz-gufeng.cn" "huibenguan.com.cn" "a.root-servers.net" "in-addr.arpa")

for DOMINIO in "${DOMINIOS[@]}"; do
   #echo "obase=16; 48"|bc | sed -e :a -e 's/^.\{0,1\}$/0&/;ta'

   echo -n "${DOMINIO} => "

   while IFS='.' read -ra DOM ; do
      for i in "${DOM[@]}"; do
          hexa=`echo "obase=16; ${#i}"| bc | sed -e :a -e 's/^.\{0,1\}$/0&/;ta'`
          echo -n "|${hexa}|${i}"
      done
    done <<< "${DOMINIO}"

    echo "|000001|"
done
