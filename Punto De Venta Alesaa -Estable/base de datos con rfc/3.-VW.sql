-- Vistas

DROP VIEW IF EXISTS view_productos;
CREATE VIEW view_productos
AS
SELECT producto.idproducto,codigo_interno,codigo_barra,nombre_producto,precio_compra,
precio_venta,precio_venta_mayoreo,stock,stock_min,producto.idcategoria,nombre_categoria,producto.idmarca,nombre_marca,
producto.idpresentacion,nombre_presentacion,siglas,producto.estado,exento,inventariable,perecedero
FROM producto
INNER JOIN categoria ON producto.idcategoria = categoria.idcategoria
INNER JOIN presentacion ON producto.idpresentacion = presentacion.idpresentacion
LEFT JOIN marca ON producto.idmarca = marca.idmarca
GROUP BY producto.idproducto;




DROP VIEW IF EXISTS view_usuarios;
CREATE VIEW view_usuarios
AS
SELECT idusuario, usuario, contrasena, tipo_usuario, usuario.estado, usuario.idempleado,
nombre_empleado,apellido_empleado FROM usuario 
INNER JOIN empleado ON usuario.idempleado = empleado.idempleado;





DROP VIEW IF EXISTS view_comprobantes;
CREATE VIEW view_comprobantes
AS
SELECT comprobante.idcomprobante, nombre_comprobante,estado,idtiraje,
fecha_resolucion,serie,numero_resolucion,desde,hasta,disponibles,(hasta - disponibles) as usados 
FROM comprobante INNER JOIN tiraje_comprobante 
ON comprobante.idcomprobante = tiraje_comprobante.idcomprobante;





DROP VIEW IF EXISTS view_perecederos;
CREATE VIEW view_perecederos
AS
SELECT perecedero.idproducto,codigo_interno,codigo_barra,nombre_producto,nombre_marca,siglas,
fecha_vencimiento,cantidad_perecedero,perecedero.estado as estado_perecedero,
if(curdate() < perecedero.fecha_vencimiento, 'NO', 'SI') as vencido
FROM perecedero
INNER JOIN producto ON perecedero.idproducto = producto.idproducto
INNER JOIN presentacion ON producto.idpresentacion = presentacion.idpresentacion
LEFT JOIN marca ON producto.idmarca = marca.idmarca;







DROP VIEW IF EXISTS view_caja;
CREATE VIEW view_caja
AS
SELECT caja.idcaja, fecha_apertura,monto_apertura,monto_cierre,fecha_cierre,estado,
tipo_movimiento, monto_movimiento,descripcion_movimiento FROM caja
INNER JOIN caja_movimiento ON caja.idcaja = caja_movimiento.idcaja;





DROP VIEW IF EXISTS view_full_entradas;
CREATE VIEW view_full_entradas
AS
SELECT entrada.idproducto,codigo_interno,codigo_barra,
nombre_producto,nombre_marca,siglas, fecha_entrada,descripcion_entrada,cantidad_entrada,
precio_unitario_entrada,costo_total_entrada FROM entrada INNER JOIN view_productos
ON entrada.idproducto = view_productos.idproducto;
 
 
 
 
 
DROP VIEW IF EXISTS view_full_salidas;
CREATE VIEW view_full_salidas
AS
SELECT salida.idproducto,codigo_interno,codigo_barra,
nombre_producto,nombre_marca,siglas, fecha_salida,descripcion_salida,cantidad_salida,
precio_unitario_salida,costo_total_salida FROM salida INNER JOIN view_productos
ON salida.idproducto = view_productos.idproducto;




DROP VIEW IF EXISTS view_kardex;
CREATE VIEW view_kardex
AS
SELECT inventario.idproducto,CONCAT(nombre_producto,'  ',siglas) as producto,nombre_marca,saldo_inicial,
if(entradas is null, 0.00, entradas) as entradas,if(salidas is null, 0.00, salidas) as salidas,
saldo_final,mes_inventario FROM inventario
INNER JOIN view_productos ON inventario.idproducto = view_productos.idproducto
GROUP BY inventario.idproducto, mes_inventario;





