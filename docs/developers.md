# ODOO ERP - Internacionalización Costa Rica
## GUÍA PARA DESARROLLADORES - REv. 20/04/2024

### Preparación de ambiente local de desarrollo usando contenedores

#### Instalando pre-requisitos de desarrollo
$ ./bootstrap.sh

Nota: Este comando requiere privilegios de superusuario, asegurese de tener permisos de root o contacte con su administrador. Actualmente, solo para distribuciones Debian.

#### Configurando el ambiente local de desarrollo
$ ./configure.sh

Nota: Llene el formulario de configuración para el ambiente de desarrollo. Es importante y requerido realizar este paso antes de sguir con el siguiente. Este archivo es particular para cada ambiente de desarrollador, por lo que es importante que lo ejecute al momento de inicializar su ambiente de desarrollo.

#### Inicializando contenedor odoo local para desarrollo
$ ./build.sh

Nota: Se requiere para la construcción de la imagen odoo local desde donde se creará la imagen de contenedor del proyecto. En el futuro, este proceso será opcional; ya que tendremos una imagen disponible lista para descarga desde el repositorio. También, puede usarse para contruir la imagen si no tiene acceso a internet.

### Ejecutando demonios de arranque de instancia local de Odoo

#### Arranque de instancia de odoo local para desarrollo
$ ./up.sh

Nota: En este punto deberia poder ir a https://localhost:101[puerto_definido]

#### Baja ordenada de instancia de odoo local para desarrollo
$ ./down.sh

Nota: Solo debe ejecutarse si hay una instancia activa del proyecto