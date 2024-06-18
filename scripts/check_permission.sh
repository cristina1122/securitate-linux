#!/bin/bash

# Sursa fișierului de configurare
CONFIG_FILE="../config/config.txt"

# Funcție pentru citirea valorilor din fișierul de configurare
get_config_value() {
    grep "^$1=" "$CONFIG_FILE" | cut -d '=' -f2
}

# Citirea valorilor din fișierul de configurare
LOG_FILE=$(get_config_value "LOG_FILE")
DIRECTORIES=$(get_config_value "DIRECTORIES")

echo "Verific permisiunile executabilelor..." | tee -a "$LOG_FILE"

# Transformăm șirul de directoare într-un array
IFS=' ' read -r -a directories_array <<< "$DIRECTORIES"

# Parcurgem fiecare director în lista DIRECTORIES
for dir in "${directories_array[@]}"; do
    echo "Verificare în directorul: $dir" | tee -a "$LOG_FILE"
    # Verificăm recursiv fișierele executabile în directorul curent
    while IFS= read -r -d '' file; do
        if [ -x "$file" ]; then
            perms=$(stat -c "%a" "$file")
            owner=$(stat -c "%U" "$file")
            group=$(stat -c "%G" "$file")
            echo "$file: Permisiuni $perms, Proprietar $owner, Grup $group" | tee -a "$LOG_FILE"
        fi
    done < <(find "$dir" -type f -executable -print0 2>/dev/null)
done