DROP VIEW IF EXISTS view_compras;
CREATE VIEW view_compras
AS
SELECT compra.idcompra,fecha_compra,compra.idproveedor,nombre_proveedor,clave_rfc,tipo_pago,tipo_comprobante,
numero_comprobante, fecha_comprobante,detallecompra.idproducto,fecha_vence,codigo_barra,codigo_interno,
nombre_producto,nombre_marca,siglas,cantidad,precio_unitario,detallecompra.exento,
importe,sumas,iva,compra.exento as total_exento,retenido,total,sonletras,
compra.estado as estado_compra FROM compra 
INNER JOIN detallecompra ON  compra.idcompra = detallecompra.idcompra
INNER JOIN proveedor ON proveedor.idproveedor = compra.idproveedor
INNER JOIN producto ON detallecompra.idproducto = producto.idproducto
INNER JOIN presentacion ON producto.idpresentacion = presentacion.idpresentacion
LEFT JOIN marca ON producto.idmarca = marca.idmarca;




DROP VIEW IF EXISTS view_historico_precios;
CREATE VIEW view_historico_precios
AS
SELECT proveedor_precio.idproducto,codigo_interno,codigo_barra,nombre_producto,
nombre_marca,siglas,proveedor_precio.idproveedor,nombre_proveedor,
fecha_precio,proveedor_precio.precio_compra as precio_comprado
FROM proveedor_precio
INNER JOIN view_productos ON proveedor_precio.idproducto = view_productos.idproducto
INNER JOIN proveedor ON proveedor_precio.idproveedor = proveedor.idproveedor;




DROP VIEW IF EXISTS view_ventas;
CREATE VIEW view_ventas
AS
SELECT venta.idventa,numero_venta,fecha_venta,tipo_pago,numero_comprobante,tipo_comprobante,
pago_efectivo,pago_tarjeta,numero_tarjeta,tarjeta_habiente,cambio,
sumas,iva,venta.exento as total_exento,retenido,venta.descuento as total_descuento,total,sonletras, 
venta.estado as estado_venta,venta.idcliente as idcliente,
nombre_cliente as cliente, detalleventa.idproducto,codigo_barra,codigo_interno,nombre_producto,
nombre_marca,siglas,view_productos.exento as producto_exento, perecedero, fecha_vence,
cantidad,precio_unitario,precio_compra,detalleventa.exento as exento, detalleventa.descuento as descuento,
importe,CONCAT(nombre_empleado,' ',apellido_empleado) as empleado
FROM venta 
INNER JOIN detalleventa ON detalleventa.idventa = venta.idventa
INNER JOIN view_productos ON detalleventa.idproducto = view_productos.idproducto
INNER JOIN view_usuarios ON view_usuarios.idusuario = venta.idusuario
LEFT JOIN cliente ON venta.idcliente = cliente.idcliente;



DROP VIEW IF EXISTS view_productos_venta;
CREATE VIEW view_productos_venta
AS
SELECT view_productos.idproducto,codigo_interno,codigo_barra,nombre_producto,siglas,nombre_marca,
precio_venta,precio_venta_mayoreo,stock,exento,perecedero,inventariable FROM view_productos
WHERE stock > 0.00 AND precio_venta > 0.00 AND view_productos.estado = 1
AND inventariable = 1 OR inventariable = 0
GROUP BY view_productos.idproducto;



DROP VIEW IF EXISTS view_productos_apartado;
CREATE VIEW view_productos_apartado
AS
SELECT view_productos.idproducto,codigo_interno,codigo_barra,nombre_producto,siglas,nombre_marca,
precio_venta,precio_venta_mayoreo,stock,exento,perecedero FROM view_productos
WHERE stock > 0.00 AND precio_venta > 0.00 AND view_productos.estado = 1 AND perecedero = 0
AND inventariable = 1
GROUP BY view_productos.idproducto;



