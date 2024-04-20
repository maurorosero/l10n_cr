#  restore.sh
#  
#  Mauro Rosero P. <mrosero@rosero.one>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  
source ./config/.env.dev

clear
dialog --version > /dev/null
if [[ "$?" == "0" ]]
then
   DIALOG_YES=y
fi
D_TITLE="Odoo Developers Instance Docker Restore for ${ODOO_PROJECT}"
D_Q01="Do you want backup this db (y/n)?"
D_Q02="Get archive name to restore:"

set_inputbox(){
  exec 3>&1;
  result=$(dialog --begin 2 2 --title "${D_TITLE}" --inputbox "$1" 0 -1 2>&1 1>&3);
  exitcode=$?;
  exec 3>&-;
}

if [[ "${DIALOG_YES}" != "y" ]]
then
   echo "${D_TITLE}"
   echo "==============================================================" 
   echo -e "${D_Q01} \c"
   read answer
else
   dialog --begin 2 2 --title "${D_TITLE}" --yesno "\n${D_Q01}" 6 60
   if [[ "$?" == "0" ]]
   then
      answer=y
   fi
fi
if [[ "${answer}" == "y" ]]
then
   if [[ "${DIALOG_YES}" != "y" ]]
   then
      echo -e "${D_Q02} \c"
      read BACKUP_FILE
   else
      clear
      set_inputbox "\n${D_Q02}"
      if [[ "$?" == "0" ]]
      then
         BACKUP_FILE="${result}"
      fi
   fi
   if [[ -f "${ODOO_BACKUPS}/${BACKUP_FILE}" ]]
   then
      current=${PWD}
      cd ${ODOO_DATABASE}/..
      if [[ "${ODOO_SUDO}" != "y" ]]
      then
         tar xvzpf ${ODOO_BACKUPS}/${BACKUP_FILE}
      else
         sudo tar xvzpf ${ODOO_BACKUPS}/${BACKUP_FILE}
      fi
      cd ${current}
   fi
fi
clear
