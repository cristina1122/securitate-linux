#!/bin/bash

CONFIG_FILE="../config/config.txt"

# Funcție pentru citirea valorilor din config.txt
get_config_value() {
    local key=$1
    grep "^${key}=" "$CONFIG_FILE" | cut -d '=' -f2- | tr -d '"'
}

# Extrage valorile necesare din config.txt
CHECKSUMS_FILE=$(get_config_value "CHECKSUMS_FILE")
CHECKSUM_REPORT_FILE=$(get_config_value "CHECKSUM_REPORT_FILE")
LOG_FILE=$(get_config_value "LOG_FILE")

# Scrie în fișierul de log
log_message() {
    local message=$1
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" >> $LOG_FILE
}

# Data curentă
CURRENT_DATE=$(date +'%Y-%m-%d %H:%M:%S')

# Începe logarea și verificările
log_message "Începerea verificării sumelor de control."

# Verifică sumele de control, vreau sa se suprascrie la fiecare rulare
echo "Verificare sume de control pentru pachete la data: $CURRENT_DATE" > $CHECKSUM_REPORT_FILE

# Ignorarea primei linii și procesarea celorlalte
tail -n +2 "$CHECKSUMS_FILE" | while IFS= read -r line
do
    package_file=$(echo $line | awk '{print $2}')
    expected_checksum=$(echo $line | awk '{print $1}')
    if [ -f "$package_file" ]; then
        actual_checksum=$(sha256sum "$package_file" | awk '{print $1}')
        if [ "$actual_checksum" == "$expected_checksum" ]; then
            echo "Fișierul $package_file are suma de control corectă." >> $CHECKSUM_REPORT_FILE
        else
            echo "Fișierul $package_file are suma de control INCORECTA!" >> $CHECKSUM_REPORT_FILE
        fi
    else
        echo "Fișierul $package_file nu există." >> $CHECKSUM_REPORT_FILE
    fi
done

log_message "Verificare sume de control completată. Raport salvat în $CHECKSUM_REPORT_FILE la data: $CURRENT_DATE."

echo "Verificare sume de control completată. Raport salvat în $CHECKSUM_REPORT_FILE la data: $CURRENT_DATE."