DROP VIEW IF EXISTS view_creditos_venta;
CREATE VIEW view_creditos_venta
AS
SELECT idcredito, codigo_credito, credito.idventa, numero_venta, nombre_credito, fecha_credito, monto_credito,
monto_abonado,monto_restante,credito.estado as estado_credito, codigo_cliente, 
nombre_cliente as cliente, limite_credito 
FROM credito
INNER JOIN venta ON credito.idventa = venta.idventa
INNER JOIN cliente ON credito.idcliente = cliente.idcliente;




DROP VIEW IF EXISTS view_abonos;
CREATE VIEW view_abonos
AS
SELECT view_creditos_venta.idcredito, codigo_credito, nombre_credito, idabono, 
fecha_abono,monto_abono,restante_credito,total_abonado, abono.idusuario,
usuario FROM abono INNER JOIN view_creditos_venta ON view_creditos_venta.idcredito = abono.idcredito
INNER JOIN view_usuarios ON abono.idusuario = view_usuarios.idusuario;




DROP VIEW IF EXISTS view_cotizaciones;
CREATE VIEW view_cotizaciones
AS
SELECT cotizacion.idcotizacion, numero_cotizacion,fecha_cotizacion,
a_nombre,nombre_cliente,clave_rfc,direccion_cliente,numero_telefono,email,
tipo_pago,entrega, detallecotizacion.idproducto,codigo_barra,codigo_interno,
nombre_producto,nombre_marca,siglas,stock,cantidad,disponible,precio_unitario,detallecotizacion.exento,
detallecotizacion.descuento,importe,sumas,iva,cotizacion.exento as total_exento,retenido, cotizacion.descuento as total_descuento,
total,sonletras, CONCAT(nombre_empleado,' ',apellido_empleado) as empleado
FROM cotizacion
INNER JOIN detallecotizacion ON cotizacion.idcotizacion = detallecotizacion.idcotizacion
INNER JOIN producto ON detallecotizacion.idproducto = producto.idproducto
INNER JOIN presentacion ON producto.idpresentacion = presentacion.idpresentacion
LEFT JOIN marca ON producto.idmarca = marca.idmarca
INNER JOIN view_usuarios ON cotizacion.idusuario = view_usuarios.idusuario
INNER JOIN cliente ON cotizacion.idcliente = cliente.idcliente;


DROP VIEW IF EXISTS view_taller;
CREATE VIEW view_taller
AS
SELECT idorden, numero_orden, fecha_ingreso, aparato, modelo, 
serie, averia, observaciones, deposito_revision, deposito_reparacion, 
diagnostico, estado_aparato, repuestos, mano_obra, fecha_alta, fecha_retiro, ubicacion, parcial_pagar,
ordentaller.idcliente, nombre_cliente, clave_rfc, numero_telefono, ordentaller.idtecnico, tecnico,
ordentaller.idmarca, nombre_marca
FROM ordentaller 
INNER JOIN cliente ON ordentaller.idcliente = cliente.idcliente
INNER JOIN marca ON ordentaller.idmarca = marca.idmarca
INNER JOIN tecnico ON ordentaller.idtecnico = tecnico.idtecnico;


DROP VIEW IF EXISTS view_apartados;
CREATE VIEW view_apartados
AS
SELECT apartado.idapartado,numero_apartado,fecha_apartado,fecha_limite_retiro,
sumas,iva,apartado.exento as total_exento,retenido,apartado.descuento as total_descuento,total,sonletras, 
apartado.estado as estado_apartado,apartado.idcliente as idcliente,
nombre_cliente as cliente, detalleapartado.idproducto,codigo_barra,codigo_interno,nombre_producto,
nombre_marca,siglas,view_productos.exento as producto_exento, perecedero, fecha_vence,
cantidad,precio_unitario,precio_compra,detalleapartado.exento as exento, detalleapartado.descuento as descuento,
importe,CONCAT(nombre_empleado,' ',apellido_empleado) as empleado, abonado_apartado , restante_pagar
FROM apartado
INNER JOIN detalleapartado ON detalleapartado.idapartado= apartado.idapartado
INNER JOIN view_productos ON detalleapartado.idproducto = view_productos.idproducto
INNER JOIN view_usuarios ON view_usuarios.idusuario = apartado.idusuario
LEFT JOIN cliente ON apartado.idcliente = cliente.idcliente;