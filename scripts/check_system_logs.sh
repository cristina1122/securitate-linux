#!/bin/bash

# Definirea fișierului de raport
output_file="reports/system_logs_report.txt"

# Verificare existența directorului de rapoarte și permisiunilor
if [ ! -d "../reports" ]; then
  echo "Directorul ../reports nu există. Crearea directorului..."
  mkdir -p ../reports
fi

# Verificare permisiuni de scriere în directorul de rapoarte
if [ ! -w "../reports" ]; then
  echo "Nu am permisiuni de scriere în directorul ../reports."
  exit 1
fi

 echo "Verificare loguri de sistem - $(date)"
# Creare și inițializare fișier de raport, mereu sterge continutul initial al raportului
echo "Verificare loguri de sistem - $(date)" > $output_file

# Filtrare mesaje de eroare din syslog
echo "Erori în syslog:" >> $output_file
grep -i "error" /var/log/syslog >> $output_file

# Filtrare mesaje de autentificare eșuată
echo "Autentificări eșuate în auth.log:" >> $output_file
grep -i "failed" /var/log/auth.log >> $output_file

# Filtrare mesaje de eroare din buffer-ul kernelului cu sudo
echo "Erori din buffer-ul kernelului:" >> $output_file
sudo dmesg | grep -i "error" >> $output_file

echo "Raport generat în $output_file"
