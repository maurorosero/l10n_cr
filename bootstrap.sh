#!/bin/bash
#bootstrap.sh
#
# Derechos de Autor (C) [2024] [Mauro Rosero P. <mauro@roser.one>]
#
# Este programa es software libre: usted puede redistribuirlo y/o modificarlo
# bajo los términos de la Licencia Pública Affero General de GNU tal como
# lo publica la Free Software Foundation, ya sea la versión 3 de la licencia,
# o (a su elección) cualquier versión posterior.
#
# Este programa se distribuye con la esperanza de que sea útil,
# pero SIN NINGUNA GARANTÍA; sin siquiera la garantía implícita de
# COMERCIABILIDAD o IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Consulte la
# Licencia Pública Affero General de GNU para obtener más detalles.
#
# Debería haber recibido una copia de la Licencia Pública Affero General
# junto con este programa. Si no la recibió, consulte <https://www.gnu.org/licenses/>.

install() {
	local install_home=$1

	# Load bootstrap messages
	if [ -f "${install_home}/bin/msg/bootstrap.$LANG" ]
	then
		source "${install_home}/bin/msg/bootstrap.$LANG"
	else
		source "${install_home}/bin/msg/bootstrap.es"
	fi

	# Load Python & Ansible Installer Functions
	source "${install_home}/bin/lib/bootstrap.lib"

	# Instalar o actualizar Python a la última versión
	install_or_update_python

	# Verificar distribución y ejecutar la función correspondiente para instalar Ansible
	if [ -f /etc/debian_version ] || [ -f /etc/os-release ]; then
		install_ansible_debian
	elif [ -f /etc/redhat-release ]; then
		install_ansible_redhat
	elif [ "$(uname)" == "Darwin" ]; then
		install_ansible_macos
	elif [ -f /etc/arch-release ]; then
		install_ansible_arch
	elif [ -f /etc/rc.conf ]; then
		install_ansible_bsd
	else
		echo "${pymsg_014}"
		exit 1
	fi
}

# Main.- Llamar a la función con sudo
clear

# Load head messages
if [ -f "${HOME}/bin/msg/head.$LANG" ]
then
	source "${HOME}/bin/msg/head.$LANG"
else
	source "${HOME}/bin/msg/head.es"
fi

echo "${head_000}"
echo "------------------------------------------------------------------------------"
sudo bash -c "$(declare -f install); install ${PWD}"
