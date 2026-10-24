
DROP EVENT IF EXISTS `Cerrar_Inventario`;
CREATE EVENT `Cerrar_Inventario` 
ON SCHEDULE EVERY 1 DAY STARTS '2018-01-01 00:00:00' 
ON COMPLETION NOT PRESERVE ENABLE DO CALL sp_cerrar_inventario();

DROP EVENT IF EXISTS `Sacar_Vencidos`;
CREATE EVENT `Sacar_Vencidos` 
ON SCHEDULE EVERY 1 DAY STARTS '2018-01-01 00:00:00' 
ON COMPLETION NOT PRESERVE ENABLE DO CALL sp_sacar_vencidos();

DROP EVENT IF EXISTS `Anular_Apartados`;
CREATE EVENT `Anular_Apartados` 
ON SCHEDULE EVERY 1 DAY STARTS '2018-01-01 00:00:00' 
ON COMPLETION NOT PRESERVE ENABLE DO CALL sp_devolver_productos_apartados();

INSERT INTO `empleado` (`idempleado`, `codigo_empleado`, `nombre_empleado`, `apellido_empleado`, `telefono_empleado`, `email_empleado`, `estado`) VALUES
(1, 'EM00000001', 'EMPLEADO', 'DE PRUEBA', '1234567890', 'correo@correo.com', 1);

INSERT INTO `usuario` (`idusuario`, `usuario`, `contrasena`, `tipo_usuario`, `estado`, `idempleado`) VALUES
(1, 'admin', 'admin%', 1, 1, 1);

INSERT INTO `currency` (`CurrencyISO`, `Language`, `CurrencyName`, `Money`, `Symbol`) VALUES
('MXN', 'ES', 'Peso Mexicano', 'Peso', '$'),
('USD', 'EN', 'Dolar Estadounidense', 'US.Dolar', '$');

INSERT INTO `categoria` (`idcategoria`, `nombre_categoria`, `estado`) VALUES
(1, 'OTROS', 1);

INSERT INTO `marca` (`idmarca`, `nombre_marca`, `estado`) VALUES
(1, 'GENERICA', 1);

INSERT INTO `presentacion` (`idpresentacion`, `nombre_presentacion`, `siglas`, `estado`) VALUES
(1, 'PIEZA', 'PZA', 1);

INSERT INTO `producto` (`idproducto`, `codigo_interno`, `codigo_barra`, `nombre_producto`, `precio_compra`, `precio_venta`, `precio_venta_mayoreo`, `stock`, `stock_min`, `idcategoria`, `idmarca`, `idpresentacion`, `estado`, `exento`, `inventariable`, `perecedero`) VALUES
(1, 'PR00000001', '1234567890', 'PRODUCTO 1', '10.00', '11.00', '10.50', '100.00', '5.00', 1, 1, 1, 1, 0, 1, 0),
(2, 'PR00000002', '0987654321', 'PRODUCTO 2', '11.00', '12.00', '11.50', '100.00', '5.00', 1, 1, 1, 1, 0, 1, 0);

INSERT INTO `comprobante` (`idcomprobante`, `nombre_comprobante`, `estado`) VALUES
(1, 'TICKET', 1);

INSERT INTO `tiraje_comprobante` (`idtiraje`, `fecha_resolucion`, `numero_resolucion`, `serie`, `desde`, `hasta`, `idcomprobante`, `disponibles`) VALUES
(1, '2018-12-31 12:00:00', 'RES 008458148', 'SERIE A', 1, 5000, 1, 5000);

INSERT INTO `parametro` (`idparametro`, `nombre_empresa`, `propietario`, `clave_rfc`, `regimen_fiscal`, `porcentaje_iva`, `porcentaje_retencion`, `monto_retencion`, `direccion_empresa`, `logo_empresa`, `idcurrency`) VALUES
(1, 'NEGOCIO', 'NOMBRE DE PROPIETARIO', 'XAXX010101000', '621', '16.00', '1.00', '100.00', 'DIRECCION DE NEGOCIO', NULL, 1);

INSERT INTO `cliente` (`idcliente`, `codigo_cliente`, `nombre_cliente`, `clave_rfc`, `regimen_fiscal`, `direccion_cliente`, `numero_telefono`, `email`, `giro`, `limite_credito`, `estado`) VALUES
(1, 'CL00000001', 'CLIENTE 1', 'XAXX010101000', '621', 'DIRECCION 1', '1234567890', 'correo@correo.com', 'DESCONOCIDO', '1000.00', 1),
(2, 'CL00000002', 'CLIENTE 2', 'XAXX010101000', '621', 'DIRECCION 2', '1234567890', 'correo@correo.com', 'DESCONOCIDO', '800.00', 1);