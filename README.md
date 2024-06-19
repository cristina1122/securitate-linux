securitate-linux

##17.06.2024
##ziua 1: Documentare , si structurarea proiectului
Script pentru detecția riscurilor de securitate într-un sistem linux:
Verificare executabile, permisiuni
Verificare procese
Verificare versiuni pachete, verificare sume de control
Realizare raport de securitate
Sistem logger
Verificare fisiere sensibile(ex:/etc/passwd )

##18.06.2024
##ziua 2: Stabilirea structurii
#1 scripts/
  check_executables_permissions.sh
          -verific executabilele din directoarele -aflate in fisierul config.txt
  check_processes.sh
    verific procesele (primele 20 ) la momentul actual din sisitem care:
          -procesele rulate de utilizatorul root 
          -procese filtrate dupa nume din fisierul de configurare
          -procese care folosesc resurse excesive(CPU)
          -procese care folosesc resurse excesive(Memorie)
          -Procese cu conexiuni de retea deschise 
          -Procese cu permisiuni setuid/setgid
        Aceste informatii sunt salvate in process_report.txt si crearea lor e notificata in log.txt
  check_package_versions.sh
  check_file_checksums.sh
  generate_report.sh
#2 config/
        -config.txt
#3 main.sh

##19.06.2024
##ziua 3:terminarea scriptului pentru verificarea proceselor si structurarea acestuia intr-un raport separat(process_report.txt) si notificarea in log.txt
+documentare pentru smpt folosind swaks
