#  up.sh
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

display_header() {
  clear
  echo "$(cat < ./config/project.head) Startup"
  echo "=========================================="
}

devs_config='./config/.env.dev'
if [ -f ${devs_config} ]
then
  source ${devs_config}
else
  display_header
  echo "Requiere ejecutar ./configure primero, previo a iniciar la instancia!"
  exit 9
fi

source ./bin/lib/containers.lib
source ./bin/lib/odoo.lib

# MAIN PROGRAM
display_header
odoo_structure
start_instance "${devs_config}"
