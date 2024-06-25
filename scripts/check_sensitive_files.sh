#!/bin/bash

# Setare config.txt
CONFIG_FILE="../config/config.txt"

# Funcție pentru citirea valorilor din config.txt
get_config_value() {
    local key=$1
    grep "^${key}=" "$CONFIG_FILE" | cut -d '=' -f2- | tr -d '"'
}

# Extrage fișierele sensibile și alte configurații din config.txt
SENSITIVE_FILES=$(get_config_value "SENSITIVE_FILES")
LOG_FILE=$(get_config_value "LOG_FILE")
REPORT_FILE=$(get_config_value "SENSITIVE_FILE_REPORT")

# Data curentă
CURRENT_DATE=$(date +'%Y-%m-%d %H:%M:%S')

# Funcție pentru verificarea și înregistrarea permisiunilor fișierelor sensibile
check_permissions() {
    local file="$1"
    local permissions=$(ls -l "$file" | awk '{print $1}')
    echo "Fișier: $file" >> "$REPORT_FILE"
    echo "Permisiuni: $permissions" >> "$REPORT_FILE"
    echo "Verificare efectuată la: $CURRENT_DATE" >> "$REPORT_FILE"
    echo "-----------------------------------------" >> "$REPORT_FILE"
    echo "Verificare permisiuni pentru $file la data $CURRENT_DATE" >> "$LOG_FILE"
    echo "Permisiuni: $permissions" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
}

# Șterge conținutul actual al LOG_FILE
#echo "" > "$LOG_FILE"

# Verificarea permisiunilor pentru fiecare fișier sensibil
for file in $SENSITIVE_FILES; do
    check_permissions "$file"
done

echo "Verificarea permisiunilor pentru fișierele sensibile a fost finalizată la: $CURRENT_DATE."

