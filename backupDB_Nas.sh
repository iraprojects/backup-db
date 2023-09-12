#!/bin/bash
echo "Respaldo de base de datos"
NombreBD="remplazar por el nombre de la base de datos"
RutaMount="/ruta a montar"
#RECEIVER=$1 si se quieres escribir el correo
RECEIVER="correo@gmail.com"
#Respaldo
mysqldump -u admin -pasd $NombreBD > ../backupBD.sql

#montando carpeta
sudo mount -t cifs' //ip-nas/directorio' '/ruta-a-Montar' -o username=name,password=

#comprimiendo
cd /home/ruta-de-respaldo
sleep 5
sudo tar -cvf backup$(date +%d%m%y%H%M%S).tar backupBD.sql

#copiar respaldo
sudo cp /backup$(date +%d%m%y%H%M%S).tar ruta-a-Montar
#Desmontando
sudo umount -l $RutaMount

#Enviar mail de notificacion a gmail
SERVER_PORT="outlook.com:587"
SENDER="correoemisor.com"
USER="correoemisor.com"
PASSWORD=

swaks --to $RECEIVER --from $SENDER --server $SERVER_PORT --auth LOGIN --auth-user $USER --auth-password $PASSWORD -tls --data "Date: %DATE%\nTo: %TO_ADDRESS%\nFrom:%FROM_ADDRESS%\nSubject: Respaldo creado! %DATE%\nX-Mailer: swaks v$p_versionjetmore.org/john/code/swaks/\n%NEW_HEADERS%\n El respaldo ha sido generado y transferido al NAS! \n"

#Enviar notificacion via Telegram
usuario="contacto";
mensaje="El respaldo ha sido generado y transferido al NAS!";
(sleep 5;echo "msg $usuario $mensaje"; echo "safe_quit") | /snap/bin/telegram-cli -k tg-server.pub -W

