#!/bin/bash

# Funcție pentru afișarea meniului
display_menu() {
    echo "Meniu:"
    echo "1. Verificare sume de control pentru fișiere"
    echo "2. Verificare fișiere sensibile"
    echo "3. Verificare permisiuni"
    echo "4. Verificare procese"
    echo "5. Generare sume de control"
    echo "6. Ieșire"
    echo ""
    echo -n "Selectați o opțiune: "
}

# Funcție pentru a trimite notificare
send_notification() {

    local option_name=$1
    local message="Opțiunea \"$option_name\" a fost selectată și procesată."
	
    notify-send "Meniu Linux Security" "$1"
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
    display_menu

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
            echo "Ieșire din meniu. La revedere!"
            exit 0
            ;;
        *)
            echo "Opțiune invalidă. Vă rugăm să introduceți o opțiune validă."
            ;;
    esac

    echo ""  # Linie goală pentru claritate
done

