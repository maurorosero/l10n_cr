#!/bin/bash
#builder.sh
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

show_message() {
  local msg = $1
  # Verificar si dialog está instalado
  if command -v dialog &> /dev/null; then
      # Usar dialog para mostrar el mensaje de error
      dialog --msgbox "${msg}" 10 30
  else
    # Usar echo para mostrar el mensaje de error en la terminal
    echo "${msg}"
  fi
}

docker_build() {
  docker build  ./build -t odoo:devs${ODOO_VERSION}
}

podman_build() {
  registry_path=~/.config/containers
  if [ ! -d ${registry_path} ]
  then
    mkdir ${registry_path}
  fi
  echo 'unqualified-search-registries = ["docker.io"]' > "${registry_path}/registries.conf"
  podman build  ./build -t odoo:devs${ODOO_VERSION}
}

build_execute() {
  source config/.env.dev
  # Verificar si Docker está instalado
  if command -v docker &> /dev/null
  then
    docker_build
  else
    # Verificar si Podman está instalado
    if command -v podman &> /dev/null
    then
      podman_build
    else
      show_message "Requiere que instale docker o podman previamente!"
      exit 1
    fi
  fi
}

clear
echo "Odoo SaaS v${ODOO_VERSION} Builder Container"
echo "============================================"
build_execute
