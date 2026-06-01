#!/bin/bash

# Nebi TEKİN
# 2420171015
# Sertifika Bağlantıları:
# 1) Docker Temelleri: Tamamlanmadı
# 2) https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=gK2hawYlqk
# 3) https://credsverse.com/credentials/ad254045-e4e6-4cf4-b1bf-f2b77e3d98e5

LOG_FILE="report.log"

echo "Rapor Başlangıç: $(date -Iseconds)" > "$LOG_FILE"

echo "İşletim Sistemi: $(uname -s)" >> "$LOG_FILE"
echo "Kullanıcı: $USER" >> "$LOG_FILE"
echo "Makine: $(uname -m)" >> "$LOG_FILE"

echo "İşlemci:" >> "$LOG_FILE"
wmic cpu get name >> "$LOG_FILE" 2>/dev/null

echo "RAM:" >> "$LOG_FILE"
wmic memorychip get capacity >> "$LOG_FILE" 2>/dev/null

echo "Anakart:" >> "$LOG_FILE"
wmic baseboard get manufacturer,product,serialnumber >> "$LOG_FILE" 2>/dev/null

echo "Disk UUID:" >> "$LOG_FILE"
wmic diskdrive get model,serialnumber >> "$LOG_FILE" 2>/dev/null

echo "MAC Adresi:" >> "$LOG_FILE"
getmac >> "$LOG_FILE" 2>/dev/null

read -s -p "Parola giriniz: " PAROLA
echo

gpg --batch --yes \
--pinentry-mode loopback \
--passphrase "$PAROLA" \
--cipher-algo AES256 \
--symmetric \
--output "${LOG_FILE}.gpg" \
"$LOG_FILE"

if [ -f "${LOG_FILE}.gpg" ]; then
rm "$LOG_FILE"
echo "Şifreleme başarılı."
else
echo "Şifreleme başarısız."
fi
