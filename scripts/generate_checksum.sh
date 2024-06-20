#!/bin/bash

CONFIG_FILE="../config/config.txt"

# Funcție pentru citirea valorilor din config.txt
get_config_value() {
    local key=$1
    grep "^${key}=" "$CONFIG_FILE" | cut -d '=' -f2- | tr -d '"'
}

# Extrage directoarele și fișierul de sume de control din config.txt
DIRECTORIES=$(get_config_value "DIRECTORIES")
CHECKSUMS_FILE=$(get_config_value "CHECKSUMS_FILE")

# Data curentă
CURRENT_DATE=$(date +'%Y-%m-%d %H:%M:%S')

# Generarea sumelor de control
echo "Generare sume de control pentru fișierele din directoarele specificate la data: $CURRENT_DATE" > $CHECKSUMS_FILE
for dir in $DIRECTORIES; do
    find "$dir" -type f -exec sha256sum {} \; >> $CHECKSUMS_FILE
done

echo "Sumele de control au fost generate și salvate în $CHECKSUMS_FILE la data: $CURRENT_DATE."
