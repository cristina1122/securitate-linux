#!/bin/bash

CONFIG_FILE="../config/config.txt"

# Funcție pentru citirea valorilor din config.txt
get_config_value() {
    local key=$1
    grep "^${key}=" "$CONFIG_FILE" | cut -d '=' -f2- | tr -d '"'
}

# Extrage valorile necesare din config.txt
PROCESS_REPORT_FILE=$(get_config_value "PROCESS_REPORT_FILE")
LOG_FILE=$(get_config_value "LOG_FILE")
KNOWN_PROCESS_NAMES=$(get_config_value "KNOWN_PROCESS_NAMES")

# Scrie în fișierul de log și afișează în terminal
log_message() {
    local message=$1
    echo "*********************************************************************" | tee -a $LOG_FILE
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" | tee -a $LOG_FILE
}

# Începe logarea și verificările de procese
log_message "Începerea verificării proceselor."
echo "*****************************************************************************" >> $PROCESS_REPORT_FILE
echo "Verificare procese curente din punct de vedere al securității: $(date +'%Y-%m-%d %H:%M:%S')" >> $PROCESS_REPORT_FILE

# Verifică procesele rulate de utilizatorul root
echo "*****************************************************************************" >> $PROCESS_REPORT_FILE
echo "Procese rulate de utilizatorul root:" >> $PROCESS_REPORT_FILE
ps aux | awk '$1 == "root"' | head -n 20 >> $PROCESS_REPORT_FILE
echo "" >> $PROCESS_REPORT_FILE

# Verifică procesele necunoscute sau suspicioase
echo "*****************************************************************************" >> $PROCESS_REPORT_FILE
echo "Procese suspicioase (filtrare după nume necunoscute):" >> $PROCESS_REPORT_FILE
ps aux | grep -v -E "root|USER|$KNOWN_PROCESS_NAMES" | head -n 20 >> $PROCESS_REPORT_FILE
echo "" >> $PROCESS_REPORT_FILE

# Verifică procesele care folosesc resurse excesive
echo "*****************************************************************************" >> $PROCESS_REPORT_FILE
echo "Procese care folosesc resurse excesive (CPU):" >> $PROCESS_REPORT_FILE
ps aux --sort=-%cpu | head -n 20 >> $PROCESS_REPORT_FILE
echo "" >> $PROCESS_REPORT_FILE

echo "*****************************************************************************" >> $PROCESS_REPORT_FILE
echo "Procese care folosesc resurse excesive (Memorie):" >> $PROCESS_REPORT_FILE
ps aux --sort=-%mem | head -n 20 >> $PROCESS_REPORT_FILE
echo "" >> $PROCESS_REPORT_FILE

# Verifică procesele care au deschise conexiuni de rețea
echo "*****************************************************************************" >> $PROCESS_REPORT_FILE
echo "Procese cu conexiuni de rețea deschise:" >> $PROCESS_REPORT_FILE
lsof -i -P -n | grep ESTABLISHED | head -n 20 >> $PROCESS_REPORT_FILE
echo "" >> $PROCESS_REPORT_FILE

# Verifică procesele cu permisiuni setuid/setgid
echo "*****************************************************************************" >> $PROCESS_REPORT_FILE
echo "Procese cu permisiuni setuid/setgid:" >> $PROCESS_REPORT_FILE
find / -perm /6000 2>/dev/null | head -n 20 >> $PROCESS_REPORT_FILE
echo "" >> $PROCESS_REPORT_FILE

log_message "Verificare procese completată. Raport salvat în $PROCESS_REPORT_FILE."

#echo "Verificare procese completată. Raport salvat în $PROCESS_REPORT_FILE."

