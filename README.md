securitate-linux

# 17.06.2024
# ziua 1: Documentare , si structurarea proiectului
Script pentru detecția riscurilor de securitate într-un sistem linux:
Verificare executabile, permisiuni
Verificare procese
Verificare versiuni pachete, verificare sume de control
Realizare raport de securitate
Verificare fisiere sensibile(ex:/etc/passwd )

# 18.06.2024
# ziua 2: Stabilirea structurii
## 1 scripts/
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
## 2 config/
        -config.txt
## 3 main.sh

# 19.06.2024
#  ziua 3:
terminarea scriptului pentru verificarea proceselor si structurarea acestuia intr-un raport separat(process_report.txt) si notificarea in log.t

# 20.06.2024
# ziua 4:
  realizarea scriptului pentru a genera sumele de control(generate_checksum.sh) care se va putea rula doar pe baza de parola (parola locala, nivel de securitate scazut) in fisierul checksums_list.txt

# 21.06.2024
# ziua 5: 
  terminarea scriptului pentru verificarea sumelor de control pe baza fisierului (checksums_list.txt) si generarea raportului (checksum_report.txt)
  terminarea scriptului pentru verificarea permisiunilor (directoarelor date in config.txt)
  
# 25.06.2024 - 26.06.2024
# ziua 6-7
  terminarea scriptului pentru verificarea fisierelor sensibile, preloate tot din fisierul config.txt (check_sensitive_files.sh) si generarea raportului in sensitive_file_report.txt
  gerarea tuturor rapoartelor int-un director numit reports
  realizarea scriptului principal (main.sh ) sub forma unui meniu , unde poti selecta raportul pe care vrei sa-l generezi si vei primi notificare cu actiunea efectuata , actiune care este si ea notata in log.txt
  meniul ruleaza pana cand optiunea de iesire este selectata
