# Análisis de Punto de Venta Alesaa

**Fecha:** 24 de octubre de 2026  
**Carpeta analizada:** `/Users/pedrohernandezoregel/Documents/GitHub/web-sites/Punto De Venta Alesaa -Estable`  
**Método:** inspección estática del inventario de archivos, configuración, rutas, código PHP y JavaScript, y scripts SQL. No se ejecutó la aplicación ni se conectó a una base de datos. No se modificó el proyecto.

## 1. Resumen ejecutivo

La carpeta contiene una aplicación web de punto de venta denominada **Alesaa POS**, desarrollada en PHP y MySQL. Su alcance va más allá del cobro: integra compras, inventario, caja, clientes, proveedores, créditos, cotizaciones, apartados y órdenes de taller.

La organización sigue un patrón MVC propio: vistas y plantillas presentan la interfaz, controladores delegan operaciones y modelos consultan MySQL mediante PDO. Una parte sustancial de las reglas del negocio reside en procedimientos almacenados, vistas y disparadores SQL.

El proyecto conserva una base funcional amplia, pero presenta riesgos de seguridad, integridad de ventas y mantenimiento. El nombre «Estable» de la carpeta no demuestra que esta copia pueda instalarse o utilizarse sin correcciones. La revisión detectó componentes de respaldo faltantes y código de autenticación y acceso que requiere atención antes de un despliegue.

## 2. Tamaño y organización

El inventario incluye **3,322 archivos**, con un tamaño lógico total de aproximadamente **75 MB** (71.5 MiB). Una gran parte corresponde a librerías, fuentes, ejemplos y recursos gráficos; el volumen total no equivale al tamaño del código propio.

| Ubicación | Contenido | Archivos |
| --- | --- | ---: |
| `index.php` | Entrada, selección de vista y carga de plantilla | 1 |
| `config/` | Rutas, conexión indirecta con la aplicación, utilidades monetarias, fechas y cifrado | 4 |
| `controller/` | Controladores de los módulos | 24 |
| `model/` | Modelos y clase de conexión PDO | 25 |
| `view/` | Pantallas del sistema | 40 |
| `layout/` | Plantillas de acceso, inicio, POS, interfaz general y error | 5 |
| `includes/` | Menú, pie y encabezado de tickets | 3 |
| `web/` | Recursos visuales, JavaScript y endpoints AJAX | 2,591 |
| `reportes/` | Reportes, tickets y librerías PDF | 589 |
| `src/` | Librería de impresión ESC/POS de Mike42 | 31 |
| `base de datos con rfc/` | Cinco scripts de definición e inicialización SQL | 5 |
| `nbproject/` | Metadatos de proyecto de NetBeans | 4 |

Dentro de `web/` hay **72 archivos PHP en `ajax/`** y **40 archivos JavaScript en `custom-js/`**. En la raíz de `reportes/` hay **93 archivos PHP**, incluidos reportes y clases auxiliares.

## 3. Funcionalidades identificadas

Las funciones siguientes se identificaron en rutas, pantallas, controladores, modelos y SQL; su presencia no implica que hayan sido probadas en ejecución.

| Área | Funciones observadas |
| --- | --- |
| Ventas | Búsqueda por código o nombre, detalle de productos, precios de venta y mayoreo, descuentos, impuestos, cobro, cambio, anulaciones y tickets. |
| Formas de pago | Efectivo, tarjeta y combinación de ambos; ventas pagadas o a crédito. |
| Inventario | Productos, categorías, marcas, presentaciones, existencias mínimas, apertura de inventario, entradas, salidas y kardex. |
| Perecederos | Registro y consulta de vencimientos, con lógica SQL para retirar productos vencidos. |
| Compras | Proveedores, registro de compras, consultas por fecha y mes, e historial de precios. |
| Caja | Operaciones de caja, historial y reportes de corte Z diario y mensual. |
| Clientes y crédito | Clientes, límites de crédito, créditos y abonos. |
| Cotizaciones | Captura, listado y generación de documento de cotización. |
| Apartados | Captura, abonos y consultas de apartados vigentes, finalizados y anulados. |
| Taller | Técnicos, órdenes de servicio y documentos de taller. |
| Administración | Empleados, usuarios, tipos de comprobante, tirajes, parámetros de empresa y monedas. |
| Reportes | Ventas, compras, inventario, clientes, proveedores, precios, apartados, créditos y tickets. |

