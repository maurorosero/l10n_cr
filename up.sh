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
echo "Odoo Developers Instance Startup"
echo "==========================================" 
GID=$(id -g)
export UID
export GID=$(id -g)
export ODOO_GID=$(id -g)
export POSTGRES_GID=$(id -g)
source ./config/.env.dev
if [[ ! -f "${POSTGRES_PATH}" ]]
then
   mkdir -p "${POSTGRES_PATH}"
fi

if [[ ! -f "${POSTGRES_INIT}" ]]
then
   mkdir -p "${POSTGRES_INIT}" 
fi

if [[ ! -f "${ODOO_DATA}" ]]
then
   mkdir -p "${ODOO_DATA}"
fi

if [[ ! -f "${ODOO_BACKUPS}" ]]
then
   mkdir -p "${ODOO_BACKUPS}"
fi

docker-compose --env-file ./config/.env.dev up -d
