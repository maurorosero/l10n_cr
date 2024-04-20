#  backup.sh
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
D_TITLE="Odoo Developers Instance Docker Backup for ${ODOO_PROJECT}"
D_Q01="Do you want backup this db (y/n)?"
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
   clear
   BACKUP_FILE=dbk_${ODOO_PROJECT}_$(date +%Y-%m-%d_%H-%M-%S%z).tgz
   if [[ "${ODOO_SUDO}" != "y" ]]
   then
      tar cvzpf ${ODOO_BACKUPS}/${BACKUP_FILE} ${ODOO_DATABASE}
   else
      sudo tar cvzpf ${ODOO_BACKUPS}/${BACKUP_FILE} ${ODOO_DATABASE}
   fi
fi
clear