La configuración incluye RFC, régimen fiscal, IVA, retenciones y monedas MXN/USD. Estos campos no demuestran por sí mismos una integración de timbrado o emisión de CFDI; esa capacidad no quedó acreditada en esta revisión.

## 4. Arquitectura y tecnologías

El flujo observado es:

1. `index.php` consulta la sesión y el parámetro `View`.
2. `config/app.conf.php` traduce la vista solicitada a un archivo y una plantilla.
3. La interfaz carga scripts de `web/custom-js/` que llaman a archivos de `web/ajax/`.
4. Los endpoints invocan controladores y modelos.
5. Los modelos abren conexiones PDO y ejecutan operaciones SQL, principalmente mediante `CALL` a procedimientos almacenados.
6. Los reportes consultan modelos y generan documentos PDF.

Se incluyen **jQuery 2.1.4**, **Bootstrap 3.3.7**, DataTables, Select2 y utilidades de validación e interfaz. Los PDF utilizan FPDF y TCPDF; también hay código de barras y una librería ESC/POS. La presencia de esta última no confirma una impresora configurada o un flujo de impresión física probado.

No se encontró un manifiesto de dependencias de la aplicación en la raíz ni una guía de instalación propia. Los manifiestos o documentos incluidos dentro de librerías corresponden a esos componentes, no a la aplicación completa.

## 5. Base de datos

| Script | Definiciones identificadas |
| --- | --- |
| `1.-BD_POS.sql` | 32 tablas |
| `2.-SP.sql` | 168 procedimientos almacenados |
| `3.-VW.sql` | 18 vistas |
| `4.-TG.sql` | 10 disparadores |
| `5.-IMPLEMENTACION.sql` | 3 eventos programados y datos iniciales |

Las tablas cubren productos, compras y detalles, ventas y detalles, inventario, movimientos de caja, clientes, proveedores, usuarios, créditos, abonos, cotizaciones, apartados y taller.

Los eventos programados llaman a rutinas de cierre de inventario, retiro de vencidos y devolución de productos apartados. Su funcionamiento depende de la configuración y los permisos del servidor MySQL. Además, `sp_login_usuario` llama a esas rutinas de mantenimiento después de consultar el usuario, por lo que el acceso al sistema también puede desencadenar cambios operativos.

Los scripts constituyen material de creación e inicialización. No acreditan contener los datos actuales de un negocio. Tampoco se validó una importación completa ni la compatibilidad de todos los objetos entre sí.

## 6. Hallazgos principales

### Prioridad alta: secretos y contraseñas

- `model/Conexion.php` contiene credenciales de base de datos en texto legible, incluidas configuraciones activa y comentada. No se reproducen en este informe.
- `5.-IMPLEMENTACION.sql` crea un usuario administrador con contraseña fija.
- `sp_login_usuario`, en `2.-SP.sql`, compara directamente la contraseña recibida con el campo almacenado; `model/Login_model.php` vuelve a compararla. El endpoint `web/ajax/ajxlogin.php` decodifica Base64, que es una codificación reversible y no protege el almacenamiento de contraseñas.

**Acción propuesta:** sustituir las credenciales incrustadas por configuración externa, cambiar las que hayan sido utilizadas y migrar las contraseñas a hashes con verificación del lado del servidor.

### Prioridad alta: control de acceso en endpoints

`index.php` verifica la existencia de una sesión para presentar las pantallas. Sin embargo, `web/ajax/ajxcategoria.php` permite dirigir operaciones de registro y edición sin una verificación explícita de sesión o rol en ese archivo ni en el modelo revisado. Otros endpoints consultados tampoco muestran una capa común de autorización y protección CSRF.

