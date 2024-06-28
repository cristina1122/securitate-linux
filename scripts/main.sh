#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
RESET='\033[0m'

# Funcție pentru a afișa meniul
show_menu() {
    echo -e "${GREEN}1) Verificare sume de control${RESET}"
    echo -e "${YELLOW}2) Verificare fișiere sensibile${RESET}"
    echo -e "${BLUE}3) Verificare permisiuni${RESET}"
    echo -e "${MAGENTA}4) Verificare procese${RESET}"
    echo -e "${CYAN}5) Generare sume de control${RESET}"
    echo -e "${RED}6) Verificare logurilor${RESET}"
    echo -e "${WHITE}7) Ieșire din meniu${RESET}"
    echo ""
    echo -n "Selectați o opțiune: "
}

# Funcție pentru a trimite notificare
send_notification() {
    local option_name=$1
    local message="Opțiunea \"$option_name\" a fost selectată și procesată."
    notify-send "Meniu Linux Security" "$message"
}

# Funcție pentru verificarea parolei
check_password() {
    local password="parola"  # Setează parola dorită

    echo -n "Introduceți parola pentru a continua: "
    read -s user_input  # Citește parola introdusă de utilizator fără a o afișa

    echo ""  # Linie goală pentru claritate în output

    if [[ "$user_input" != "$password" ]]; then
        echo "Parolă incorectă. Acțiunea necesită parola corectă." >&2
        return 1
    fi
}

# Loop pentru meniu
while true; do
    show_menu  # Afișează meniul corect

    # Citirea opțiunii utilizatorului
    read option

    case $option in
        1)
            send_notification "verificare sume de control"
            echo "Începe verificarea sumelor de control..."
            ./check_file_checksums.sh
            ;;
        2)
            send_notification "Verificare fișiere sensibile"
            echo "Începe verificarea fișierelor sensibile..."
            ./check_sensitive_files.sh
            ;;
        3)
            send_notification "Verificare permisiuni"
            echo "Începe verificarea permisiunilor..."
            ./check_permission.sh
            ;;
        4)
            send_notification "Verificare procese"
            echo "Începe verificarea proceselor..."
            ./check_process.sh
            ;;
        5)
            # Cerere pentru parolă la opțiunea 5 (Generare sume de control)
            if ! check_password; then
                continue  # Continuă bucla dacă parola nu este corectă
            fi
            send_notification "Generare sume de control"
            echo "Parolă corectă. Începe generarea sumelor de control..."
            ./generate_checksum.sh
            ;;
        6)
            send_notification "verificare logurilor"
            echo "Verificarea logurilor"
            ./check_system_logs.sh
            ;;
        7)
            echo "Ieșire din meniu."
            exit 0
            ;;
        *)
            echo "Opțiune invalidă. Vă rugăm să introduceți o opțiune validă."
            ;;
    esac

    echo ""  # Linie goală pentru claritate
done

