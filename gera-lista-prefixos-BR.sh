#!/bin/bash

ARQUIVO="lista-lacnic.txt"
URL="http://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-latest"

# Declara array da mascara de rede
declare -a MASCARA

if [ ! -e "${ARQUIVO}" ] || (test `find "${ARQUIVO}" -mtime +1`); then
   #echo -n "Atualizando arquivo do LACNIC... "
   wget -q -O "${ARQUIVO}" "${URL}"
   touch "${ARQUIVO}"
   #echo " OK."
   #echo ""
fi

# monta array com as mascaras
for i in {24..8}; do
   let "bits = 32 - $i"
   let "hosts = 2 ** $bits"
   #echo "Mascara /${i}: ${bits} bits = ${hosts} hosts"
   MASCARA[$hosts]=$i
done

#echo "${MASCARA[@]}"

# Busca os prefixos BR ipv4
for PREFIXO in "`cat \"${ARQUIVO}\" | grep 'lacnic|BR|ipv4|'`"; do
   while IFS='|' read -ra LINHA; do
      qtdips=${LINHA[4]}
      echo "${LINHA[3]}/${MASCARA[$qtdips]}"
   done <<< "${PREFIXO}"
done