**Implicación:** proteger la navegación no basta para proteger llamadas directas a los archivos AJAX. La exposición efectiva depende de controles externos del servidor que no se revisaron.

**Acción propuesta:** aplicar autenticación, permisos por operación y validación de solicitudes en todos los endpoints y reportes.

### Prioridad alta: asociación de detalles de venta

En `2.-SP.sql`, el procedimiento `sp_insert_detalleventa` obtiene la venta mediante `SELECT MAX(idventa) FROM venta`. A su vez, `web/ajax/ajxventa.php` crea la cabecera y después inserta cada detalle por separado.

**Implicación:** dos ventas simultáneas podrían asociar productos a la cabecera equivocada. Es un riesgo deducido del código, sin reproducción mediante una prueba concurrente.

**Acción propuesta:** pasar el identificador explícito de la venta a cada detalle y agrupar la operación completa en una transacción. Verificar también stock, importes y recuperación ante fallos parciales.

### Prioridad media: importes recibidos del navegador

`web/ajax/ajxventa.php` recibe por POST totales, impuestos, descuentos, precios e importes de detalle. La revisión no acreditó una validación integral y un recálculo independiente de todos esos valores en el servidor.

**Acción propuesta:** verificar reglas de precios y descuentos y recalcular importes antes de confirmar una operación.

### Prioridad media: funciones incompletas o inconsistentes

- `view/respaldos.vw.php` enlaza a `backup/descargar.php`, pero esa carpeta y archivo no están en la copia revisada.
- La ruta `Do-Backup` de `config/app.conf.php` referencia `view/makebu.vw.php`, que no existe.
- `model/Login_model.php` invoca `sp_reset_password_usuario`, cuya definición no se encontró en los cinco scripts SQL. No se confirmó que esa función sea accesible desde la interfaz.
- `layout/pos.lyt.php` carga dos veces jQuery.

**Acción propuesta:** completar o retirar rutas incompletas y comprobar restauración de respaldos en un entorno aislado.

### Prioridad media: mantenimiento y compatibilidad

Se utiliza la función de autocarga `__autoload` en el acceso principal, endpoints y reportes. Además, `config/encrypter.php` depende de funciones `mcrypt_*` y de una clave fija. Son puntos concretos que requieren revisión al seleccionar el entorno PHP; no se verificó que la utilidad de cifrado se use en los flujos activos.

No se identificó una suite de pruebas propia ni automatización de validación de la aplicación. Los ejemplos y pruebas de librerías incluidas no equivalen a pruebas del negocio.

**Acción propuesta:** documentar dependencias y entorno, revisar la autocarga y el cifrado, y añadir pruebas de los flujos críticos.

## 7. Ruta sugerida para continuar

1. **Conservar una copia e inventariar el entorno original:** versión de PHP/MySQL, servidor, extensiones, impresoras y base de datos utilizada.
2. **Preparar una instalación aislada:** configurar credenciales propias y comprobar la creación de tablas, rutinas, vistas, disparadores y eventos. No ejecutar los scripts sobre una base existente sin revisar sus efectos.
3. **Resolver riesgos principales:** contraseñas, autorización de endpoints, integridad concurrente de ventas y validación de importes.
4. **Completar funciones faltantes:** respaldo y restauración, rutas incompletas y procedimiento de recuperación de contraseña si se necesita.
5. **Validar procesos completos:** venta en efectivo y tarjeta, compra, devolución o anulación, caja, crédito y abono, apartado, vencimientos y taller. Incluir ventas simultáneas y fallos a mitad de una operación.
6. **Preparar documentación operativa:** instalación, usuarios y permisos, mantenimiento de eventos, impresión y recuperación de datos.

## 8. Alcance y límites

Este documento describe el contenido y los riesgos observables de la copia local. No certifica su funcionamiento, seguridad completa, exactitud contable, compatibilidad de ejecución o cumplimiento fiscal. No se probaron conexiones, credenciales, impresoras, respaldos ni servicios externos. Los hallazgos distinguen hechos visibles en archivos de riesgos inferidos que requieren pruebas adicionales.
