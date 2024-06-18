securitate-linux

17.06.2024
ziua 1: Documentare , si structurarea proiectului
Script pentru detecția riscurilor de securitate într-un sistem linux:
Verificare executabile, permisiuni
Verificare procese
Verificare versiuni pachete, verificare sume de control
Realizare raport de securitate
Sistem logger
Verificare fisiere sensibile(ex:/etc/passwd )

18.06.2024
ziua 2: Stabilirea structurii
1 scripts/
  check_executables_permissions.sh
     verific executabilele din directoarele aflate in fisierul config.txt
  check_processes.sh
  check_package_versions.sh
  check_file_checksums.sh
  generate_report.sh
2 config/
 config.txt
3 main.sh

