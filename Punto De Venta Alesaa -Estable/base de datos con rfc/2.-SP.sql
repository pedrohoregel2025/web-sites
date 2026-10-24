-- Procedimientos Almacenados
-- Almacen

DROP PROCEDURE IF EXISTS sp_insert_categoria;
DELIMITER //
CREATE PROCEDURE sp_insert_categoria(
	IN p_nombre_categoria varchar(120)
	)
	BEGIN
    IF NOT EXISTS (SELECT * FROM `categoria` WHERE `nombre_categoria` = p_nombre_categoria) THEN
		INSERT INTO `categoria`(`nombre_categoria`)
		VALUES (p_nombre_categoria);
    END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_categoria;
DELIMITER //
CREATE PROCEDURE sp_view_categoria()
BEGIN
SELECT `idcategoria`, `nombre_categoria`, `estado`
FROM `categoria`;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_categoria_activa;
DELIMITER //
CREATE PROCEDURE sp_view_categoria_activa()
BEGIN
SELECT `idcategoria`, `nombre_categoria`, `estado`
FROM `categoria` WHERE `estado` = 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_categoria;
DELIMITER //
CREATE PROCEDURE sp_update_categoria(
IN p_idcategoria int(11),
IN p_nombre_categoria varchar(120),
IN p_estado tinyint(1)
)
BEGIN
UPDATE `categoria`
SET `nombre_categoria` = p_nombre_categoria, `estado` = p_estado
WHERE `idcategoria` = p_idcategoria;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_insert_presentacion;
DELIMITER //
CREATE PROCEDURE sp_insert_presentacion(
IN p_nombre_presentacion varchar(120),
IN p_siglas varchar(45)
)
BEGIN
  IF NOT EXISTS (SELECT * FROM `presentacion` WHERE `nombre_presentacion` = p_nombre_presentacion) THEN
	INSERT INTO `presentacion`(`nombre_presentacion`,`siglas`)
	VALUES (p_nombre_presentacion,p_siglas);
  END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_presentacion;
DELIMITER //
CREATE PROCEDURE sp_view_presentacion()
BEGIN
SELECT `idpresentacion`, `nombre_presentacion`, `siglas` , `estado`
FROM `presentacion`;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_presentacion_activa;
DELIMITER //
CREATE PROCEDURE sp_view_presentacion_activa()
BEGIN
SELECT `idpresentacion`, `nombre_presentacion`, `siglas` , `estado`
FROM `presentacion` WHERE `estado` = 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_presentacion;
DELIMITER //
CREATE PROCEDURE sp_update_presentacion(
IN p_idpresentacion int(11),
IN p_nombre_presentacion varchar(120),
IN p_siglas varchar(45),
IN p_estado tinyint(1)
)
BEGIN
UPDATE `presentacion`
SET `nombre_presentacion` = p_nombre_presentacion,
`siglas` = p_siglas,
`estado` = p_estado
WHERE `idpresentacion` = p_idpresentacion;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_insert_marca;
DELIMITER //
CREATE PROCEDURE sp_insert_marca(
IN p_nombre_marca varchar(120)
)
BEGIN
  IF NOT EXISTS (SELECT * FROM `marca` WHERE `nombre_marca` = p_nombre_marca) THEN
	INSERT INTO `marca`(`nombre_marca`)
	VALUES (p_nombre_marca);
  END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_marca;
DELIMITER //
CREATE PROCEDURE sp_view_marca()
BEGIN
SELECT `idmarca`, `nombre_marca`, `estado`
FROM `marca`;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_marca_activa;
DELIMITER //
CREATE PROCEDURE sp_view_marca_activa()
BEGIN
SELECT `idmarca`, `nombre_marca`, `estado`
FROM `marca` WHERE `estado` = 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_marca;
DELIMITER //
CREATE PROCEDURE sp_update_marca(
IN p_idmarca int(11),
IN p_nombre_marca varchar(120),
IN p_estado tinyint(1)
)
BEGIN
UPDATE `marca`
SET `nombre_marca` = p_nombre_marca, `estado` = p_estado
WHERE `idmarca` = p_idmarca;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_insert_producto;
DELIMITER //
CREATE PROCEDURE sp_insert_producto(
IN p_codigo_barra varchar(200),
IN p_nombre_producto varchar(175),
IN p_precio_compra decimal(8,4),
IN p_precio_venta decimal(8,2),
IN p_precio_venta_mayoreo decimal(8,2),
IN p_stock decimal(8,2),
IN p_stock_min decimal(8,2),
IN p_idcategoria int(11),
IN p_idmarca int(11),
IN p_idpresentacion int(11),
IN p_exento tinyint(1),
IN p_inventariable tinyint(1),
IN p_perecedero tinyint(1)
)
BEGIN

	IF (p_inventariable = 1) THEN

	 IF NOT EXISTS (SELECT * FROM `producto` WHERE `nombre_producto` = p_nombre_producto) THEN

		INSERT INTO `producto`(`codigo_barra`, `nombre_producto`,
		`precio_compra`, `precio_venta`, `precio_venta_mayoreo`, `stock`,
		`stock_min`, `idcategoria`, `idmarca`, `idpresentacion`,`exento`,
		`inventariable`, `perecedero`)
		VALUES (p_codigo_barra, p_nombre_producto,
		p_precio_compra, p_precio_venta, p_precio_venta_mayoreo,p_stock,
		p_stock_min, p_idcategoria, p_idmarca, p_idpresentacion,
		p_exento, p_inventariable, p_perecedero);
	 END IF;

     ELSE

		IF NOT EXISTS (SELECT * FROM `producto` WHERE `nombre_producto` = p_nombre_producto) THEN

			INSERT INTO `producto`(`codigo_barra`, `nombre_producto`,
			`precio_compra`, `precio_venta`, `precio_venta_mayoreo`,
			`stock_min`, `idcategoria`, `idmarca`, `idpresentacion`,`exento`,
			`inventariable`, `perecedero`)
			VALUES (p_codigo_barra, p_nombre_producto,
			p_precio_compra, p_precio_venta, p_precio_venta_mayoreo,
			0, p_idcategoria, p_idmarca, p_idpresentacion,
			p_exento, p_inventariable, p_perecedero);
		 END IF;

   END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_producto;
DELIMITER //
CREATE PROCEDURE sp_view_producto()
BEGIN
SELECT * FROM view_productos;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_producto_activo;
DELIMITER //
CREATE PROCEDURE sp_view_producto_activo()
BEGIN
SELECT * FROM view_productos WHERE estado = 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_print_barcode_producto;
DELIMITER //
CREATE PROCEDURE sp_print_barcode_producto(
 IN p_id INT
)
BEGIN
SELECT codigo_barra,codigo_interno,nombre_producto FROM producto WHERE idproducto = p_id;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_producto_inactivo;
DELIMITER //
CREATE PROCEDURE sp_view_producto_inactivo()
BEGIN
SELECT * FROM view_productos WHERE estado = 0;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_producto_agotado;
DELIMITER //
CREATE PROCEDURE sp_view_producto_agotado()
BEGIN
SELECT * FROM view_productos WHERE stock = 0;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_producto_vigente;
DELIMITER //
CREATE PROCEDURE sp_view_producto_vigente()
BEGIN
SELECT * FROM view_productos WHERE  stock > 0.00;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_producto_perecedero;
DELIMITER //
CREATE PROCEDURE sp_view_producto_perecedero()
BEGIN
SELECT * FROM view_productos WHERE estado = 1 AND perecedero = 1 AND  stock > 0.00 AND inventariable = 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_producto_no_perecedero;
DELIMITER //
CREATE PROCEDURE sp_view_producto_no_perecedero()
BEGIN
SELECT * FROM view_productos WHERE estado = 1 AND perecedero = 0 AND  stock > 0.00 AND inventariable = 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_stock_producto_perecedero;
DELIMITER //
CREATE PROCEDURE sp_view_stock_producto_perecedero(
	IN p_idproducto int(11)
)
BEGIN
SELECT stock FROM view_productos WHERE estado = 1 AND perecedero = 1
AND  stock > 0.00 AND inventariable = 1 AND idproducto = p_idproducto ;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_producto;
DELIMITER //
CREATE PROCEDURE sp_update_producto(
IN p_idproducto int(11),
IN p_codigo_barra varchar(200),
IN p_nombre_producto varchar(175),
IN p_precio_compra decimal(8,4),
IN p_precio_venta decimal(8,2),
IN p_precio_venta_mayoreo decimal(8,2),
IN p_stock_min decimal(8,2),
IN p_idcategoria int(11),
IN p_idmarca int(11),
IN p_idpresentacion int(11),
IN p_estado tinyint(1),
IN p_exento tinyint(1),
IN p_inventariable tinyint(1),
IN p_perecedero tinyint(1)
)
BEGIN
  IF (p_inventariable = 0) THEN
		UPDATE `producto`
		SET `codigo_barra` = p_codigo_barra, `nombre_producto` = p_nombre_producto, `precio_compra` = p_precio_compra,
		`precio_venta` = p_precio_venta, `precio_venta_mayoreo` = p_precio_venta_mayoreo,`stock_min` = 0, `stock` = 0,
		`idcategoria` = p_idcategoria, `idmarca` = p_idmarca, `idpresentacion` = p_idpresentacion, `estado` = p_estado,
		`exento` = p_exento, `inventariable` = p_inventariable, `perecedero` = p_perecedero
		WHERE `idproducto` = p_idproducto;
	ELSE
		UPDATE `producto`
		SET `codigo_barra` = p_codigo_barra, `nombre_producto` = p_nombre_producto, `precio_compra` = p_precio_compra,
		`precio_venta` = p_precio_venta, `precio_venta_mayoreo` = p_precio_venta_mayoreo,`stock_min` = p_stock_min,
		`idcategoria` = p_idcategoria, `idmarca` = p_idmarca, `idpresentacion` = p_idpresentacion, `estado` = p_estado,
		`exento` = p_exento, `inventariable` = p_inventariable, `perecedero` = p_perecedero
		WHERE `idproducto` = p_idproducto;
  END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_search_producto;
DELIMITER //
CREATE PROCEDURE sp_search_producto(

	IN p_search varchar(175)

)
BEGIN
SELECT idproducto,codigo_interno,codigo_barra,nombre_producto,siglas,nombre_marca,
precio_compra,exento,perecedero FROM view_productos WHERE codigo_barra LIKE CONCAT('%',p_search,'%')
OR nombre_producto LIKE CONCAT('%',p_search,'%') AND estado = 1 AND inventariable = 1 AND precio_compra > 0.00;
END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_search_producto_cotizacion;
DELIMITER //
CREATE PROCEDURE sp_search_producto_cotizacion(

	IN p_search varchar(175)

)
BEGIN
SELECT idproducto,codigo_interno,codigo_barra,nombre_producto,siglas,nombre_marca,
precio_venta,precio_venta_mayoreo,stock,exento,perecedero
FROM view_productos WHERE codigo_barra LIKE CONCAT('%',p_search,'%')
OR nombre_producto LIKE CONCAT('%',p_search,'%') AND estado = 1 AND inventariable = 1
AND precio_venta > 0.00;
END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_search_producto_venta;
DELIMITER //
CREATE PROCEDURE sp_search_producto_venta(

	IN p_search varchar(175)

)
BEGIN
SELECT * FROM view_productos_venta WHERE codigo_barra LIKE CONCAT('%',p_search,'%')
OR nombre_producto LIKE CONCAT('%',p_search,'%') OR codigo_interno LIKE CONCAT('%',p_search,'%')
ORDER BY idproducto DESC;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_search_producto_apartado;
DELIMITER //
CREATE PROCEDURE sp_search_producto_apartado(

	IN p_search varchar(175)

)
BEGIN
SELECT * FROM view_productos_apartado WHERE codigo_barra LIKE CONCAT('%',p_search,'%')
OR nombre_producto LIKE CONCAT('%',p_search,'%') OR codigo_interno LIKE CONCAT('%',p_search,'%')
ORDER BY idproducto DESC;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_perecedero;
DELIMITER //
CREATE PROCEDURE sp_insert_perecedero(
IN p_fecha_vencimiento date,
IN p_cantidad_perecedero decimal(8,2),
IN p_idproducto int(11)
)
BEGIN
  IF NOT EXISTS (SELECT * FROM perecedero WHERE idproducto = p_idproducto
  AND fecha_vencimiento = p_fecha_vencimiento) THEN
	INSERT INTO `perecedero`(`fecha_vencimiento`, `cantidad_perecedero`, `idproducto`)
	VALUES (p_fecha_vencimiento, p_cantidad_perecedero, p_idproducto);
  END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_perecedero;
DELIMITER //
CREATE PROCEDURE sp_view_perecedero(
	IN p_desde date,
    IN p_hasta date
)
BEGIN
	IF p_desde IS NULL AND p_hasta IS NULL THEN
		SELECT * FROM view_perecederos;
	ELSE
		SELECT * FROM view_perecederos WHERE fecha_vencimiento
		BETWEEN p_desde AND p_hasta;
	END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_perecedero;
DELIMITER //
CREATE PROCEDURE sp_update_perecedero(
IN p_fecha_vencimiento date,
IN p_cantidad_perecedero decimal(8,2),
IN p_idproducto int(11)
)
BEGIN
  UPDATE `perecedero` SET
  `cantidad_perecedero` = p_cantidad_perecedero
   WHERE `idproducto` =  p_idproducto AND `fecha_vencimiento` = p_fecha_vencimiento;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_delete_perecedero;
DELIMITER //
CREATE PROCEDURE sp_delete_perecedero(
	IN p_fecha_vencimiento date,
	IN p_idproducto int(11)
)
BEGIN
	DELETE FROM `perecedero` WHERE `idproducto` =  p_idproducto
    AND `fecha_vencimiento` = p_fecha_vencimiento;
END //
DELIMITER ;



 -- Almacen



 -- Compras

DROP PROCEDURE IF EXISTS sp_insert_proveedor;
DELIMITER //
CREATE PROCEDURE sp_insert_proveedor(
IN p_nombre_proveedor varchar(175),
IN p_numero_telefono varchar(20),
IN p_clave_rfc varchar(20),
IN p_regimen_fiscal varchar(14),
IN p_direccion_proveedor varchar(175),
IN p_nombre_contacto varchar(150),
IN p_telefono_contacto varchar(20)
)
BEGIN
   IF NOT EXISTS (SELECT * FROM `proveedor` WHERE `nombre_proveedor` = p_nombre_proveedor) THEN
	INSERT INTO `proveedor`(`nombre_proveedor`, `numero_telefono`,
	`clave_rfc`, `regimen_fiscal`, `direccion_proveedor`, `nombre_contacto`, `telefono_contacto`)
	VALUES (p_nombre_proveedor, p_numero_telefono,
	p_clave_rfc, p_regimen_fiscal, p_direccion_proveedor, p_nombre_contacto, p_telefono_contacto);
   END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_proveedor;
DELIMITER //
CREATE PROCEDURE sp_view_proveedor()
BEGIN
SELECT `idproveedor`, `codigo_proveedor`, `nombre_proveedor`, `numero_telefono`,
`clave_rfc`, `regimen_fiscal`, `direccion_proveedor`, `nombre_contacto`, `telefono_contacto`,
`estado`
FROM `proveedor`;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_proveedor_activo;
DELIMITER //
CREATE PROCEDURE sp_view_proveedor_activo()
BEGIN
SELECT `idproveedor`, `codigo_proveedor`, `nombre_proveedor`, `numero_telefono`,
`clave_rfc`, `regimen_fiscal`, `direccion_proveedor`, `nombre_contacto`, `telefono_contacto`,
`estado`
FROM `proveedor` WHERE `estado`= 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_proveedor;
DELIMITER //
CREATE PROCEDURE sp_update_proveedor(
IN p_idproveedor int(11),
IN p_nombre_proveedor varchar(175),
IN p_numero_telefono varchar(20),
IN p_clave_rfc varchar(20),
IN p_regimen_fiscal varchar(14),
IN p_direccion_proveedor varchar(175),
IN p_nombre_contacto varchar(150),
IN p_telefono_contacto varchar(20),
IN p_estado tinyint(1)
)
BEGIN
UPDATE `proveedor`
SET `nombre_proveedor` = p_nombre_proveedor, `numero_telefono` = p_numero_telefono, `clave_rfc` = p_clave_rfc,
`regimen_fiscal` = p_regimen_fiscal, `direccion_proveedor` = p_direccion_proveedor, `nombre_contacto` = p_nombre_contacto, `telefono_contacto` = p_telefono_contacto, `estado` = p_estado
WHERE `idproveedor` = p_idproveedor;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_compra;
DELIMITER //
CREATE PROCEDURE sp_insert_compra(
IN p_fecha_compra datetime,
IN p_idproveedor int(11),
IN p_tipo_pago varchar(75),
IN p_numero_comprobante varchar(60),
IN p_tipo_comprobante varchar(60),
IN p_fecha_comprobante date,
IN p_sumas decimal(8,2),
IN p_iva decimal(8,2),
IN p_exento decimal(8,2),
IN p_retenido decimal(8,2),
IN p_total decimal(8,2),
IN p_sonletras varchar(150)
)
BEGIN
   IF NOT EXISTS (SELECT * FROM `compra` WHERE `fecha_comprobante` = p_fecha_comprobante
   AND `numero_comprobante` = p_numero_comprobante) THEN
		INSERT INTO `compra`(`fecha_compra`, `idproveedor`, `tipo_pago`,
		`numero_comprobante`, `tipo_comprobante`, `fecha_comprobante`, `sumas`,
		`iva`, `exento`, `retenido`, `total`,`sonletras`)
		VALUES (p_fecha_compra, p_idproveedor, p_tipo_pago,
		p_numero_comprobante, p_tipo_comprobante, p_fecha_comprobante, p_sumas,
		p_iva, p_exento, p_retenido, p_total, p_sonletras);
   END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_detallecompra;
DELIMITER //
CREATE PROCEDURE sp_insert_detallecompra(
IN p_idproducto int(11),
IN p_cantidad decimal(8,2),
IN p_precio_unitario decimal(8,4),
IN p_exento decimal(8,2),
IN p_fecha_vencimiento date,
IN p_importe decimal(8,2)
)
BEGIN

	DECLARE p_idcompra int(11);
	DECLARE p_idproveedor int(11);
    DECLARE p_costo DECIMAL(8,2);
    DECLARE p_numero_comprobante varchar(60);
    DECLARE p_tipo_comprobante varchar(60);
    DECLARE p_descr_entrada varchar(150);
    DECLARE p_inventariable int(11);


    SET p_idcompra = (SELECT MAX(idcompra) FROM compra);
    SET p_idproveedor = (SELECT idproveedor FROM compra WHERE idcompra = p_idcompra);
    SET p_costo = (p_cantidad * p_precio_unitario);
    SET p_numero_comprobante = (SELECT numero_comprobante FROM compra WHERE idcompra = p_idcompra);
    SET p_tipo_comprobante = (SELECT tipo_comprobante FROM compra WHERE idcompra = p_idcompra);


    IF(p_tipo_comprobante = 1)THEN
		SET p_descr_entrada = (CONCAT('POR COMPRA',' TICKET # ',p_numero_comprobante));
	ELSEIF (p_tipo_comprobante = 2) THEN
		SET p_descr_entrada = (CONCAT('POR COMPRA',' FACTURA # ',p_numero_comprobante));
	ELSEIF (p_tipo_comprobante = 3) THEN
		SET p_descr_entrada = (CONCAT('POR COMPRA',' CREDITO FISCAL # ',p_numero_comprobante));
    END IF;

    SET p_inventariable = (SELECT inventariable FROM producto WHERE idproducto = p_idproducto);


    IF (p_inventariable  = 0) THEN

	  IF p_idcompra IS NULL OR p_idcompra = '' THEN

		INSERT INTO `detallecompra`(`idcompra`, `idproducto`, `fecha_vence`, `cantidad`, `precio_unitario`,
		`exento`, `importe`)
		VALUES (1, p_idproducto, NULL ,p_cantidad, p_precio_unitario,
		p_exento, p_importe);

		INSERT INTO `proveedor_precio`(`idproveedor`, `idproducto`, `fecha_precio`, `precio_compra`)
		VALUES (p_idproveedor, p_idproducto, CURDATE(), p_precio_unitario);

		ELSE

		INSERT INTO `detallecompra`(`idcompra`, `idproducto`, `fecha_vence`, `cantidad`, `precio_unitario`,
		`exento`, `importe`)
		VALUES (p_idcompra, p_idproducto, NULL, p_cantidad, p_precio_unitario,
		p_exento, p_importe);


		INSERT INTO `proveedor_precio`(`idproveedor`, `idproducto`, `fecha_precio`, `precio_compra`)
		VALUES (p_idproveedor, p_idproducto, CURDATE(), p_precio_unitario);

		END IF;

    ELSE

    IF (p_fecha_vencimiento != '2000-01-01') THEN

        IF p_idcompra IS NULL OR p_idcompra = '' THEN

			INSERT INTO `detallecompra`(`idcompra`, `idproducto`, `fecha_vence`, `cantidad`, `precio_unitario`,
			`exento`, `importe`)
			VALUES (1, p_idproducto, p_fecha_vencimiento,  p_cantidad, p_precio_unitario,
			p_exento, p_importe);

			INSERT INTO `entrada`(`mes_inventario`,`fecha_entrada`, `descripcion_entrada`, `cantidad_entrada`,
			`precio_unitario_entrada`, `costo_total_entrada`,`idproducto`,`idcompra`)
			VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_entrada,p_cantidad,p_precio_unitario,p_costo,p_idproducto,1);

			INSERT INTO `proveedor_precio`(`idproveedor`, `idproducto`, `fecha_precio`, `precio_compra`)
			VALUES (p_idproveedor, p_idproducto, CURDATE(), p_precio_unitario);

			UPDATE `inventario` SET
			`saldo_final` = `saldo_final` + p_cantidad,
            `entradas` = `entradas` + p_cantidad
			WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
			AND fecha_cierre = LAST_DAY(CURDATE());

			IF NOT EXISTS (SELECT * FROM perecedero WHERE fecha_vencimiento = p_fecha_vencimiento
			AND idproducto = p_idproducto) THEN
				INSERT INTO `perecedero` (`fecha_vencimiento`, `cantidad_perecedero`, `idproducto`)
				VALUES (p_fecha_vencimiento,p_cantidad,p_idproducto);
			   ELSE
			   UPDATE `perecedero` SET
			   `cantidad_perecedero` = `cantidad_perecedero` + p_cantidad
			   WHERE `idproducto` = p_idproducto AND `fecha_vencimiento` = p_fecha_vencimiento;
			END IF;

			UPDATE `producto` SET
			`stock` = `stock` + p_cantidad
			WHERE idproducto = p_idproducto;

		ELSE

			INSERT INTO `detallecompra`(`idcompra`, `idproducto`, `fecha_vence`, `cantidad`, `precio_unitario`,
			`exento`, `importe`)
			VALUES (p_idcompra, p_idproducto, p_fecha_vencimiento, p_cantidad, p_precio_unitario,
			p_exento, p_importe);

			INSERT INTO `entrada`(`mes_inventario`,`fecha_entrada`, `descripcion_entrada`, `cantidad_entrada`,
			`precio_unitario_entrada`, `costo_total_entrada`,`idproducto`,`idcompra`)
			VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_entrada,p_cantidad,p_precio_unitario,p_costo,p_idproducto,p_idcompra);

			INSERT INTO `proveedor_precio`(`idproveedor`, `idproducto`, `fecha_precio`, `precio_compra`)
			VALUES (p_idproveedor, p_idproducto, CURDATE(), p_precio_unitario);

			UPDATE `inventario` SET
			`saldo_final` = `saldo_final` + p_cantidad,
            `entradas` = `entradas` + p_cantidad
			WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
			AND fecha_cierre = LAST_DAY(CURDATE());

			IF NOT EXISTS (SELECT * FROM perecedero WHERE fecha_vencimiento = p_fecha_vencimiento
			AND idproducto = p_idproducto) THEN
				INSERT INTO `perecedero` (`fecha_vencimiento`, `cantidad_perecedero`, `idproducto`)
				VALUES (p_fecha_vencimiento,p_cantidad,p_idproducto);
			   ELSE
			   UPDATE `perecedero` SET
			   `cantidad_perecedero` = `cantidad_perecedero` + p_cantidad
			   WHERE `idproducto` = p_idproducto AND `fecha_vencimiento` = p_fecha_vencimiento;
			END IF;


			UPDATE `producto` SET
			`stock` = `stock` + p_cantidad
			WHERE idproducto = p_idproducto;

			END IF;

	ELSE

		IF p_idcompra IS NULL OR p_idcompra = '' THEN

		INSERT INTO `detallecompra`(`idcompra`, `idproducto`, `fecha_vence`, `cantidad`, `precio_unitario`,
		`exento`, `importe`)
		VALUES (1, p_idproducto, NULL, p_cantidad, p_precio_unitario,
		p_exento, p_importe);

		INSERT INTO `entrada`(`mes_inventario`,`fecha_entrada`, `descripcion_entrada`, `cantidad_entrada`,
		`precio_unitario_entrada`, `costo_total_entrada`,`idproducto`,`idcompra`)
		VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_entrada,p_cantidad,p_precio_unitario,p_costo,p_idproducto,1);

		INSERT INTO `proveedor_precio`(`idproveedor`, `idproducto`, `fecha_precio`, `precio_compra`)
		VALUES (p_idproveedor, p_idproducto, CURDATE(), p_precio_unitario);

		UPDATE `inventario` SET
		`saldo_final` = `saldo_final` + p_cantidad,
		`entradas` = `entradas` + p_cantidad
		WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND fecha_cierre = LAST_DAY(CURDATE());

		UPDATE `producto` SET
		`stock` = `stock` + p_cantidad
		WHERE idproducto = p_idproducto;

		ELSE

		INSERT INTO `detallecompra`(`idcompra`, `idproducto`, `fecha_vence`, `cantidad`, `precio_unitario`,
		`exento`, `importe`)
		VALUES (p_idcompra, p_idproducto, NULL, p_cantidad, p_precio_unitario,
		p_exento, p_importe);

		INSERT INTO `entrada`(`mes_inventario`,`fecha_entrada`, `descripcion_entrada`, `cantidad_entrada`,
		`precio_unitario_entrada`, `costo_total_entrada`,`idproducto`,`idcompra`)
		VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_entrada,p_cantidad,p_precio_unitario,p_costo,p_idproducto,p_idcompra);


		INSERT INTO `proveedor_precio`(`idproveedor`, `idproducto`, `fecha_precio`, `precio_compra`)
		VALUES (p_idproveedor, p_idproducto, CURDATE(), p_precio_unitario);

		UPDATE `inventario` SET
		`saldo_final` = `saldo_final` + p_cantidad,
		`entradas` = `entradas` + p_cantidad
		WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND fecha_cierre = LAST_DAY(CURDATE());

		UPDATE `producto` SET
		`stock` = `stock` + p_cantidad
		WHERE idproducto = p_idproducto;

		END IF;

	 END IF;

    END IF;

END //
DELIMITER ;


 -- Compras







-- Parametros

DROP PROCEDURE IF EXISTS sp_insert_parametro;
DELIMITER //
CREATE PROCEDURE sp_insert_parametro(
IN p_nombre_empresa varchar(150),
IN p_propietario varchar(150),
IN p_clave_rfc varchar(20),
IN p_regimen_fiscal varchar(14),
IN p_porcentaje_iva decimal(8,2),
IN p_porcentaje_retencion decimal(8,2),
IN p_monto_retencion decimal(8,2),
IN p_direccion_empresa varchar(200),
IN p_idcurrency int(11)
)
BEGIN
	   DECLARE contador INT;
	   SET contador = (SELECT COUNT(*) FROM `parametro`);

		IF contador = 0 THEN
			INSERT INTO `parametro`(`nombre_empresa`, `propietario`, `clave_rfc`,
			`regimen_fiscal`, `porcentaje_iva`, `porcentaje_retencion`, `monto_retencion`, `direccion_empresa`,`idcurrency`)
			VALUES (p_nombre_empresa, p_propietario, p_clave_rfc,
			p_regimen_fiscal, p_porcentaje_iva, p_porcentaje_retencion, p_monto_retencion,
            p_direccion_empresa,p_idcurrency);
		END IF;
END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_view_parametro;
DELIMITER //
CREATE PROCEDURE sp_view_parametro()
BEGIN
SELECT `idparametro`, `nombre_empresa`, `propietario`, `clave_rfc`,
`regimen_fiscal`, `porcentaje_iva`, `porcentaje_retencion`, `monto_retencion`,
`direccion_empresa`, `logo_empresa`, `idcurrency`
FROM `parametro`;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_parametro;
DELIMITER //
CREATE PROCEDURE sp_update_parametro(
IN p_idparametro int(11),
IN p_nombre_empresa varchar(150),
IN p_propietario varchar(150),
IN p_clave_rfc varchar(20),
IN p_regimen_fiscal varchar(14),
IN p_porcentaje_iva decimal(8,2),
IN p_porcentaje_retencion decimal(8,2),
IN p_monto_retencion decimal(8,2),
IN p_direccion_empresa varchar(200),
IN p_idcurrency int(11)
)
BEGIN
UPDATE `parametro`
SET `nombre_empresa` = p_nombre_empresa, `propietario` = p_propietario, `clave_rfc` = p_clave_rfc, `regimen_fiscal` = p_regimen_fiscal,
`porcentaje_iva` = p_porcentaje_iva, `porcentaje_retencion` = p_porcentaje_retencion,
`monto_retencion` = p_monto_retencion,`direccion_empresa` = p_direccion_empresa,`idcurrency` = p_idcurrency
WHERE `idparametro` = p_idparametro;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_impuesto;
DELIMITER //
CREATE PROCEDURE sp_view_impuesto()
BEGIN
SELECT `porcentaje_iva`,`porcentaje_retencion`,`monto_retencion`  FROM `parametro`;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_currency;
DELIMITER //
CREATE PROCEDURE sp_view_currency()
BEGIN
SELECT `idcurrency`, `CurrencyISO`, `Language`, `CurrencyName`,
`Money`, `Symbol`
FROM `currency`;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_money;
DELIMITER //
CREATE PROCEDURE sp_view_money()
BEGIN
DECLARE p_idcurrency INT;
SET p_idcurrency = (SELECT MAX(idcurrency) FROM parametro);
SELECT `CurrencyISO`,`Symbol`,`CurrencyName`
FROM `currency`
WHERE `idcurrency` = p_idcurrency;
END //
DELIMITER ;


-- Parametros



-- Empleados / Usuarios

DROP PROCEDURE IF EXISTS sp_insert_empleado;
DELIMITER //
CREATE PROCEDURE sp_insert_empleado(
IN p_nombre_empleado varchar(90),
IN p_apellido_empleado varchar(90),
IN p_telefono_empleado varchar(20),
IN p_email_empleado varchar(80)
)
BEGIN
	IF NOT EXISTS (SELECT * FROM `empleado` WHERE `nombre_empleado` = p_nombre_empleado AND
    `apellido_empleado` = p_apellido_empleado) THEN
		INSERT INTO `empleado`(`nombre_empleado`, `apellido_empleado`,
		`telefono_empleado`, `email_empleado`)
		VALUES (p_nombre_empleado, p_apellido_empleado,
		p_telefono_empleado, p_email_empleado);
	END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_empleado;
DELIMITER //
CREATE PROCEDURE sp_view_empleado()
BEGIN
SELECT `idempleado`, `codigo_empleado`, `nombre_empleado`, `apellido_empleado`,
`telefono_empleado`, `email_empleado`, `estado`
FROM `empleado`;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_empleado_activo;
DELIMITER //
CREATE PROCEDURE sp_view_empleado_activo()
BEGIN
SELECT `idempleado`, `codigo_empleado`, `nombre_empleado`, `apellido_empleado`,
`telefono_empleado`, `email_empleado`, `estado`
FROM `empleado` WHERE `estado` = 1;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_empleado;
DELIMITER //
CREATE PROCEDURE sp_update_empleado(
IN p_idempleado int(11),
IN p_nombre_empleado varchar(90),
IN p_apellido_empleado varchar(90),
IN p_telefono_empleado varchar(20),
IN p_email_empleado varchar(80),
IN p_estado tinyint(1)
)
BEGIN
UPDATE `empleado`
SET `nombre_empleado` = p_nombre_empleado, `apellido_empleado` = p_apellido_empleado, `telefono_empleado` = p_telefono_empleado,
`email_empleado` = p_email_empleado, `estado` = p_estado
WHERE `idempleado` = p_idempleado;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_usuario;
DELIMITER //
CREATE PROCEDURE sp_insert_usuario(
IN p_usuario varchar(8),
IN p_contrasena varchar(12),
IN p_tipo_usuario tinyint(1),
IN p_idempleado int(11)
)
BEGIN
  IF NOT EXISTS (SELECT * FROM `usuario` WHERE `idempleado` = p_idempleado) THEN
	INSERT INTO `usuario`(`usuario`, `contrasena`, `tipo_usuario`,`idempleado`)
	VALUES (p_usuario, p_contrasena, p_tipo_usuario, p_idempleado);
  END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_usuario;
DELIMITER //
CREATE PROCEDURE sp_view_usuario()
BEGIN
SELECT * FROM view_usuarios;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_usuario;
DELIMITER //
CREATE PROCEDURE sp_update_usuario(
IN p_idusuario int(11),
IN p_usuario varchar(8),
IN p_contrasena varchar(12),
IN p_tipo_usuario tinyint(1),
IN p_estado tinyint(1),
IN p_idempleado int(11)
)
BEGIN
UPDATE `usuario`
SET `usuario` = p_usuario, `contrasena` = p_contrasena, `tipo_usuario` = p_tipo_usuario, `estado` = p_estado,
`idempleado` = p_idempleado
WHERE `idusuario` = p_idusuario;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_login_usuario;
DELIMITER //
CREATE PROCEDURE sp_login_usuario(
	IN p_usuario varchar(8),
	IN p_contrasena varchar(12)
)
BEGIN
	SELECT * FROM view_usuarios WHERE usuario = p_usuario AND contrasena = p_contrasena
    AND estado = 1;

    CALL sp_cerrar_inventario();

    CALL sp_sacar_vencidos();
    
    CALL sp_devolver_productos_apartados();

END //
DELIMITER ;


-- Empleados / Usuarios




 -- Comprobante

DROP PROCEDURE IF EXISTS sp_insert_comprobante;
DELIMITER //
CREATE PROCEDURE sp_insert_comprobante(
IN p_nombre_comprobante varchar(75)
)
BEGIN
   IF NOT EXISTS (SELECT * FROM `comprobante` WHERE `nombre_comprobante` = p_nombre_comprobante) THEN
	INSERT INTO `comprobante`(`nombre_comprobante`)
	VALUES (p_nombre_comprobante);
   END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_comprobante;
DELIMITER //
CREATE PROCEDURE sp_view_comprobante()
BEGIN
SELECT `idcomprobante`, `nombre_comprobante`, `estado`
FROM `comprobante`;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_comprobante_activo;
DELIMITER //
CREATE PROCEDURE sp_view_comprobante_activo()
BEGIN
SELECT `idcomprobante`, `nombre_comprobante` FROM `comprobante` WHERE `estado` = 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_comprobante;
DELIMITER //
CREATE PROCEDURE sp_update_comprobante(
IN p_idcomprobante int(11),
IN p_nombre_comprobante varchar(75),
IN p_estado tinyint(1)
)
BEGIN
UPDATE `comprobante`
SET `nombre_comprobante` = p_nombre_comprobante, `estado` = p_estado
WHERE `idcomprobante` = p_idcomprobante;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_tiraje_comprobante;
DELIMITER //
CREATE PROCEDURE sp_insert_tiraje_comprobante(
IN p_fecha_resolucion datetime,
IN p_numero_resolucion varchar(100),
IN p_serie varchar(175),
IN p_desde int(11),
IN p_hasta int(11),
IN p_disponibles int(11),
IN p_idcomprobante int(11)
)
BEGIN
   IF NOT EXISTS (SELECT * FROM `tiraje_comprobante` WHERE idcomprobante =  p_idcomprobante) THEN
	 INSERT INTO `tiraje_comprobante`(`fecha_resolucion`, `numero_resolucion`, `serie`,
	`desde`, `hasta`, `disponibles`, `idcomprobante`)
		VALUES (p_fecha_resolucion, p_numero_resolucion, p_serie,
		p_desde, p_hasta, p_disponibles, p_idcomprobante);
   END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_tiraje;
DELIMITER //
CREATE PROCEDURE sp_view_tiraje()
BEGIN
SELECT * FROM view_comprobantes;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_tiraje_comprobante;
DELIMITER //
CREATE PROCEDURE sp_update_tiraje_comprobante(
IN p_idtiraje int(11),
IN p_fecha_resolucion datetime,
IN p_numero_resolucion varchar(100),
IN p_serie varchar(175),
IN p_desde int(11),
IN p_hasta int(11),
IN p_disponibles int(11),
IN p_idcomprobante int(11)
)
BEGIN
UPDATE `tiraje_comprobante`
SET `fecha_resolucion` = p_fecha_resolucion, `numero_resolucion` = p_numero_resolucion, `serie` = p_serie, `desde` = p_desde,
`hasta` = p_hasta, `disponibles` = p_disponibles, `idcomprobante` = p_idcomprobante
WHERE `idtiraje` = p_idtiraje;
END //
DELIMITER ;

 -- Comprobante



 -- Clientes

DROP PROCEDURE IF EXISTS sp_insert_cliente;
DELIMITER //
CREATE PROCEDURE sp_insert_cliente(
IN p_nombre_cliente varchar(150),
IN p_clave_rfc varchar(20),
IN p_regimen_fiscal varchar(14),
IN p_direccion_cliente varchar(100),
IN p_numero_telefono varchar(20),
IN p_email varchar(80),
IN p_giro varchar(80),
IN p_limite_credito decimal(8,2)
)
BEGIN
	IF NOT EXISTS (SELECT * FROM `cliente` WHERE `nombre_cliente` = p_nombre_cliente) THEN
			INSERT INTO `cliente`(`nombre_cliente`, `clave_rfc`,
			`regimen_fiscal`, `direccion_cliente`, `numero_telefono`, `email`, `giro`,
			`limite_credito`)
			VALUES (p_nombre_cliente, p_clave_rfc,
			p_regimen_fiscal, p_direccion_cliente, p_numero_telefono, p_email, p_giro,
			p_limite_credito);
	END IF;
END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_view_cliente;
DELIMITER //
CREATE PROCEDURE sp_view_cliente()
BEGIN
SELECT `idcliente`, `codigo_cliente`, `nombre_cliente`, `clave_rfc`,
`regimen_fiscal`, `direccion_cliente`, `numero_telefono`, `email`,
`giro`, `limite_credito`, `estado`
FROM `cliente`;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_cliente_activo;
DELIMITER //
CREATE PROCEDURE sp_view_cliente_activo()
BEGIN
SELECT `idcliente`, `codigo_cliente`, `nombre_cliente`, `clave_rfc`,
`regimen_fiscal`, `direccion_cliente`, `numero_telefono`, `email`,
`giro`, `limite_credito`, `estado`
FROM `cliente` WHERE `estado` = 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_cliente_inactivo;
DELIMITER //
CREATE PROCEDURE sp_view_cliente_inactivo()
BEGIN
SELECT `idcliente`, `codigo_cliente`, `nombre_cliente`, `clave_rfc`,
`regimen_fiscal`, `direccion_cliente`, `numero_telefono`, `email`,
`giro`, `limite_credito`, `estado`
FROM `cliente` WHERE `estado` = 0;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_cliente;
DELIMITER //
CREATE PROCEDURE sp_update_cliente(
IN p_idcliente int(11),
IN p_nombre_cliente varchar(150),
IN p_clave_rfc varchar(20),
IN p_regimen_fiscal varchar(14),
IN p_direccion_cliente varchar(100),
IN p_numero_telefono varchar(20),
IN p_email varchar(80),
IN p_giro varchar(80),
IN p_limite_credito decimal(8,2),
IN p_estado tinyint(1)
)
BEGIN
UPDATE `cliente`
SET  `nombre_cliente` = p_nombre_cliente, `clave_rfc` = p_clave_rfc, `regimen_fiscal` = p_regimen_fiscal,
`direccion_cliente` = p_direccion_cliente, `numero_telefono` = p_numero_telefono, `email` = p_email,
`giro` = p_giro, `limite_credito` = p_limite_credito,
`estado` = p_estado
WHERE `idcliente` = p_idcliente;
END //
DELIMITER ;





 -- Clientes


 -- Inventario

DROP PROCEDURE IF EXISTS sp_view_entradas;
DELIMITER //
CREATE PROCEDURE sp_view_entradas(
	IN p_mes varchar(7)
)
BEGIN
    IF (p_mes!='') THEN

		SELECT * FROM view_full_entradas WHERE DATE_FORMAT(fecha_entrada,'%Y-%m') = p_mes
		ORDER BY idproducto;

	ELSE

		SELECT * FROM view_full_entradas WHERE DATE_FORMAT(fecha_entrada,'%Y-%m') = DATE_FORMAT(CURDATE(),'%Y-%m')
		ORDER BY idproducto;

    END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_salidas;
DELIMITER //
CREATE PROCEDURE sp_view_salidas(
	IN p_mes varchar(7)
)
BEGIN
    IF (p_mes!='') THEN

		SELECT * FROM view_full_salidas WHERE DATE_FORMAT(fecha_salida,'%Y-%m') = p_mes
		ORDER BY idproducto;

	ELSE

		SELECT * FROM view_full_salidas WHERE DATE_FORMAT(fecha_salida,'%Y-%m') = DATE_FORMAT(CURDATE(),'%Y-%m')
		ORDER BY idproducto;

    END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_entrada;
DELIMITER //
CREATE PROCEDURE sp_insert_entrada(
IN p_descripcion_entrada varchar(150),
IN p_cantidad_entrada decimal(8,2),
IN p_idproducto int(11)
)
BEGIN

	DECLARE p_precio_unitario_entrada decimal(8,2);
    DECLARE p_costo_total_entrada decimal(8,2);

    SET p_precio_unitario_entrada = (SELECT precio_compra FROM producto WHERE idproducto = p_idproducto);
    SET p_costo_total_entrada = (p_precio_unitario_entrada * p_cantidad_entrada);

	INSERT INTO `entrada`(`mes_inventario`,`fecha_entrada`, `descripcion_entrada`, `cantidad_entrada`,
	`precio_unitario_entrada`, `costo_total_entrada`, `idproducto`, `idcompra`)
	VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),CURDATE(), p_descripcion_entrada, p_cantidad_entrada,
	p_precio_unitario_entrada, p_costo_total_entrada, p_idproducto, NULL);

	UPDATE `inventario` SET
	`saldo_final` = `saldo_final` + p_cantidad_entrada,
    `entradas` = `entradas` + p_cantidad_entrada
	WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
	AND fecha_cierre = LAST_DAY(CURDATE());

	UPDATE `producto` SET
	`stock` = `stock` + p_cantidad_entrada
	WHERE idproducto = p_idproducto;


END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_insert_salida;
DELIMITER //
CREATE PROCEDURE sp_insert_salida(
IN p_descripcion_salida varchar(150),
IN p_cantidad_salida decimal(8,2),
IN p_idproducto int(11)
)
BEGIN

	DECLARE p_precio_unitario_salida decimal(8,2);
	DECLARE p_costo_total_salida decimal(8,2);

	SET p_precio_unitario_salida = (SELECT precio_compra FROM producto WHERE idproducto = p_idproducto);
	SET p_costo_total_salida = (p_precio_unitario_salida * p_cantidad_salida);

	INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
	`precio_unitario_salida`, `costo_total_salida`, `idproducto`, `idventa`)
	VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),CURDATE(), p_descripcion_salida, p_cantidad_salida,
	p_precio_unitario_salida, p_costo_total_salida, p_idproducto, NULL);

	UPDATE `inventario` SET
	`saldo_final` = `saldo_final` - p_cantidad_salida,
    `salidas` = `salidas` + p_cantidad_salida
	WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
	AND fecha_cierre = LAST_DAY(CURDATE());

	UPDATE `producto` SET
	`stock` = `stock` - p_cantidad_salida
	WHERE idproducto = p_idproducto;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_abrir_inventario;
DELIMITER //
CREATE PROCEDURE sp_abrir_inventario()
BEGIN
  DECLARE producto_count INT;
  SET producto_count = (SELECT COUNT(*) FROM producto);

    IF(producto_count != 0)THEN
	   IF NOT EXISTS (SELECT * FROM inventario WHERE fecha_apertura = DATE_FORMAT(CURDATE(),'%Y-%m-01')
	   AND fecha_cierre = LAST_DAY(CURDATE())) THEN

			 INSERT INTO `inventario`(`mes_inventario`,`fecha_apertura`, `fecha_cierre`,
			`saldo_inicial`, `entradas`, `salidas`, `saldo_final`, `estado`, `idproducto`)
			 SELECT DATE_FORMAT(CURDATE(),'%Y-%m'),DATE_FORMAT(CURDATE(),'%Y-%m-01'),LAST_DAY(CURDATE()),stock,
             0.00,0.00,stock, 1 ,idproducto
			 FROM producto WHERE estado = 1;

			 SELECT "ABIERTO" as respuesta;

			ELSE

			 UPDATE `inventario` SET
			`estado` = 1 WHERE `estado` = 0
			AND fecha_apertura = DATE_FORMAT(CURDATE(),'%Y-%m-01')
			AND fecha_cierre = LAST_DAY(CURDATE());

			SELECT "YA ABIERTO" as respuesta;

	   END IF;

       ELSE

		SELECT "SIN PRODUCTOS" as respuesta;

	END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_sacar_vencidos;
DELIMITER //
CREATE PROCEDURE sp_sacar_vencidos()
	BEGIN

		UPDATE `perecedero` SET
		`estado` = 0 WHERE `estado` = 1
         AND fecha_vencimiento < CURDATE();

	END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_cerrar_inventario;
DELIMITER //
CREATE PROCEDURE sp_cerrar_inventario()
	BEGIN

		UPDATE `inventario` SET
		`estado` = 0 WHERE `estado` = 1
        AND fecha_apertura != DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND fecha_cierre != LAST_DAY(CURDATE()) ;



	END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_cerrar_inventario_manual;
DELIMITER //
CREATE PROCEDURE sp_cerrar_inventario_manual()
	BEGIN

		UPDATE `inventario` SET
		`estado` = 0 WHERE `estado` = 1
        AND fecha_apertura = DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND fecha_cierre = LAST_DAY(CURDATE()) ;

		SELECT "CERRADO" as respuesta;

	END //
DELIMITER ;




DROP PROCEDURE IF EXISTS sp_validar_inventario;
DELIMITER //
CREATE PROCEDURE sp_validar_inventario()
	BEGIN

	  DECLARE producto_count INT;
      DECLARE count_inventario INT;
	  SET producto_count = (SELECT COUNT(*) FROM producto);
      SET count_inventario = (SELECT COUNT(*) FROM inventario
      WHERE fecha_apertura = DATE_FORMAT(CURDATE(),'%Y-%m-01')
      AND fecha_cierre = LAST_DAY(CURDATE()) AND estado = 1);

      IF(producto_count != 0)THEN

			IF(count_inventario != 0) THEN

				SELECT "VALIDADO" as respuesta;

			ELSE

				SELECT "NO EXISTE" as respuesta;

            END IF;

        ELSE

		SELECT "SIN PRODUCTOS" as respuesta;

	 END IF;

	END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_kardex_inventario;
DELIMITER //
CREATE PROCEDURE sp_kardex_inventario(
	IN p_mes varchar(7)
)
BEGIN

	IF p_mes = '' THEN

        SELECT * FROM view_kardex WHERE mes_inventario = DATE_FORMAT(CURDATE(),'%Y-%m')
        ORDER BY idproducto;

	 ELSE

		SELECT * FROM view_kardex WHERE mes_inventario = p_mes  ORDER BY idproducto;

    END IF;
END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_kardex_inventario;
DELIMITER //
CREATE PROCEDURE sp_kardex_inventario(
	IN p_mes varchar(7)
)
BEGIN

	IF p_mes = '' THEN

        SELECT * FROM view_kardex WHERE mes_inventario = DATE_FORMAT(CURDATE(),'%Y-%m')
        ORDER BY idproducto;

	 ELSE

		SELECT * FROM view_kardex WHERE mes_inventario = p_mes  ORDER BY idproducto;

    END IF;
END //
DELIMITER ;

 -- Inventario

 -- Venta

DROP PROCEDURE IF EXISTS sp_view_tiraje_activo;
DELIMITER //
CREATE PROCEDURE sp_view_tiraje_activo()
BEGIN
SELECT idcomprobante, nombre_comprobante FROM view_comprobantes WHERE estado = 1 AND
disponibles > 0;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_venta;
DELIMITER //
CREATE PROCEDURE sp_insert_venta(
IN p_tipo_pago varchar(75),
IN p_tipo_comprobante tinyint(1),
IN p_sumas decimal(8,2),
IN p_iva decimal(8,2),
IN p_exento decimal(8,2),
IN p_retenido decimal(8,2),
IN p_descuento decimal(8,2),
IN p_total decimal(8,2),
IN p_sonletras varchar(150),
IN p_pago_efectivo decimal(8,2),
IN p_pago_tarjeta decimal(8,2),
IN p_numero_tarjeta varchar(16),
IN p_tarjeta_habiente varchar(90),
IN p_cambio decimal(8,2),
IN p_estado tinyint(1),
IN p_idcliente int(11),
IN p_idusuario int(11)
)
BEGIN

	DECLARE p_numero_comprobante INT;
    DECLARE p_efectivo_caja DECIMAL(8,2);
    DECLARE p_abono_credito DECIMAL(8,2);
	SET p_numero_comprobante = (SELECT usados + 1 FROM view_comprobantes WHERE idcomprobante = p_tipo_comprobante);



		  IF NOT EXISTS (SELECT * FROM venta WHERE `numero_comprobante` = p_numero_comprobante
		  AND `tipo_comprobante` = p_tipo_comprobante AND `fecha_venta` = NOW()) THEN

			  IF p_estado = '1' THEN

              IF p_idcliente = '0' THEN

			    IF p_numero_comprobante = '0' THEN

					INSERT INTO `venta`(`fecha_venta`, `tipo_pago`,
					`numero_comprobante`, `tipo_comprobante`, `sumas`, `iva`,
					`exento`, `retenido`, `descuento`, `total`,
					`sonletras`, `pago_efectivo`, `pago_tarjeta`, `numero_tarjeta`,
					`tarjeta_habiente`, `cambio`, `estado`, `idcliente`, `idusuario`)
					VALUES (NOW(), p_tipo_pago,
					1, p_tipo_comprobante, p_sumas, p_iva,
					p_exento, p_retenido, p_descuento, p_total,
					p_sonletras, p_pago_efectivo, p_pago_tarjeta, p_numero_tarjeta,
					p_tarjeta_habiente, p_cambio, p_estado, NULL, p_idusuario);
                    
					UPDATE `tiraje_comprobante` SET
					`disponibles` = `disponibles` - 1
					WHERE idcomprobante = p_tipo_comprobante;


					IF (p_tipo_pago = 'EFECTIVO') THEN
						CALL sp_insert_caja_venta(p_total);
					ELSEIF (p_tipo_pago = 'EFECTIVO Y TARJETA') THEN
						CALL sp_insert_caja_venta(p_pago_efectivo);
					END IF;

				ELSE

					INSERT INTO `venta`(`fecha_venta`, `tipo_pago`,
					`numero_comprobante`, `tipo_comprobante`, `sumas`, `iva`,
					`exento`, `retenido`, `descuento`, `total`,
					`sonletras`, `pago_efectivo`, `pago_tarjeta`, `numero_tarjeta`,
					`tarjeta_habiente`, `cambio`, `estado`, `idcliente`, `idusuario`)
					VALUES (NOW(), p_tipo_pago,
					p_numero_comprobante, p_tipo_comprobante, p_sumas, p_iva,
					p_exento, p_retenido, p_descuento, p_total,
					p_sonletras, p_pago_efectivo, p_pago_tarjeta, p_numero_tarjeta,
					p_tarjeta_habiente, p_cambio, p_estado, NULL, p_idusuario);
                    
					UPDATE `tiraje_comprobante` SET
					`disponibles` = `disponibles` - 1
					WHERE idcomprobante = p_tipo_comprobante;


					IF (p_tipo_pago = 'EFECTIVO') THEN
						CALL sp_insert_caja_venta(p_total);
					ELSEIF (p_tipo_pago = 'EFECTIVO Y TARJETA') THEN
						CALL sp_insert_caja_venta(p_pago_efectivo);
					END IF;

				END IF;

			   ELSE

				IF p_numero_comprobante = '0' THEN

					INSERT INTO `venta`(`fecha_venta`, `tipo_pago`,
					`numero_comprobante`, `tipo_comprobante`, `sumas`, `iva`,
					`exento`, `retenido`, `descuento`, `total`,
					`sonletras`, `pago_efectivo`, `pago_tarjeta`, `numero_tarjeta`,
					`tarjeta_habiente`, `cambio`, `estado`, `idcliente`, `idusuario`)
					VALUES (NOW(), p_tipo_pago,
					1, p_tipo_comprobante, p_sumas, p_iva,
					p_exento, p_retenido, p_descuento, p_total,
					p_sonletras, p_pago_efectivo, p_pago_tarjeta, p_numero_tarjeta,
					p_tarjeta_habiente, p_cambio, p_estado, p_idcliente, p_idusuario);
                    
					UPDATE `tiraje_comprobante` SET
					`disponibles` = `disponibles` - 1
					WHERE idcomprobante = p_tipo_comprobante;


					IF (p_tipo_pago = 'EFECTIVO') THEN
						CALL sp_insert_caja_venta(p_total);
					ELSEIF (p_tipo_pago = 'EFECTIVO Y TARJETA') THEN
						CALL sp_insert_caja_venta(p_pago_efectivo);
					END IF;

				ELSE

					INSERT INTO `venta`(`fecha_venta`, `tipo_pago`,
					`numero_comprobante`, `tipo_comprobante`, `sumas`, `iva`,
					`exento`, `retenido`, `descuento`, `total`,
					`sonletras`, `pago_efectivo`, `pago_tarjeta`, `numero_tarjeta`,
					`tarjeta_habiente`, `cambio`, `estado`, `idcliente`, `idusuario`)
					VALUES (NOW(), p_tipo_pago,
					p_numero_comprobante, p_tipo_comprobante, p_sumas, p_iva,
					p_exento, p_retenido, p_descuento, p_total,
					p_sonletras, p_pago_efectivo, p_pago_tarjeta, p_numero_tarjeta,
					p_tarjeta_habiente, p_cambio, p_estado, p_idcliente, p_idusuario);
                    
					UPDATE `tiraje_comprobante` SET
					`disponibles` = `disponibles` - 1
					WHERE idcomprobante = p_tipo_comprobante;


					IF (p_tipo_pago = 'EFECTIVO') THEN
						CALL sp_insert_caja_venta(p_total);
					ELSEIF (p_tipo_pago = 'EFECTIVO Y TARJETA') THEN
						CALL sp_insert_caja_venta(p_pago_efectivo);
					END IF;

				END IF;


			  END IF;


            ELSEIF p_estado = '2' THEN

            IF p_numero_comprobante = '0' THEN

				INSERT INTO `venta`(`fecha_venta`, `tipo_pago`,
				`numero_comprobante`, `tipo_comprobante`, `sumas`, `iva`,
				`exento`, `retenido`, `descuento`, `total`,
				`sonletras`, `pago_efectivo`, `pago_tarjeta`, `numero_tarjeta`,
				`tarjeta_habiente`, `cambio`, `estado`, `idcliente`, `idusuario`)
				VALUES (NOW(), p_tipo_pago,
				1, p_tipo_comprobante, p_sumas, p_iva,
				p_exento, p_retenido, p_descuento, p_total,
				p_sonletras, 0.00, 0.00, NULL, 0.00, 0.00, p_estado, p_idcliente, p_idusuario);

				UPDATE `tiraje_comprobante` SET
				`disponibles` = `disponibles` - 1
				WHERE idcomprobante = p_tipo_comprobante;

                CALL sp_insert_credito_venta(p_total, p_idcliente);

                ELSE

				INSERT INTO `venta`(`fecha_venta`, `tipo_pago`,
				`numero_comprobante`, `tipo_comprobante`, `sumas`, `iva`,
				`exento`, `retenido`, `descuento`, `total`,
				`sonletras`, `pago_efectivo`, `pago_tarjeta`, `numero_tarjeta`,
				`tarjeta_habiente`, `cambio`, `estado`, `idcliente`, `idusuario`)
				VALUES (NOW(), p_tipo_pago,
				p_numero_comprobante, p_tipo_comprobante, p_sumas, p_iva,
				p_exento, p_retenido, p_descuento, p_total,
				p_sonletras, 0.00, 0.00, NULL, 0.00, 0.00, p_estado, p_idcliente, p_idusuario);

				UPDATE `tiraje_comprobante` SET
				`disponibles` = `disponibles` - 1
				WHERE idcomprobante = p_tipo_comprobante;

                CALL sp_insert_credito_venta(p_total, p_idcliente);

			END IF;

			END IF;

		END IF;
END //
DELIMITER ;






DROP PROCEDURE IF EXISTS sp_descontar_perecedero;
DELIMITER //
CREATE PROCEDURE sp_descontar_perecedero(
IN p_idproducto int(11),
IN p_cantidad decimal(8,2),
IN p_fecha_vencimiento date
)
BEGIN

    DECLARE p_cantidad_perecedero DECIMAL(8,2);
    DECLARE p_resta DECIMAL(8,2);

	SET p_cantidad_perecedero = (SELECT cantidad_perecedero FROM perecedero WHERE
    idproducto = p_idproducto AND cantidad_perecedero > 0.00
    AND fecha_vencimiento = p_fecha_vencimiento);

    SET p_resta = p_cantidad_perecedero - p_cantidad;

    IF p_resta = 0 THEN

        UPDATE perecedero SET
		cantidad_perecedero = 0.00,
        estado = 2
        WHERE idproducto = p_idproducto AND fecha_vencimiento = p_fecha_vencimiento;

     ELSE

		UPDATE perecedero SET
		cantidad_perecedero = p_resta
        WHERE idproducto = p_idproducto AND fecha_vencimiento = p_fecha_vencimiento;

    END IF;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_fechas_vencimiento;
DELIMITER //
CREATE PROCEDURE sp_fechas_vencimiento(
IN p_idproducto int(11)
)
BEGIN

   SELECT cantidad_perecedero, DATE_FORMAT(fecha_vencimiento,'%d/%m/%Y') as fecha_vencimiento FROM perecedero
   WHERE idproducto = p_idproducto
   AND estado = 1 ORDER by fecha_vencimiento ASC;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_fechas_vencimiento;
DELIMITER //
CREATE PROCEDURE sp_fechas_vencimiento(
IN p_idproducto int(11)
)
BEGIN

   SELECT cantidad_perecedero, DATE_FORMAT(fecha_vencimiento,'%d/%m/%Y') as fecha_vencimiento FROM perecedero
   WHERE idproducto = p_idproducto
   AND estado = 1 ORDER by fecha_vencimiento ASC;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_limite_credito;
DELIMITER //
CREATE PROCEDURE sp_view_limite_credito(
IN p_idcliente int(11)
)
BEGIN

  SELECT limite_credito FROM cliente
  WHERE idcliente = p_idcliente LIMIT 1;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_insert_detalleventa;
DELIMITER //
CREATE PROCEDURE sp_insert_detalleventa(
IN p_idproducto int(11),
IN p_cantidad decimal(8,2),
IN p_precio_unitario decimal(8,2),
IN p_exento decimal(8,2),
IN p_descuento decimal(8,2),
IN p_fecha_vence date,
IN p_importe decimal(8,2)
)
BEGIN

	DECLARE p_idventa int(11);
    DECLARE p_idcomprobante int(11);
    DECLARE p_tipo_comprobante TINYINT(1);
	DECLARE p_comprobante	varchar(75);
    DECLARE p_precio_compra DECIMAL(8,2);
    DECLARE p_costo DECIMAL(8,2);
    DECLARE p_total DECIMAL(8,2);
    DECLARE p_numero_comprobante varchar(60);
    DECLARE p_descr_salida varchar(150);
    DECLARE p_inventariable int(11);
    DECLARE	p_estado tinyint(1);
    DECLARE p_stock DECIMAL(8,2);
    DECLARE p_cantidad_perecedero DECIMAL(8,2);


    SET p_idventa = (SELECT MAX(idventa) FROM venta);
    SET p_total = (SELECT total FROM venta WHERE idventa = p_idventa);
    SET p_precio_compra = (SELECT precio_compra FROM producto WHERE idproducto = p_idproducto);

    SET p_costo = (p_cantidad * p_precio_compra);

    SET p_tipo_comprobante = (SELECT tipo_comprobante FROM venta WHERE idventa = p_idventa);
    SET p_numero_comprobante = (SELECT numero_comprobante FROM venta WHERE idventa = p_idventa);
    SET p_comprobante = (SELECT nombre_comprobante FROM comprobante WHERE idcomprobante = p_tipo_comprobante);
    SET p_descr_salida = (CONCAT('POR VENTA',' ', p_comprobante,' # ',p_numero_comprobante));
    SET p_inventariable = (SELECT inventariable FROM producto WHERE idproducto = p_idproducto);
    SET p_estado = (SELECT estado FROM venta WHERE idventa = p_idventa);
    SET p_cantidad_perecedero = (SELECT cantidad_perecedero FROM perecedero WHERE idproducto = p_idproducto
    AND fecha_vencimiento = p_fecha_vence AND estado = 1);
    SET p_stock = (SELECT stock FROM producto WHERE idproducto = p_idproducto);

		IF (p_inventariable  = 0) THEN

			IF p_idventa IS NULL OR p_idventa = '' THEN

				INSERT INTO `detalleventa`(`idventa`, `idproducto`, `cantidad`, `precio_unitario`,
				`fecha_vence`, `exento`, `descuento`, `importe`)
				VALUES (1, p_idproducto, p_cantidad, p_precio_unitario,
				NULL, p_exento, p_descuento, p_importe);


				ELSE

				INSERT INTO `detalleventa`(`idventa`, `idproducto`, `cantidad`, `precio_unitario`,
				`fecha_vence`, `exento`, `descuento`, `importe`)
				VALUES (p_idventa, p_idproducto, p_cantidad, p_precio_unitario,
				NULL, p_exento, p_descuento, p_importe);

			END IF; -- IF p_idventa IS NULL OR p_idventa = '' THEN


		ELSE -- ELSE p_inventariable  = 0

			IF (p_fecha_vence != '2000-01-01') THEN

				IF p_idventa IS NULL OR p_idventa = '' THEN

                    IF (p_stock > 0) THEN

							INSERT INTO `detalleventa`(`idventa`, `idproducto`, `cantidad`, `precio_unitario`,
							`fecha_vence`, `exento`, `descuento`, `importe`)
							VALUES (1, p_idproducto, p_cantidad, p_precio_unitario,
							p_fecha_vence, p_exento, p_descuento, p_importe);

							INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
							`precio_unitario_salida`, `costo_total_salida`,`idproducto`,`idventa`)
							VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_salida,p_cantidad,p_precio_compra,p_costo,p_idproducto,1);

							UPDATE `inventario` SET
							`saldo_final` = `saldo_final` - p_cantidad,
							`salidas` = `salidas` + p_cantidad
							WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
							AND fecha_cierre = LAST_DAY(CURDATE());

							CALL sp_descontar_perecedero(p_idproducto, p_cantidad, p_fecha_vence);

							UPDATE `producto` SET
							`stock` = `stock` - p_cantidad
							WHERE idproducto = p_idproducto;

                    END IF; -- IF p_stock > 0;

			ELSE -- ELSE p_idventa IS NULL OR p_idventa = ''

					 IF (p_stock > 0) THEN

							INSERT INTO `detalleventa`(`idventa`, `idproducto`, `cantidad`, `precio_unitario`,
							`fecha_vence`, `exento`, `descuento`, `importe`)
							VALUES (p_idventa, p_idproducto, p_cantidad, p_precio_unitario,
							p_fecha_vence, p_exento, p_descuento, p_importe);

							INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
							`precio_unitario_salida`, `costo_total_salida`,`idproducto`,`idventa`)
							VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_salida,p_cantidad,p_precio_compra,p_costo,p_idproducto,p_idventa);

							UPDATE `inventario` SET
							`saldo_final` = `saldo_final` - p_cantidad,
							`salidas` = `salidas` + p_cantidad
							WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
							AND fecha_cierre = LAST_DAY(CURDATE());

							CALL sp_descontar_perecedero(p_idproducto, p_cantidad, p_fecha_vence);

							UPDATE `producto` SET
							`stock` = `stock` - p_cantidad
							WHERE idproducto = p_idproducto;

						END IF; -- IF p_stock > 0;

					END IF; -- IF p_idventa IS NULL OR p_idventa = ''

				ELSE  -- ELSE p_fecha_vencimiento != '2000-01-01'

                IF p_idventa IS NULL OR p_idventa = '' THEN

                    IF (p_stock > 0) THEN

							INSERT INTO `detalleventa`(`idventa`, `idproducto`, `cantidad`, `precio_unitario`,
							`fecha_vence`, `exento`, `descuento`, `importe`)
							VALUES (1, p_idproducto, p_cantidad, p_precio_unitario,
							NULL, p_exento, p_descuento, p_importe);

							INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
							`precio_unitario_salida`, `costo_total_salida`,`idproducto`,`idventa`)
							VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_salida,p_cantidad,p_precio_compra,p_costo,p_idproducto,1);

							UPDATE `inventario` SET
							`saldo_final` = `saldo_final` - p_cantidad,
							`salidas` = `salidas` + p_cantidad
							WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
							AND fecha_cierre = LAST_DAY(CURDATE());


							UPDATE `producto` SET
							`stock` = `stock` - p_cantidad
							WHERE idproducto = p_idproducto;

                    END IF; -- IF p_stock > 0;

			ELSE -- ELSE p_idventa IS NULL OR p_idventa = ''

					 IF (p_stock > 0) THEN

							INSERT INTO `detalleventa`(`idventa`, `idproducto`, `cantidad`, `precio_unitario`,
							`fecha_vence`, `exento`, `descuento`, `importe`)
							VALUES (p_idventa, p_idproducto, p_cantidad, p_precio_unitario,
							NULL, p_exento, p_descuento, p_importe);

							INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
							`precio_unitario_salida`, `costo_total_salida`,`idproducto`,`idventa`)
							VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_salida,p_cantidad,p_precio_compra,p_costo,p_idproducto,p_idventa);

							UPDATE `inventario` SET
							`saldo_final` = `saldo_final` - p_cantidad,
							`salidas` = `salidas` + p_cantidad
							WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
							AND fecha_cierre = LAST_DAY(CURDATE());


							UPDATE `producto` SET
							`stock` = `stock` - p_cantidad
							WHERE idproducto = p_idproducto;

						END IF; -- IF p_stock > 0;

					END IF; -- IF p_idventa IS NULL OR p_idventa = ''

			END IF; -- IF p_fecha_vencimiento != '2000-01-01'

		END IF;  -- IF p_inventariable  = 0

END //
DELIMITER ;


 -- Venta


 -- Caja

DROP PROCEDURE IF EXISTS sp_validar_caja;
DELIMITER //
CREATE PROCEDURE sp_validar_caja()
	BEGIN
		SELECT * FROM caja WHERE DATE(fecha_apertura) = CURDATE()
        AND estado = 1;
	END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_abrir_caja;
DELIMITER //
CREATE PROCEDURE sp_abrir_caja(
IN p_monto_apertura decimal(8,2)
)
BEGIN
	  IF NOT EXISTS (SELECT * FROM `caja` WHERE DATE_FORMAT(`fecha_apertura`,'%Y-%m-%d') = curdate()) THEN
		INSERT INTO `caja`(`fecha_apertura`, `monto_apertura`)
		VALUES (NOW(), p_monto_apertura);
			ELSE
        UPDATE `caja` SET
        `estado` = 1
        WHERE DATE_FORMAT(`fecha_apertura`,'%Y-%m-%d') = curdate();
	  END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_monto_inicial;
DELIMITER //
CREATE PROCEDURE sp_update_monto_inicial(
	IN p_monto_apertura decimal(8,2)
)
BEGIN
	IF EXISTS (SELECT * FROM `caja` WHERE DATE_FORMAT(`fecha_apertura`,'%Y-%m-%d') = curdate()) THEN
		UPDATE `caja` SET
        `monto_apertura` =  p_monto_apertura
		WHERE DATE_FORMAT(`fecha_apertura`,'%Y-%m-%d') = curdate();
	END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_cerrar_caja;
DELIMITER //
CREATE PROCEDURE sp_cerrar_caja(
 IN p_monto_cierre decimal(8,2)
)
BEGIN

   DECLARE p_idcaja int(11);
   SET p_idcaja = (SELECT idcaja FROM `caja` WHERE DATE(fecha_apertura) = CURDATE());

	UPDATE `caja` SET
    `monto_cierre` = p_monto_cierre,
    `fecha_cierre` = NOW(),
    `estado` = 0
     WHERE idcaja = p_idcaja;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_caja_movimiento;
DELIMITER //
CREATE PROCEDURE sp_insert_caja_movimiento(
IN p_tipo_movimiento tinyint(1),
IN p_monto_movimiento decimal(8,2),
IN p_descripcion_movimiento varchar(80)
)
BEGIN
    DECLARE p_idcaja int(11);
    DECLARE p_tipo_comprobante tinyint(1);
    DECLARE p_numero_comprobante int(11);

    SET p_idcaja = (SELECT idcaja FROM `caja` WHERE DATE(fecha_apertura) = CURDATE());


	INSERT INTO `caja_movimiento`(`idcaja`, `tipo_movimiento`, `monto_movimiento`,
    `descripcion_movimiento`,`fecha_movimiento`) VALUES (p_idcaja, p_tipo_movimiento, p_monto_movimiento,
     p_descripcion_movimiento,curdate());


END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_caja_venta;
DELIMITER //
CREATE PROCEDURE sp_insert_caja_venta(
IN p_monto_movimiento decimal(8,2)
)
BEGIN
	DECLARE p_idventa int(11);
    DECLARE p_idcaja int(11);
    DECLARE p_tipo_comprobante tinyint(1);
    DECLARE p_numero_comprobante int(11);
    DECLARE p_descripcion_movimiento varchar(80);

    SET p_idventa = (SELECT max(idventa) FROM venta);
    SET p_idcaja = (SELECT idcaja FROM `caja` WHERE DATE(fecha_apertura) = CURDATE());
    SET p_tipo_comprobante = (SELECT tipo_comprobante FROM `venta` WHERE idventa = p_idventa);
    SET p_numero_comprobante = (SELECT numero_comprobante FROM `venta` WHERE idventa = p_idventa);

    IF p_tipo_comprobante = 1 THEN
	SET p_descripcion_movimiento = (CONCAT('POR VENTA',' ','TICKET', ' # ',p_numero_comprobante));
	INSERT INTO `caja_movimiento`(`idcaja`, `tipo_movimiento`, `monto_movimiento`,
    `descripcion_movimiento`,`fecha_movimiento`) VALUES (p_idcaja, 1, p_monto_movimiento,
	p_descripcion_movimiento,curdate());
	ELSEIF p_tipo_comprobante = 2 THEN
     SET p_descripcion_movimiento = (CONCAT('POR VENTA',' ','FACTURA', ' # ',p_numero_comprobante));
	INSERT INTO `caja_movimiento`(`idcaja`, `tipo_movimiento`, `monto_movimiento`,
    `descripcion_movimiento`,`fecha_movimiento`) VALUES (p_idcaja, 1, p_monto_movimiento,
	p_descripcion_movimiento,curdate());
	ELSEIF p_tipo_comprobante = 3 THEN
     SET p_descripcion_movimiento = (CONCAT('POR VENTA',' ','CREDITO FISCAL', ' # ',p_numero_comprobante));
	INSERT INTO `caja_movimiento`(`idcaja`, `tipo_movimiento`, `monto_movimiento`,
    `descripcion_movimiento`,`fecha_movimiento`) VALUES (p_idcaja,1, p_monto_movimiento,
	p_descripcion_movimiento,curdate());
    END IF;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_caja_apartado;
DELIMITER //
CREATE PROCEDURE sp_insert_caja_apartado(
IN p_monto_movimiento decimal(8,2)
)
BEGIN

	
    DECLARE p_idcaja int(11);
    DECLARE p_descripcion_movimiento varchar(80);
    DECLARE p_numero_apartado varchar(175);

    SET p_numero_apartado = (SELECT max(numero_apartado) FROM apartado);
    SET p_idcaja = (SELECT idcaja FROM `caja` WHERE DATE(fecha_apertura) = CURDATE());
	SET p_descripcion_movimiento = (CONCAT('POR APARTADO #',' ',p_numero_apartado));

	INSERT INTO `caja_movimiento`(`idcaja`, `tipo_movimiento`, `monto_movimiento`,
    `descripcion_movimiento`,`fecha_movimiento`) VALUES (p_idcaja, 1, p_monto_movimiento,
	 p_descripcion_movimiento,curdate());

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_movimientos_caja;
DELIMITER //
CREATE PROCEDURE sp_view_movimientos_caja()
BEGIN

   DECLARE p_ingresos decimal(8,2);
   DECLARE p_ingresos_totales decimal(8,2);
   DECLARE p_devoluciones decimal(8,2);
   DECLARE p_prestamos decimal(8,2);
   DECLARE p_gastos decimal(8,2);
   DECLARE p_egresos decimal(8,2);
   DECLARE p_saldo decimal(8,2);
   DECLARE p_diferencia decimal(8,2);
   DECLARE p_total_movimiento decimal(8,2);
   DECLARE p_monto_inicial decimal(8,2);

   DECLARE c_ingresos int;
   DECLARE c_devoluciones int;
   DECLARE c_prestamos int;
   DECLARE c_gastos int;


   SET p_ingresos = (SELECT SUM(monto_movimiento) FROM view_caja WHERE
   DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 1);

   SET p_devoluciones = (SELECT SUM(monto_movimiento) FROM view_caja WHERE
   DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 2);

   SET p_prestamos = (SELECT SUM(monto_movimiento) FROM view_caja WHERE
   DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 3);

   SET p_gastos = (SELECT SUM(monto_movimiento) FROM view_caja WHERE
   DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 4);

   SET p_monto_inicial = (SELECT monto_apertura FROM caja WHERE DATE(fecha_apertura) = CURDATE());


   SET c_ingresos = (SELECT COUNT(*) FROM view_caja WHERE
   DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 1);

   SET c_devoluciones = (SELECT COUNT(*) FROM view_caja WHERE
   DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 2);

   SET c_prestamos = (SELECT COUNT(*) FROM view_caja WHERE
   DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 3);

   SET c_gastos = (SELECT COUNT(*) FROM view_caja WHERE
   DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 4);

   IF (p_ingresos IS NULL) THEN
		SET p_ingresos = (0.00);
   END IF;

   IF (p_devoluciones IS NULL) THEN
      SET p_devoluciones = (0.00);
   END IF;

   IF (p_gastos IS NULL) THEN
     SET p_gastos = (0.00);
   END IF;

   IF (p_prestamos IS NULL) THEN
     SET p_prestamos = (0.00);
   END IF;

   SET p_egresos = (p_prestamos + p_gastos);
   SET p_ingresos_totales = (p_ingresos +  p_devoluciones);
   SET p_saldo = (p_ingresos - p_egresos +  p_devoluciones);
   SET p_total_movimiento = (p_ingresos + p_egresos);
   SET p_diferencia = (p_monto_inicial + p_saldo);

   SELECT p_ingresos, p_devoluciones , p_prestamos , p_gastos, p_egresos, p_saldo, p_total_movimiento,
   c_ingresos, c_devoluciones , c_prestamos , c_gastos, p_monto_inicial, p_diferencia, p_ingresos_totales;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_ingresos_caja;
DELIMITER //
CREATE PROCEDURE sp_view_ingresos_caja()
BEGIN
   SELECT * FROM view_caja WHERE tipo_movimiento = 1 AND DATE(fecha_apertura) = CURDATE();
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_devoluciones_caja;
DELIMITER //
CREATE PROCEDURE sp_view_devoluciones_caja()
BEGIN
   SELECT * FROM view_caja WHERE tipo_movimiento = 2 AND DATE(fecha_apertura) = CURDATE();
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_prestamos_caja;
DELIMITER //
CREATE PROCEDURE sp_view_prestamos_caja()
BEGIN
   SELECT * FROM view_caja WHERE tipo_movimiento = 3 AND DATE(fecha_apertura) = CURDATE();
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_gastos_caja;
DELIMITER //
CREATE PROCEDURE sp_view_gastos_caja()
BEGIN
   SELECT * FROM view_caja WHERE tipo_movimiento = 4 AND DATE(fecha_apertura) = CURDATE();
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_datos_caja;
DELIMITER //
CREATE PROCEDURE sp_view_datos_caja()
BEGIN
   SELECT COUNT(*) as veces_abierta, fecha_apertura, fecha_cierre , estado, monto_apertura
   FROM caja WHERE DATE(fecha_apertura) = CURDATE();
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_historico_caja;
DELIMITER //
CREATE PROCEDURE sp_historico_caja(
	IN p_date	varchar(10),
	IN p_date2  varchar(10)
)
BEGIN
    IF (p_date = '' AND p_date2 = '') THEN
		SELECT * FROM caja ORDER BY fecha_apertura DESC;
	ELSE
		 SELECT * FROM caja WHERE fecha_apertura BETWEEN p_date AND p_date2
		 ORDER BY fecha_apertura DESC;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_cerrar_caja_manual;
DELIMITER //
CREATE PROCEDURE sp_cerrar_caja_manual(
	IN p_id int
)
BEGIN
	UPDATE caja SET
    estado = 0 WHERE idcaja = p_id;
END //
DELIMITER ;

 -- Caja


-- DASHBOARD

DROP PROCEDURE IF EXISTS sp_panel_dashboard;
DELIMITER //
CREATE PROCEDURE sp_panel_dashboard()
BEGIN

	DECLARE compras_mes DECIMAL(8,2);
	DECLARE ventas_dia DECIMAL(8,2);
	DECLARE inversion_stock DECIMAL(8,2);
	DECLARE proveedores DECIMAL(8,2);
	DECLARE marcas DECIMAL(8,2);
	DECLARE presentaciones DECIMAL(8,2);
	DECLARE productos DECIMAL(8,2);
	DECLARE a_vencer DECIMAL(8,2);
    DECLARE perecederos DECIMAL(8,2);
	DECLARE clientes DECIMAL(8,2);
    DECLARE creditos DECIMAL(8,2);
	DECLARE p_ingresos decimal(8,2);
	DECLARE p_devoluciones decimal(8,2);
	DECLARE p_prestamos decimal(8,2);
	DECLARE p_gastos decimal(8,2);
	DECLARE p_egresos decimal(8,2);
	DECLARE p_saldo decimal(8,2);

    DECLARE p_monto_inicial decimal(8,2);


    SET p_ingresos = (SELECT SUM(monto_movimiento) FROM view_caja WHERE
    DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 1);

    SET p_devoluciones = (SELECT SUM(monto_movimiento) FROM view_caja WHERE
    DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 2);

    SET p_prestamos = (SELECT SUM(monto_movimiento) FROM view_caja WHERE
    DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 3);

    SET p_gastos = (SELECT SUM(monto_movimiento) FROM view_caja WHERE
    DATE(fecha_apertura) = CURDATE() AND tipo_movimiento = 4);

	IF (p_ingresos IS NULL) THEN
	   SET p_ingresos = (0.00);
	END IF;

	IF (p_devoluciones IS NULL) THEN
	   SET p_devoluciones = (0.00);
	END IF;

	IF (p_gastos IS NULL) THEN
	   SET p_gastos = (0.00);
	END IF;

	IF (p_prestamos IS NULL) THEN
	   SET p_prestamos = (0.00);
	END IF;

    SET p_egresos = (p_prestamos + p_gastos);
    SET p_saldo = (p_ingresos - p_egresos +  p_devoluciones);
    SET p_monto_inicial = (SELECT monto_apertura FROM caja WHERE DATE(fecha_apertura) = CURDATE());

	SET compras_mes = (SELECT if(SUM(total) IS NULL,0.00,SUM(total)) as compras_mes
    FROM compra  WHERE MONTH(fecha_compra) = MONTH(NOW()) AND estado=1);
    SET ventas_dia = (SELECT if(SUM(total) IS NULL,0.00, SUM(total)) as ventas_dia
    FROM venta  WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE() AND estado = 1);
    SET inversion_stock = (SELECT TRUNCATE(SUM((stock * precio_compra)),2) as costo FROM producto
    WHERE  stock > 0.00);
    SET proveedores = (SELECT COUNT(*) as numero_proveedores FROM proveedor);
    SET marcas = (SELECT COUNT(*) as numero_marcas FROM marca);
    SET presentaciones = (SELECT COUNT(*) as numero_presentaciones FROM presentacion);
    SET productos = (SELECT COUNT(*) as numero_productos FROM producto);

    SET a_vencer = (SELECT COUNT(*) FROM perecedero WHERE fecha_vencimiento
    BETWEEN CURDATE() + INTERVAL 30 DAY AND CURDATE() + INTERVAL 1 MONTH);

    SET perecederos = (SELECT COUNT(*) FROM perecedero);
    SET clientes = (SELECT COUNT(*) FROM cliente);
    SET creditos = (SELECT COUNT(*) FROM credito WHERE estado = 0);


    SELECT compras_mes,ventas_dia,inversion_stock,proveedores,marcas,presentaciones,productos,
    p_monto_inicial + p_saldo as dinero_caja, perecederos, a_vencer,clientes,creditos;


END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_compras_anual;
DELIMITER //
CREATE PROCEDURE sp_compras_anual()
BEGIN

	DECLARE count_compra INT;
    SET count_compra = (SELECT COUNT(*) FROM compra WHERE estado = 1);

	IF (count_compra > 0 ) THEN

	SELECT IF (UCASE(DATE_FORMAT(fecha_compra,'%b')) IS NULL,'0.00',
    UCASE(DATE_FORMAT(fecha_compra,'%b'))) as mes,
    IF(SUM(total) IS NULL, 0.00, SUM(total)) as total FROM compra
	WHERE YEAR(fecha_compra) = YEAR(CURDATE()) AND estado = 1 GROUP BY MONTH(fecha_compra);

    ELSE

    SELECT '-' as mes,'0.00' as total;


    END IF;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_ventas_anual;
DELIMITER //
CREATE PROCEDURE sp_ventas_anual()
BEGIN
	DECLARE count_venta INT;
    SET count_venta = (SELECT COUNT(*) FROM venta WHERE estado = 1);

	IF (count_venta > 0 ) THEN

	SELECT IF (UCASE(DATE_FORMAT(fecha_venta,'%b')) IS NULL,'0.00',
    UCASE(DATE_FORMAT(fecha_venta,'%b'))) as mes,
    IF(SUM(total) IS NULL, 0.00, SUM(total)) as total FROM venta
	WHERE YEAR(fecha_venta) = YEAR(CURDATE()) AND estado = 1 GROUP BY MONTH(fecha_venta);

    ELSE

    SELECT '-' as mes,'0.00' as total;


    END IF;

END //
DELIMITER ;

-- DASHBOARD


-- COMPRAS CONSULTAS

DROP PROCEDURE IF EXISTS sp_consulta_compras;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_compras(
		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10),
        IN p_estado varchar(2),
        IN p_pago  varchar(2)
    )
	BEGIN

		IF(p_criterio = 'MES') THEN

		  IF (p_date = '')THEN

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado_compra = p_estado
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND tipo_pago = p_pago
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado_compra = p_estado AND tipo_pago	= p_pago
					GROUP BY fecha_comprobante , numero_comprobante;

				END IF;


			ELSE

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = p_date
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = p_date
					AND estado_compra = p_estado
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = p_date
					AND tipo_pago = p_pago
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = p_date
					AND estado_compra = p_estado AND tipo_pago	= p_pago
					GROUP BY fecha_comprobante , numero_comprobante;

				END IF;

		  END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

		   IF (p_date = '' AND p_date2 ='')THEN

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado_compra = p_estado
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND tipo_pago = p_pago
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT * FROM view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado_compra = p_estado AND tipo_pago	= p_pago
					GROUP BY fecha_comprobante , numero_comprobante;

				END IF;

			ELSE

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT * FROM view_compras WHERE fecha_compra BETWEEN p_date AND p_date2
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT * FROM view_compras WHERE fecha_compra BETWEEN p_date AND p_date2
					AND estado_compra = p_estado
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT * FROM view_compras WHERE fecha_compra BETWEEN p_date AND p_date2
					AND tipo_pago = p_pago
					GROUP BY fecha_comprobante , numero_comprobante;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT * FROM view_compras WHERE fecha_compra BETWEEN p_date AND p_date2
					AND estado_compra = p_estado AND tipo_pago	= p_pago
					GROUP BY fecha_comprobante , numero_comprobante;

				END IF;

			END IF;

        END IF;

	END //
	DELIMITER ;

    DROP PROCEDURE IF EXISTS sp_consulta_compras_totales;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_compras_totales(
		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10),
        IN p_estado varchar(2),
        IN p_pago  varchar(2)
    )
	BEGIN

		IF(p_criterio = 'MES') THEN

		  IF (p_date = '')THEN

				IF(p_estado = '' AND p_pago = '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra WHERE MONTH(fecha_compra) = MONTH(CURDATE());

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado = p_estado;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND tipo_pago = p_pago;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado = p_estado AND tipo_pago	= p_pago;

				END IF;


			ELSE

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE MONTH(fecha_compra) = p_date;

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE MONTH(fecha_compra) = p_date
					AND estado = p_estado;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE MONTH(fecha_compra) = p_date
					AND tipo_pago = p_pago;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra WHERE MONTH(fecha_compra) = p_date
					AND estado = p_estado AND tipo_pago	= p_pago;

				END IF;

		  END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

		   IF (p_date = '' AND p_date2 ='')THEN

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE MONTH(fecha_compra) = MONTH(CURDATE());

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado = p_estado;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND tipo_pago = p_pago;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado = p_estado AND tipo_pago	= p_pago;

				END IF;

			ELSE

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE fecha_compra BETWEEN p_date AND p_date2;

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE fecha_compra BETWEEN p_date AND p_date2
					AND estado = p_estado;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE fecha_compra BETWEEN p_date AND p_date2
					AND tipo_pago = p_pago;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
					SUM(retenido) as total_retenido, SUM(total) as total_comprado
                    FROM compra  WHERE fecha_compra BETWEEN p_date AND p_date2
					AND estado = p_estado AND tipo_pago	= p_pago;

				END IF;

			END IF;

        END IF;

	END //
	DELIMITER ;


    DROP PROCEDURE IF EXISTS sp_consulta_historico_precios;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_historico_precios(
		IN p_idproducto INT(11)
    )
	BEGIN

		SELECT * FROM view_historico_precios WHERE idproducto = p_idproducto;

	END //
	DELIMITER ;

	DROP PROCEDURE IF EXISTS sp_consulta_precio_mas_bajo;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_precio_mas_bajo(
		IN p_idproducto INT(11)
    )
	BEGIN

		SELECT * FROM view_historico_precios WHERE idproducto = p_idproducto
        AND precio_comprado = (SELECT MIN(precio_comprado) FROM  view_historico_precios
        WHERE idproducto = p_idproducto);

	END //
	DELIMITER ;

	DROP PROCEDURE IF EXISTS sp_view_compra;
	DELIMITER //
	CREATE PROCEDURE sp_view_compra(
		IN p_idcompra INT(11)
	)
	BEGIN

		SELECT fecha_compra,tipo_pago,nombre_proveedor,clave_rfc,
		numero_comprobante,tipo_comprobante,fecha_comprobante,
        sumas,iva,(sumas + iva) as subtotal,
		total_exento,retenido,total
		FROM view_compras WHERE idcompra = p_idcompra
		GROUP BY fecha_compra,numero_comprobante;

	END //
	DELIMITER ;


    DROP PROCEDURE IF EXISTS sp_view_detallecompra;
	DELIMITER //
	CREATE PROCEDURE sp_view_detallecompra(
		IN p_idcompra INT(11)
    )
	BEGIN

		SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
        nombre_marca,siglas,cantidad,precio_unitario,exento,importe,sumas,
        iva,total_exento,retenido,total FROM
        view_compras WHERE idcompra = p_idcompra;

	END //
	DELIMITER ;


	DROP PROCEDURE IF EXISTS sp_consulta_compras_detalle;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_compras_detalle(
		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10),
        IN p_estado varchar(2),
        IN p_pago  varchar(2)
    )
	BEGIN

		IF(p_criterio = 'MES') THEN

		  IF (p_date = '')THEN

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE());

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado_compra = p_estado;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND tipo_pago = p_pago;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado_compra = p_estado AND tipo_pago	= p_pago;

				END IF;


			ELSE

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = p_date;

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = p_date
					AND estado_compra = p_estado;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = p_date
					AND tipo_pago = p_pago;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = p_date
					AND estado_compra = p_estado AND tipo_pago	= p_pago;

				END IF;

		  END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

		   IF (p_date = '' AND p_date2 ='')THEN

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE());

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado_compra = p_estado;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND tipo_pago = p_pago;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE MONTH(fecha_compra) = MONTH(CURDATE())
					AND estado_compra = p_estado AND tipo_pago	= p_pago;

				END IF;

			ELSE

				IF(p_estado = '' AND p_pago = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE fecha_compra BETWEEN p_date AND p_date2;

				ELSEIF (p_estado != '' AND p_pago = '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE fecha_compra BETWEEN p_date AND p_date2
					AND estado_compra = p_estado;

				ELSEIF (p_estado = '' AND p_pago != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE fecha_compra BETWEEN p_date AND p_date2
					AND tipo_pago = p_pago;

				ELSEIF (p_estado != '' AND p_pago != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,fecha_vence,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,importe FROM
					view_compras WHERE fecha_compra BETWEEN p_date AND p_date2
					AND estado_compra = p_estado AND tipo_pago	= p_pago;

				END IF;

			END IF;

        END IF;

	END //
	DELIMITER ;

	DROP PROCEDURE IF EXISTS sp_count_compras;
	DELIMITER //
	CREATE PROCEDURE sp_count_compras(

		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10)
    )
	BEGIN

        DECLARE compras_anuladas INT;
        DECLARE compras_vigentes INT;
        DECLARE compras_contado INT;
        DECLARE compras_credito INT;


		IF (p_criterio = 'MES') THEN

			IF (p_date = '') THEN

				SET compras_anuladas = (SELECT COUNT(*) AS compras_anuladas
                FROM compra WHERE estado = 0 AND DATE_FORMAT(fecha_compra,'%m-%Y') =  MONTH(CURDATE()));
				SET compras_vigentes = (SELECT COUNT(*) AS compras_vigentes
                FROM compra WHERE estado = 1 AND DATE_FORMAT(fecha_compra,'%m-%Y') = MONTH(CURDATE()));
				SET compras_contado = (SELECT COUNT(*) AS compras_vigentes
                FROM compra WHERE tipo_pago = 1 AND  DATE_FORMAT(fecha_compra,'%m-%Y') = MONTH(CURDATE()));
				SET compras_credito = (SELECT COUNT(*) AS compras_vigentes
                FROM compra WHERE tipo_pago = 2 AND  DATE_FORMAT(fecha_compra,'%m-%Y') = MONTH(CURDATE()));

                SELECT compras_anuladas,compras_vigentes,compras_contado,compras_credito;

			ELSE

				SET compras_anuladas = (SELECT COUNT(*) AS compras_anuladas FROM compra
                WHERE DATE_FORMAT(fecha_compra,'%m-%Y') = p_date AND estado = 0 );
				SET compras_vigentes = (SELECT COUNT(*) AS compras_vigentes FROM compra
                WHERE DATE_FORMAT(fecha_compra,'%m-%Y') = p_date AND estado = 1);
				SET compras_contado = (SELECT COUNT(*) AS compras_vigentes FROM compra
                WHERE DATE_FORMAT(fecha_compra,'%m-%Y') = p_date AND tipo_pago = 1);
				SET compras_credito = (SELECT COUNT(*) AS compras_vigentes FROM compra
                WHERE DATE_FORMAT(fecha_compra,'%m-%Y') = p_date AND tipo_pago = 2);

				SELECT compras_anuladas,compras_vigentes,compras_contado,compras_credito;

            END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

        IF (p_date = '' AND p_date2 = '') THEN

				SET compras_anuladas = (SELECT COUNT(*) AS compras_anuladas
                FROM compra WHERE estado = 0 AND DATE_FORMAT(fecha_compra,'%m-%Y') =  MONTH(CURDATE()));
				SET compras_vigentes = (SELECT COUNT(*) AS compras_vigentes
                FROM compra WHERE estado = 1 AND DATE_FORMAT(fecha_compra,'%m-%Y') = MONTH(CURDATE()));
				SET compras_contado = (SELECT COUNT(*) AS compras_vigentes
                FROM compra WHERE tipo_pago = 1 AND  DATE_FORMAT(fecha_compra,'%m-%Y') = MONTH(CURDATE()));
				SET compras_credito = (SELECT COUNT(*) AS compras_vigentes
                FROM compra WHERE tipo_pago = 2 AND  DATE_FORMAT(fecha_compra,'%m-%Y') = MONTH(CURDATE()));

                SELECT compras_anuladas,compras_vigentes,compras_contado,compras_credito;

			ELSE

				SET compras_anuladas = (SELECT COUNT(*) AS compras_anuladas FROM compra
				WHERE estado = 0 AND DATE_FORMAT(fecha_compra,'%Y-%m-%d') BETWEEN p_date AND p_date2);
				SET compras_vigentes = (SELECT COUNT(*) AS compras_vigentes FROM compra
				WHERE estado = 1 AND DATE_FORMAT(fecha_compra,'%Y-%m-%d') BETWEEN p_date AND p_date2);
				SET compras_contado = (SELECT COUNT(*) AS compras_vigentes FROM compra
				WHERE tipo_pago = 1 AND DATE_FORMAT(fecha_compra,'%Y-%m-%d') BETWEEN p_date AND p_date2);
				SET compras_credito = (SELECT COUNT(*) AS compras_vigentes FROM compra
				WHERE tipo_pago = 2 AND DATE_FORMAT(fecha_compra,'%Y-%m-%d') BETWEEN p_date AND p_date2);

				SELECT compras_anuladas,compras_vigentes,compras_contado,compras_credito;

            END IF;

	END IF;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_anular_compra;
DELIMITER //
CREATE PROCEDURE sp_anular_compra(
	IN p_idcompra INT(11)
)
BEGIN

		DELETE FROM entrada
        WHERE idcompra = p_idcompra;

		UPDATE inventario t2
		JOIN detallecompra t1 ON t1.idproducto = t2.idproducto
		SET t2.saldo_final = t2.saldo_final - t1.cantidad,
        t2.entradas = t2.entradas - t1.cantidad
		WHERE t1.idcompra = p_idcompra AND t2.idproducto = t1.idproducto
        AND t2.fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND t2.fecha_cierre = LAST_DAY(CURDATE());

		UPDATE perecedero t2
		JOIN detallecompra t1 ON t1.idproducto = t2.idproducto
		SET t2.cantidad_perecedero = t2.cantidad_perecedero - t1.cantidad
		WHERE t1.idcompra = p_idcompra AND t2.idproducto = t1.idproducto AND t2.fecha_vencimiento = t1.fecha_vence;

		UPDATE producto t2
		JOIN detallecompra t1 ON t1.idproducto = t2.idproducto
		SET t2.stock = t2.stock - t1.cantidad
		WHERE t1.idcompra = p_idcompra AND t2.idproducto = t1.idproducto;

		UPDATE compra SET
		estado = 0
		WHERE idcompra = p_idcompra;


END //
DELIMITER ;


-- COMPRAS CONSULTAS


-- VENTAS CONSULTAS


DROP PROCEDURE IF EXISTS sp_consulta_ventas_totales;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_ventas_totales(
		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10),
        IN p_estado varchar(2)
    )
	BEGIN

		IF(p_criterio = 'MES') THEN

		  IF (p_date = '')THEN

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE MONTH(fecha_venta) = MONTH(CURDATE());

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE MONTH(fecha_venta) = MONTH(CURDATE())
					AND estado = p_estado;

				END IF;


			ELSE

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE MONTH(fecha_venta) = p_date;

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE MONTH(fecha_venta) = p_date
					AND estado = p_estado;

				END IF;

		  END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

		   IF (p_date = '' AND p_date2 ='')THEN

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE MONTH(fecha_venta) = MONTH(CURDATE());

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE MONTH(fecha_venta) = MONTH(CURDATE());

				END IF;

			ELSE

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE fecha_venta BETWEEN p_date AND p_date2;

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE fecha_venta BETWEEN p_date AND p_date2
					AND estado = p_estado;

				END IF;

			END IF;

		ELSEIF (p_criterio = 'HOY') THEN

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE();

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_vendido FROM venta
                    WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE()
					AND estado = p_estado;

				END IF;

        END IF;

	END //
	DELIMITER ;

DROP PROCEDURE IF EXISTS sp_consulta_ventas;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_ventas(
		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10),
        IN p_estado varchar(2)
    )
	BEGIN

		IF(p_criterio = 'MES') THEN

		  IF (p_date = '')THEN

				IF(p_estado = '') THEN
					SELECT * FROM view_ventas WHERE MONTH(fecha_venta) = MONTH(CURDATE())
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_ventas WHERE MONTH(fecha_venta) = MONTH(CURDATE())
					AND estado_venta = p_estado
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				END IF;


			ELSE

				IF(p_estado = '') THEN
					SELECT * FROM view_ventas WHERE MONTH(fecha_venta) = p_date
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_ventas WHERE MONTH(fecha_venta) = p_date
					AND estado_venta = p_estado
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				END IF;

		  END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

		   IF (p_date = '' AND p_date2 ='')THEN

				IF(p_estado = '') THEN
					SELECT * FROM view_ventas WHERE MONTH(fecha_venta) = MONTH(CURDATE())
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_ventas WHERE MONTH(fecha_venta) = MONTH(CURDATE())
					AND estado_venta = p_estado
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				END IF;

			ELSE

				IF(p_estado = '') THEN
					SELECT * FROM view_ventas WHERE fecha_venta BETWEEN p_date AND p_date2
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_ventas WHERE fecha_venta BETWEEN p_date AND p_date2
					AND estado_venta = p_estado
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				END IF;

			END IF;

		ELSEIF (p_criterio = 'HOY') THEN

				IF(p_estado = '') THEN
					SELECT * FROM view_ventas WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE()
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_ventas WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE()
					AND estado_venta = p_estado
					GROUP BY DATE_FORMAT(fecha_venta,'%Y-%m-%d'), numero_venta;

				END IF;

        END IF;

	END //
	DELIMITER ;

    DROP PROCEDURE IF EXISTS sp_consulta_ventas_detalle;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_ventas_detalle(
		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10),
        IN p_estado varchar(2)
    )
	BEGIN


		IF(p_criterio = 'MES') THEN

		  IF (p_date = '')THEN

				IF(p_estado = '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE MONTH(fecha_venta) = MONTH(CURDATE())
					;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE MONTH(fecha_venta) = MONTH(CURDATE())
					AND estado_venta = p_estado
					;

				END IF;


			ELSE

				IF(p_estado = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE MONTH(fecha_venta) = p_date
					;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE MONTH(fecha_venta) = p_date
					AND estado_venta = p_estado
					;

				END IF;

		  END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

		   IF (p_date = '' AND p_date2 ='')THEN

				IF(p_estado = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE MONTH(fecha_venta) = MONTH(CURDATE())
					;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE MONTH(fecha_venta) = MONTH(CURDATE())
					AND estado_venta = p_estado
					;

				END IF;

			ELSE

				IF(p_estado = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE fecha_venta BETWEEN p_date AND p_date2
					;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE fecha_venta BETWEEN p_date AND p_date2
					AND estado_venta = p_estado
					;

				END IF;

			END IF;

		ELSEIF (p_criterio = 'HOY') THEN

				IF(p_estado = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE()
					;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_ventas WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE()
					AND estado_venta = p_estado
					;

				END IF;

        END IF;

	END //
	DELIMITER ;


   DROP PROCEDURE IF EXISTS sp_count_ventas;
	DELIMITER //
	CREATE PROCEDURE sp_count_ventas(

		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10)
    )
	BEGIN

        DECLARE ventas_anuladas INT;
        DECLARE ventas_vigentes INT;
        DECLARE ventas_contado INT;
        DECLARE ventas_credito INT;


		IF (p_criterio = 'MES') THEN

			IF (p_date = '') THEN

				SET ventas_anuladas = (SELECT COUNT(*) AS ventas_anuladas
                FROM venta WHERE estado = 0 AND DATE_FORMAT(fecha_venta,'%m-%Y') =  MONTH(CURDATE()));
				SET ventas_vigentes = (SELECT COUNT(*) AS ventas_vigentes
                FROM venta WHERE estado = 1 AND DATE_FORMAT(fecha_venta,'%m-%Y') = MONTH(CURDATE()));
				SET ventas_contado = (SELECT COUNT(*) AS ventas_vigentes
                FROM venta WHERE estado = 1 AND  DATE_FORMAT(fecha_venta,'%m-%Y') = MONTH(CURDATE()));
				SET ventas_credito = (SELECT COUNT(*) AS ventas_vigentes
                FROM venta WHERE estado = 2 AND  DATE_FORMAT(fecha_venta,'%m-%Y') = MONTH(CURDATE()));

                SELECT ventas_anuladas,ventas_vigentes,ventas_contado,ventas_credito;

			ELSE

				SET ventas_anuladas = (SELECT COUNT(*) AS ventas_anuladas FROM venta
                WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_date AND estado = 0 );
				SET ventas_vigentes = (SELECT COUNT(*) AS ventas_vigentes FROM venta
                WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_date AND estado = 1);
				SET ventas_contado = (SELECT COUNT(*) AS ventas_vigentes FROM venta
                WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_date AND estado = 1);
				SET ventas_credito = (SELECT COUNT(*) AS ventas_vigentes FROM venta
                WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_date AND estado = 2);

				SELECT ventas_anuladas,ventas_vigentes,ventas_contado,ventas_credito;

            END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

        IF (p_date = '' AND p_date2 = '') THEN

				SET ventas_anuladas = (SELECT COUNT(*) AS ventas_anuladas
                FROM venta WHERE estado = 0 AND DATE_FORMAT(fecha_venta,'%m-%Y') =  MONTH(CURDATE()));
				SET ventas_vigentes = (SELECT COUNT(*) AS ventas_vigentes
                FROM venta WHERE estado = 1 AND DATE_FORMAT(fecha_venta,'%m-%Y') = MONTH(CURDATE()));
				SET ventas_contado = (SELECT COUNT(*) AS ventas_vigentes
                FROM venta WHERE estado = 1 AND  DATE_FORMAT(fecha_venta,'%m-%Y') = MONTH(CURDATE()));
				SET ventas_credito = (SELECT COUNT(*) AS ventas_vigentes
                FROM venta WHERE estado = 2 AND  DATE_FORMAT(fecha_venta,'%m-%Y') = MONTH(CURDATE()));

                SELECT ventas_anuladas,ventas_vigentes,ventas_contado,ventas_credito;

			ELSE

				SET ventas_anuladas = (SELECT COUNT(*) AS ventas_anuladas FROM venta
				WHERE estado = 0 AND DATE_FORMAT(fecha_venta,'%Y-%m-%d') BETWEEN p_date AND p_date2);
				SET ventas_vigentes = (SELECT COUNT(*) AS ventas_vigentes FROM venta
				WHERE estado = 1 AND DATE_FORMAT(fecha_venta,'%Y-%m-%d') BETWEEN p_date AND p_date2);
				SET ventas_contado = (SELECT COUNT(*) AS ventas_vigentes FROM venta
				WHERE estado = 1 AND DATE_FORMAT(fecha_venta,'%Y-%m-%d') BETWEEN p_date AND p_date2);
				SET ventas_credito = (SELECT COUNT(*) AS ventas_vigentes FROM venta
				WHERE estado = 2 AND DATE_FORMAT(fecha_venta,'%Y-%m-%d') BETWEEN p_date AND p_date2);

				SELECT ventas_anuladas,ventas_vigentes,ventas_contado,ventas_credito;

            END IF;

		ELSEIF (p_criterio = 'HOY') THEN

			SET ventas_anuladas = (SELECT COUNT(*) AS ventas_anuladas
			FROM venta WHERE estado = 0 AND DATE_FORMAT(fecha_venta,'%Y-%m-%d') =  CURDATE());
			SET ventas_vigentes = (SELECT COUNT(*) AS ventas_vigentes
			FROM venta WHERE estado = 1 AND DATE_FORMAT(fecha_venta,'%Y-%m-%d') =  CURDATE());
			SET ventas_contado = (SELECT COUNT(*) AS ventas_vigentes
			FROM venta WHERE estado = 1 AND DATE_FORMAT(fecha_venta,'%Y-%m-%d') =  CURDATE());
			SET ventas_credito = (SELECT COUNT(*) AS ventas_vigentes
			FROM venta WHERE estado = 2 AND DATE_FORMAT(fecha_venta,'%Y-%m-%d') =  CURDATE());

			SELECT ventas_anuladas,ventas_vigentes,ventas_contado,ventas_credito;

	END IF;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_venta;
DELIMITER //
CREATE PROCEDURE sp_view_venta(
	IN p_idventa INT(11)
)
BEGIN

	SELECT numero_venta,fecha_venta,tipo_pago,cliente,
    pago_efectivo,pago_tarjeta,numero_tarjeta,tarjeta_habiente,cambio,
    numero_comprobante,tipo_comprobante,sumas,iva,(sumas + iva) as subtotal,
    total_exento,retenido,total_descuento,total
    FROM view_ventas WHERE idventa = p_idventa
    GROUP BY numero_venta;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_detalleventa;
DELIMITER //
CREATE PROCEDURE sp_view_detalleventa(
	IN p_idventa INT(11)
)
BEGIN

	SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
	nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,importe,sumas,
	iva,total_exento,retenido,total_descuento,total,fecha_vence FROM
	view_ventas WHERE idventa = p_idventa;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_anular_venta;
DELIMITER //
CREATE PROCEDURE sp_anular_venta(
	IN p_idventa INT(11)
)
BEGIN

	DECLARE p_numero_comprobante INT;
	DECLARE p_tipo_comprobante tinyint(1);
    DECLARE p_fecha_venta date;
    DECLARE p_descripcion_movimiento varchar(150);
    DECLARE p_estado TINYINT(1);

    SET p_numero_comprobante = (SELECT numero_comprobante FROM venta WHERE idventa = p_idventa);
    SET p_tipo_comprobante = (SELECT tipo_comprobante FROM venta WHERE idventa = p_idventa);
    SET p_fecha_venta = (SELECT DATE_FORMAT(fecha_venta,'%Y-%m-%d') FROM venta WHERE idventa = p_idventa);
    SET p_estado = (SELECT estado FROM venta WHERE idventa = p_idventa);

 IF(p_estado = '1') THEN

    IF(p_tipo_comprobante = '1')THEN

		SET p_descripcion_movimiento = (CONCAT('POR VENTA',' ','TICKET', ' # ',p_numero_comprobante));

		DELETE FROM caja_movimiento WHERE
		descripcion_movimiento = (p_descripcion_movimiento) AND fecha_movimiento = p_fecha_venta;

        DELETE FROM salida
        WHERE idventa = p_idventa;

        UPDATE venta SET
        estado = 0
        WHERE idventa = p_idventa;

		UPDATE inventario t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
        SET t2.salidas = t2.salidas - t1.cantidad,
        t2.saldo_final = t2.saldo_final + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND t2.fecha_cierre = LAST_DAY(CURDATE());

		UPDATE perecedero t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.cantidad_perecedero = t2.cantidad_perecedero + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_vencimiento = t1.fecha_vence;

		UPDATE producto t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.stock = t2.stock + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto;


	ELSEIF (p_tipo_comprobante = '2')THEN


		SET p_descripcion_movimiento = (CONCAT('POR VENTA',' ','FACTURA', ' # ',p_numero_comprobante));

		DELETE FROM caja_movimiento WHERE
		descripcion_movimiento = (p_descripcion_movimiento) AND fecha_movimiento = p_fecha_venta;

		DELETE FROM salida
        WHERE idventa = p_idventa;

		UPDATE venta SET
        estado = 0
        WHERE idventa = p_idventa;

		UPDATE inventario t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
        SET t2.salidas = t2.salidas - t1.cantidad,
        t2.saldo_final = t2.saldo_final + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND t2.fecha_cierre = LAST_DAY(CURDATE());

		UPDATE perecedero t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.cantidad_perecedero = t2.cantidad_perecedero + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_vencimiento = t1.fecha_vence;

		UPDATE producto t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.stock = t2.stock + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto;

    ELSEIF (p_tipo_comprobante = '3')THEN


		SET p_descripcion_movimiento = CONCAT('POR VENTA',' ','CREDITO FISCAL', ' # ',p_numero_comprobante);

		DELETE FROM caja_movimiento WHERE
		descripcion_movimiento = (p_descripcion_movimiento) AND fecha_movimiento = p_fecha_venta;

		DELETE FROM salida
        WHERE idventa = p_idventa;

		UPDATE venta SET
        estado = 0
        WHERE idventa = p_idventa;

		UPDATE inventario t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
        SET t2.salidas = t2.salidas - t1.cantidad,
        t2.saldo_final = t2.saldo_final + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND t2.fecha_cierre = LAST_DAY(CURDATE());

		UPDATE perecedero t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.cantidad_perecedero = t2.cantidad_perecedero + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_vencimiento = t1.fecha_vence;

		UPDATE producto t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.stock = t2.stock + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto;

    END IF;

 ELSEIF (p_estado = '2') THEN

    DELETE FROM credito WHERE idventa = p_idventa;

	IF(p_tipo_comprobante = '1')THEN

		SET p_descripcion_movimiento = (CONCAT('POR VENTA',' ','TICKET', ' # ',p_numero_comprobante));

		DELETE FROM caja_movimiento WHERE
		descripcion_movimiento = (p_descripcion_movimiento) AND fecha_movimiento = p_fecha_venta;

        DELETE FROM salida
        WHERE idventa = p_idventa;

        UPDATE venta SET
        estado = 0
        WHERE idventa = p_idventa;

		UPDATE inventario t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
        SET t2.salidas = t2.salidas - t1.cantidad,
        t2.saldo_final = t2.saldo_final + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND t2.fecha_cierre = LAST_DAY(CURDATE());

		UPDATE perecedero t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.cantidad_perecedero = t2.cantidad_perecedero + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_vencimiento = t1.fecha_vence;

		UPDATE producto t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.stock = t2.stock + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto;


	ELSEIF (p_tipo_comprobante = '2')THEN


		SET p_descripcion_movimiento = (CONCAT('POR VENTA',' ','FACTURA', ' # ',p_numero_comprobante));

		DELETE FROM caja_movimiento WHERE
		descripcion_movimiento = (p_descripcion_movimiento) AND fecha_movimiento = p_fecha_venta;

		DELETE FROM salida
        WHERE idventa = p_idventa;

		UPDATE venta SET
        estado = 0
        WHERE idventa = p_idventa;

		UPDATE inventario t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
        SET t2.salidas = t2.salidas - t1.cantidad,
        t2.saldo_final = t2.saldo_final + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND t2.fecha_cierre = LAST_DAY(CURDATE());

		UPDATE perecedero t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.cantidad_perecedero = t2.cantidad_perecedero + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_vencimiento = t1.fecha_vence;

		UPDATE producto t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.stock = t2.stock + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto;

    ELSEIF (p_tipo_comprobante = '3')THEN


		SET p_descripcion_movimiento = CONCAT('POR VENTA',' ','CREDITO FISCAL', ' # ',p_numero_comprobante);

		DELETE FROM caja_movimiento WHERE
		descripcion_movimiento = (p_descripcion_movimiento) AND fecha_movimiento = p_fecha_venta;

		DELETE FROM salida
        WHERE idventa = p_idventa;

		UPDATE venta SET
        estado = 0
        WHERE idventa = p_idventa;

		UPDATE inventario t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
        SET t2.salidas = t2.salidas - t1.cantidad,
        t2.saldo_final = t2.saldo_final + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND t2.fecha_cierre = LAST_DAY(CURDATE());

		UPDATE perecedero t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.cantidad_perecedero = t2.cantidad_perecedero + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
        AND t2.fecha_vencimiento = t1.fecha_vence;

		UPDATE producto t2
		JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
		SET t2.stock = t2.stock + t1.cantidad
		WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto;

	END IF;

 END IF;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_finalizar_venta;
DELIMITER //
CREATE PROCEDURE sp_finalizar_venta(
	IN p_idventa INT(11)
)
BEGIN

	DECLARE p_total DECIMAL(8,2);
    DECLARE p_descr_salida varchar(150);
    DECLARE p_tipo_comprobante tinyint(1);
    DECLARE p_numero_comprobante int(11);

    SET p_total = (SELECT total FROM venta WHERE idventa = p_idventa);
    SET p_tipo_comprobante = (SELECT tipo_comprobante FROM venta WHERE idventa = p_idventa);
    SET p_numero_comprobante = (SELECT numero_comprobante FROM venta WHERE idventa = p_idventa);

    IF p_tipo_comprobante = '1' THEN
		SET p_descr_salida = (CONCAT('POR VENTA',' ','TICKET', ' # ',p_numero_comprobante));
	ELSEIF p_tipo_comprobante = '2' THEN
		SET p_descr_salida = (CONCAT('POR VENTA',' ','FACTURA', ' # ',p_numero_comprobante));
	ELSEIF p_tipo_comprobante = '3' THEN
		SET p_descr_salida = (CONCAT('POR VENTA',' ','CREDITO FISCAL', ' # ',p_numero_comprobante));
    END IF;

	INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
	`precio_unitario_salida`, `costo_total_salida`, `idproducto`)
	SELECT DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_salida,cantidad,precio_unitario,(cantidad*precio_unitario),idproducto
	FROM detalleventa WHERE idventa = p_idventa;


	UPDATE inventario t2
	JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
	SET t2.saldo_final = t2.saldo_final - t1.cantidad,
	t2.salidas = t2.salidas + t1.cantidad
	WHERE t1.idventa = p_idventa AND t2.idproducto = t1.idproducto
	AND t2.fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
	AND t2.fecha_cierre = LAST_DAY(CURDATE());

    UPDATE perecedero t2
    JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
    SET t2.cantidad_perecedero = t2.cantidad_perecedero - t1.cantidad
    WHERE t2.idproducto = t1.idproducto AND t2.fecha_vencimiento = t1.fecha_vence;

    UPDATE producto t2
    JOIN detalleventa t1 ON t1.idproducto = t2.idproducto
    SET t2.stock = t2.stock - t1.cantidad
    WHERE t2.idproducto = t1.idproducto;

    UPDATE venta SET
    estado = 1
    WHERE idventa = p_idventa;

	CALL sp_insert_caja_venta(p_total);


END //
DELIMITER ;


-- VENTAS CONSULTAS


-- REPORTES AL FIN

	DROP PROCEDURE IF EXISTS sp_imprimir_ticket;
	DELIMITER //
	CREATE PROCEDURE sp_imprimir_ticket(
		IN p_idventa INT(11)
	)
	BEGIN


        DECLARE p_idmax int;
        DECLARE p_tipo_comprobante tinyint(1);
        DECLARE p_idparametro int;
        DECLARE p_empresa varchar(150);
        DECLARE p_propietario varchar(150);
        DECLARE p_direccion varchar(200);
        DECLARE p_clave_rfc varchar(20);
        DECLARE p_regimen_fiscal varchar(14);
        DECLARE p_fecha_resolucion datetime;
        DECLARE p_numero_resolucion varchar(80);
        DECLARE p_serie varchar(175);
        DECLARE p_subtotal decimal(8,2);
        DECLARE p_exento decimal(8,2);
        DECLARE p_descuento decimal(8,2);
        DECLARE p_total decimal(8,2);
        DECLARE p_numero_productos decimal(8,2);
        DECLARE p_numero_comprobante INT;
        DECLARE p_empleado varchar(181);
        DECLARE p_numero_venta varchar(175);
        DECLARE p_fecha_venta datetime;
        DECLARE p_moneda varchar(35);
        DECLARE p_idcurrency int;
        DECLARE p_estado tinyint(1);


         DECLARE p_tipo_pago varchar(75);
		 DECLARE p_pago_efectivo decimal(8,2);
         DECLARE p_pago_tarjeta decimal(8,2);
         DECLARE p_numero_tarjeta varchar(16);
         DECLARE p_tarjeta_habiente varchar(90);
         DECLARE p_cambio decimal(8,2);

        SET p_idmax = (SELECT MAX(idventa) FROM venta);
        SET p_idparametro = (SELECT MAX(idparametro) FROM parametro);
        SET p_idcurrency = (SELECT idcurrency FROM parametro WHERE idparametro = p_idparametro);
        SET p_empresa = (SELECT nombre_empresa FROM parametro);
        SET p_propietario = (SELECT propietario FROM parametro);
        SET p_direccion = (SELECT direccion_empresa FROM parametro);
        SET p_clave_rfc = (SELECT clave_rfc FROM parametro);
        SET p_regimen_fiscal = (SELECT regimen_fiscal FROM parametro);
        SET p_fecha_resolucion = (SELECT fecha_resolucion FROM tiraje_comprobante WHERE idcomprobante = 1);
        SET p_numero_resolucion = (SELECT numero_resolucion FROM tiraje_comprobante WHERE idcomprobante = 1);
        SET p_serie = (SELECT serie FROM tiraje_comprobante WHERE idcomprobante = 1);
        SET p_moneda = (SELECT CurrencyName	FROM currency WHERE idcurrency = p_idcurrency);






		IF (p_idventa = '') THEN

        SET p_tipo_comprobante = (SELECT tipo_comprobante FROM venta WHERE idventa = p_idmax);
		SET p_subtotal = (SELECT (sumas + iva) as subtotal FROM venta WHERE idventa = p_idmax);
		SET p_exento = (SELECT exento FROM venta WHERE idventa = p_idmax);
		SET p_descuento = (SELECT descuento FROM venta WHERE idventa = p_idmax);
        SET p_total = (SELECT total FROM venta WHERE idventa = p_idmax);
        SET p_numero_productos = (SELECT SUM(cantidad) FROM detalleventa WHERE idventa = p_idmax);
        SET p_numero_comprobante = (SELECT numero_comprobante FROM venta WHERE idventa = p_idmax);
        SET p_empleado = (SELECT empleado FROM view_ventas WHERE idventa = p_idmax GROUP BY empleado);
        SET p_numero_venta = (SELECT numero_venta FROM venta WHERE idventa = p_idmax);
		SET p_fecha_venta = (SELECT fecha_venta FROM venta WHERE idventa = p_idmax);
		SET p_tipo_pago  = (SELECT tipo_pago FROM venta WHERE idventa = p_idmax);
		SET p_pago_efectivo  = (SELECT pago_efectivo FROM venta WHERE idventa = p_idmax);
        SET p_pago_tarjeta  = (SELECT pago_tarjeta FROM venta WHERE idventa = p_idmax);
        SET p_numero_tarjeta  = (SELECT numero_tarjeta FROM venta WHERE idventa = p_idmax);
        SET p_tarjeta_habiente  = (SELECT tarjeta_habiente FROM venta WHERE idventa = p_idmax);
        SET p_cambio = (SELECT cambio FROM venta WHERE idventa = p_idmax);
        SET p_estado = (SELECT estado FROM venta WHERE idventa = p_idmax);

        SELECT p_tipo_comprobante,p_empresa, p_propietario, p_direccion, p_clave_rfc , p_regimen_fiscal,
        DATE_FORMAT(p_fecha_resolucion,'%d/%m/%Y %k:%i %p')  as p_fecha_resolucion,p_numero_resolucion,
        p_serie, p_numero_comprobante,  p_subtotal, p_exento, p_descuento, p_total, p_numero_productos,
		p_empleado,DATE_FORMAT(p_fecha_venta,'%d/%m/%Y %k:%i %p') as p_fecha_venta ,p_numero_venta,
        p_tipo_pago, p_pago_efectivo, p_pago_tarjeta, p_numero_tarjeta, p_tarjeta_habiente, p_cambio,
        p_moneda,p_estado;

        ELSE

        SET p_tipo_comprobante = (SELECT tipo_comprobante FROM venta WHERE idventa = p_idventa);
		SET p_subtotal = (SELECT (sumas + iva) as subtotal FROM venta WHERE idventa = p_idventa);
		SET p_exento = (SELECT exento FROM venta WHERE idventa = p_idventa);
		SET p_descuento = (SELECT descuento FROM venta WHERE idventa = p_idventa);
        SET p_total = (SELECT total FROM venta WHERE idventa = p_idventa);
        SET p_numero_productos = (SELECT SUM(cantidad) FROM detalleventa WHERE idventa = p_idventa);
        SET p_numero_comprobante = (SELECT numero_comprobante FROM venta WHERE idventa = p_idventa);
        SET p_empleado = (SELECT empleado FROM view_ventas WHERE idventa =  p_idventa  GROUP BY empleado);
		SET p_numero_venta = (SELECT numero_venta FROM venta WHERE idventa = p_idventa);
		SET p_fecha_venta = (SELECT fecha_venta FROM venta WHERE idventa =  p_idventa);
		SET p_tipo_pago  = (SELECT tipo_pago FROM venta WHERE idventa = p_idventa);
		SET p_pago_efectivo  = (SELECT pago_efectivo FROM venta WHERE idventa =  p_idventa);
        SET p_pago_tarjeta  = (SELECT pago_tarjeta FROM venta WHERE idventa =  p_idventa);
        SET p_numero_tarjeta  = (SELECT numero_tarjeta FROM venta WHERE idventa =  p_idventa);
        SET p_tarjeta_habiente  = (SELECT tarjeta_habiente FROM venta WHERE idventa =  p_idventa);
        SET p_cambio = (SELECT cambio FROM venta WHERE idventa =  p_idventa);
        SET p_estado = (SELECT estado FROM venta WHERE idventa = p_idventa);

        SELECT p_tipo_comprobante,p_empresa, p_propietario, p_direccion, p_clave_rfc , p_regimen_fiscal,
        DATE_FORMAT(p_fecha_resolucion,'%d/%m/%Y %k:%i %p')  as p_fecha_resolucion,p_numero_resolucion,
        p_serie, p_numero_comprobante,  p_subtotal, p_exento, p_descuento, p_total, p_numero_productos,
		p_empleado,DATE_FORMAT(p_fecha_venta,'%d/%m/%Y %k:%i %p') as p_fecha_venta,p_numero_venta,
        p_tipo_pago, p_pago_efectivo, p_pago_tarjeta, p_numero_tarjeta, p_tarjeta_habiente, p_cambio,
        p_moneda,p_estado;

		END IF;

	END //
	DELIMITER ;


	DROP PROCEDURE IF EXISTS sp_detalle_imprimir_ticket_venta;
	DELIMITER //
	CREATE PROCEDURE sp_detalle_imprimir_ticket_venta(
		IN p_idventa INT(11)
	)
	BEGIN

		DECLARE p_idmax int;
        SET p_idmax = (SELECT MAX(idventa) FROM venta);


		IF (p_idventa = '') THEN

        SELECT cantidad, substring(nombre_producto,1,12) as descripcion,precio_unitario,
        if(producto_exento = '1', CONCAT(importe,'E'), CONCAT(importe,'G')) as importe
        FROM view_ventas
        WHERE idventa = p_idmax;

        ELSE

		SELECT cantidad, substring(nombre_producto,1,12) as descripcion,precio_unitario,
        if(producto_exento = '1', CONCAT(importe,'E'), CONCAT(importe,'G')) as importe
        FROM view_ventas
        WHERE idventa = p_idventa;

		END IF;

	END //
	DELIMITER ;


DROP PROCEDURE IF EXISTS sp_corte_z_day;
DELIMITER //
CREATE PROCEDURE sp_corte_z_day(
	IN p_day date
)
BEGIN

	DECLARE p_desde_impreso INT;
    DECLARE p_hasta_impreso INT;
    DECLARE p_venta_gravada DECIMAL(8,2);
    DECLARE p_venta_iva DECIMAL(8,2);
	DECLARE p_total_exento DECIMAL(8,2);
    DECLARE p_total_gravado DECIMAL(8,2);
    DECLARE p_total_descuento DECIMAL(8,2);
    DECLARE p_total_venta DECIMAL(8,2);

    IF (p_day!='') THEN

		SET p_desde_impreso = (SELECT MIN(numero_comprobante) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = p_day AND tipo_comprobante = 1  AND estado = 1);

		SET p_hasta_impreso = (SELECT MAX(numero_comprobante) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = p_day AND tipo_comprobante = 1  AND estado = 1);

		SET p_venta_gravada = (SELECT SUM(sumas) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = p_day AND tipo_comprobante = 1  AND estado = 1);

		SET p_venta_iva = (SELECT SUM(iva) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = p_day AND tipo_comprobante = 1  AND estado = 1);

		SET p_total_exento = (SELECT SUM(exento) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = p_day AND tipo_comprobante = 1  AND estado = 1);
        
		SET p_total_descuento = (SELECT SUM(descuento) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = p_day AND tipo_comprobante = 1  AND estado = 1);

        SET p_total_gravado = (p_venta_gravada + p_venta_iva);
        SET p_total_venta = (p_total_gravado + p_total_exento) - p_total_descuento;

        SELECT p_desde_impreso, p_hasta_impreso, p_venta_gravada, p_venta_iva ,
        p_total_exento , p_total_gravado , p_total_descuento, p_total_venta;

	ELSE

		SET p_desde_impreso = (SELECT MIN(numero_comprobante) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE() AND tipo_comprobante = 1  AND estado = 1);

		SET p_hasta_impreso = (SELECT MAX(numero_comprobante) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE() AND tipo_comprobante = 1  AND estado = 1);

		SET p_venta_gravada = (SELECT SUM(sumas) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE() AND tipo_comprobante = 1  AND estado = 1);

		SET p_venta_iva = (SELECT SUM(iva) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE() AND tipo_comprobante = 1  AND estado = 1);

		SET p_total_exento = (SELECT SUM(exento) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE() AND tipo_comprobante = 1  AND estado = 1);
        
		SET p_total_descuento = (SELECT SUM(descuento) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%Y-%m-%d') = CURDATE()  AND tipo_comprobante = 1  AND estado = 1);

        SET p_total_gravado = (p_venta_gravada + p_venta_iva);
        SET p_total_venta = (p_total_gravado + p_total_exento) - p_total_descuento;

        SELECT p_desde_impreso, p_hasta_impreso, p_venta_gravada, p_venta_iva ,
        p_total_exento , p_total_gravado , p_total_descuento, p_total_venta;

    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_corte_z_mes;
DELIMITER //
CREATE PROCEDURE sp_corte_z_mes(
	IN p_month varchar(7)
)
BEGIN

	DECLARE p_desde_impreso INT;
    DECLARE p_hasta_impreso INT;
    DECLARE p_venta_gravada DECIMAL(8,2);
    DECLARE p_venta_iva DECIMAL(8,2);
	DECLARE p_total_exento DECIMAL(8,2);
    DECLARE p_total_gravado DECIMAL(8,2);
	DECLARE p_total_descuento DECIMAL(8,2);
    DECLARE p_total_venta DECIMAL(8,2);

    IF (p_month!='') THEN

		SET p_desde_impreso = (SELECT MIN(numero_comprobante) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_month AND tipo_comprobante = 1  AND estado = 1);

		SET p_hasta_impreso = (SELECT MAX(numero_comprobante) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_month AND tipo_comprobante = 1  AND estado = 1);

		SET p_venta_gravada = (SELECT SUM(sumas) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_month AND tipo_comprobante = 1  AND estado = 1);

		SET p_venta_iva = (SELECT SUM(iva) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_month AND tipo_comprobante = 1  AND estado = 1);

		SET p_total_exento = (SELECT SUM(exento) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_month AND tipo_comprobante = 1  AND estado = 1);
        
        SET p_total_descuento = (SELECT SUM(descuento) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = p_month AND tipo_comprobante = 1  AND estado = 1);

        SET p_total_gravado = (p_venta_gravada + p_venta_iva);
        SET p_total_venta = (p_total_gravado + p_total_exento) - p_total_descuento;

        SELECT p_desde_impreso, p_hasta_impreso, p_venta_gravada, p_venta_iva ,
        p_total_exento , p_total_gravado , p_total_descuento, p_total_venta;

	ELSE

		SET p_desde_impreso = (SELECT MIN(numero_comprobante) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') =  MONTH(CURDATE()) AND tipo_comprobante = 1  AND estado = 1);

		SET p_hasta_impreso = (SELECT MAX(numero_comprobante) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') =  MONTH(CURDATE()) AND tipo_comprobante = 1  AND estado = 1);

		SET p_venta_gravada = (SELECT SUM(sumas) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') =  MONTH(CURDATE()) AND tipo_comprobante = 1  AND estado = 1);

		SET p_venta_iva = (SELECT SUM(iva) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') =  MONTH(CURDATE()) AND tipo_comprobante = 1  AND estado = 1);

		SET p_total_exento = (SELECT SUM(exento) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') =  MONTH(CURDATE()) AND tipo_comprobante = 1  AND estado = 1);
         
		SET p_total_descuento = (SELECT SUM(descuento) FROM venta
		WHERE DATE_FORMAT(fecha_venta,'%m-%Y') = MONTH(CURDATE()) AND tipo_comprobante = 1  AND estado = 1);

        SET p_total_gravado = (p_venta_gravada + p_venta_iva);
        SET p_total_venta = (p_total_gravado + p_total_exento) - p_total_descuento;

        SELECT p_desde_impreso, p_hasta_impreso, p_venta_gravada, p_venta_iva ,
        p_total_exento , p_total_gravado , p_total_descuento, p_total_venta;

    END IF;
END //
DELIMITER ;


-- CREDITOS



DROP PROCEDURE IF EXISTS sp_insert_credito_venta;
DELIMITER //
CREATE PROCEDURE sp_insert_credito_venta(
IN p_monto_credito decimal(8,2),
IN p_idcliente int(11)
)
BEGIN

    DECLARE p_idventa int(11);
    DECLARE p_numero_venta varchar(175);
	DECLARE p_nombre_credito varchar(120);
	DECLARE p_idcredito INT;

    SET p_idventa = (SELECT MAX(idventa) FROM venta);
    SET p_numero_venta = (SELECT numero_venta FROM venta WHERE idventa = p_idventa);
    SET p_nombre_credito = (CONCAT('POR VENTA #',' ',p_numero_venta));
    SET p_idcredito = (SELECT MAX(idcredito) FROM credito);

	INSERT INTO `credito`(`idventa`, `nombre_credito`, `fecha_credito`,
	`monto_credito`,`monto_abonado`,`monto_restante`,`idcliente`)
	VALUES (p_idventa, p_nombre_credito, NOW(),p_monto_credito,
    0.00,p_monto_credito,p_idcliente);

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_credito;
DELIMITER //
CREATE PROCEDURE sp_update_credito(
IN p_idcredito int(11),
IN p_nombre_credito varchar(120),
IN p_fecha_credito datetime,
IN p_monto_credito decimal(8,2),
IN p_monto_abonado decimal(8,2),
IN p_monto_restante decimal(8,2),
IN p_estado tinyint(1)
)
BEGIN
UPDATE `credito`
SET `nombre_credito` = p_nombre_credito, `fecha_credito` = p_fecha_credito,
`monto_credito` = p_monto_credito, `monto_abonado` = p_monto_abonado, `monto_restante` = p_monto_restante,
`estado` = p_estado
WHERE `idcredito` = p_idcredito;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_abono;
DELIMITER //
CREATE PROCEDURE sp_insert_abono(
IN p_idcredito int(11),
IN p_monto_abono decimal(8,2),
IN p_idusuario int(11)
)
BEGIN
DECLARE p_codigo_credito varchar(175);
DECLARE p_monto_restante DECIMAL(8,2);
DECLARE p_resta_montos DECIMAL(8,2);
DECLARE p_monto_abonado DECIMAL(8,2);
DECLARE p_idventa int;

SET p_monto_restante = (SELECT monto_restante FROM credito WHERE idcredito = p_idcredito);
SET p_resta_montos = (p_monto_restante - p_monto_abono);
SET p_idventa = (SELECT idventa FROM credito WHERE idcredito = p_idcredito);
SET p_codigo_credito = (SELECT codigo_credito FROM credito WHERE idcredito = p_idcredito);

IF p_resta_montos = 0 THEN

	UPDATE credito SET
	monto_restante = 0.00,
    monto_abonado = monto_abonado + p_monto_abono,
    estado = 1
	WHERE idcredito = p_idcredito;

    SET p_monto_abonado = (SELECT monto_abonado FROM credito WHERE idcredito = p_idcredito);

    CALL sp_insert_caja_movimiento(1,p_monto_abono,(CONCAT('POR ABONO A CREDITO',' ',p_codigo_credito)));

    INSERT INTO `abono`(`idcredito`, `fecha_abono`, `monto_abono`, `total_abonado`,`restante_credito`,`idusuario`)
	VALUES (p_idcredito, NOW(), p_monto_abono,p_monto_abonado, 0.00,p_idusuario);

ELSEIF p_resta_montos > 0 THEN
	UPDATE credito SET
	monto_restante = p_resta_montos,
    monto_abonado = monto_abonado + p_monto_abono
	WHERE idcredito = p_idcredito;

	SET p_monto_abonado = (SELECT monto_abonado FROM credito WHERE idcredito = p_idcredito);

	    CALL sp_insert_caja_movimiento(1,p_monto_abono,(CONCAT('POR ABONO A CREDITO',' ',p_codigo_credito)));

    INSERT INTO `abono`(`idcredito`, `fecha_abono`, `monto_abono`, `total_abonado`,`restante_credito`,`idusuario`)
	VALUES (p_idcredito, NOW(), p_monto_abono,p_monto_abonado, p_resta_montos,p_idusuario);

END IF;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_abono;
DELIMITER //
CREATE PROCEDURE sp_update_abono(
IN p_idabono int(11),
IN p_fecha_abono datetime,
IN p_monto_abono decimal(8,2)
)
BEGIN
UPDATE `abono`
SET  `fecha_abono` = p_fecha_abono, `monto_abono` = p_monto_abono
WHERE `idabono` = p_idabono;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_abonos;
DELIMITER //
CREATE PROCEDURE sp_view_abonos(
	IN p_idcredito INT(11)
)
BEGIN
	SELECT * FROM view_abonos WHERE idcredito = p_idcredito;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_creditos;
DELIMITER //
CREATE PROCEDURE sp_view_creditos(
	IN p_criterio TINYINT(1)
)
BEGIN
	SELECT * FROM view_creditos_venta WHERE estado_credito = p_criterio;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_creditos_espc;
DELIMITER //
CREATE PROCEDURE sp_view_creditos_espc(
	IN p_idcredito int
)
BEGIN
	SELECT * FROM view_creditos_venta WHERE idcredito = p_idcredito;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_count_creditos;
DELIMITER //
CREATE PROCEDURE sp_count_creditos()
BEGIN

    DECLARE count_pendientes int;
    DECLARE count_pagados int;

	SET count_pendientes = (SELECT COUNT(*) AS creditos_pendientes FROM credito WHERE estado = 0);
    SET count_pagados = (SELECT COUNT(*) AS creditos_pagados FROM credito WHERE estado = 1);

    SELECT count_pendientes,count_pagados;

END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_view_all_abonos;
DELIMITER //
CREATE PROCEDURE sp_view_all_abonos()
BEGIN
	SELECT * FROM view_abonos;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_monto_credito;
DELIMITER //
CREATE PROCEDURE sp_view_monto_credito(
	IN p_idcredito INT(11)
)
BEGIN
	SELECT monto_restante FROM credito WHERE idcredito = p_idcredito;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_delete_abono;
DELIMITER //
CREATE PROCEDURE sp_delete_abono(
IN p_idabono int(11))
BEGIN

	DECLARE p_monto_abono decimal(8,2);
    DECLARE p_idcredito INT;
    DECLARE p_monto_abonado decimal(8,2);
    DECLARE p_monto_restante decimal(8,2);

    SET p_monto_abono = (SELECT monto_abono FROM abono WHERE idabono = p_idabono);
    SET p_idcredito = (SELECT idcredito FROM view_abonos WHERE idabono = p_idabono);
    SET p_monto_abonado = (SELECT monto_abonado FROM credito WHERE idcredito = p_idcredito);
    SET p_monto_restante = (SELECT monto_restante FROM credito WHERE idcredito = p_idcredito);

    IF p_monto_restante = 0 THEN

		UPDATE credito SET
        estado = 0,
        monto_restante = p_monto_abono,
        monto_abonado = monto_abonado - p_monto_abono
        WHERE idcredito = p_idcredito;

    ELSEIF p_monto_restante > 0 THEN
		UPDATE credito SET
        monto_restante = monto_restante + p_monto_abono,
        monto_abonado = monto_abonado - p_monto_abono
        WHERE idcredito = p_idcredito;
    END IF;

	DELETE FROM `abono`
	WHERE `idabono` = p_idabono;
END //
DELIMITER ;

	DROP PROCEDURE IF EXISTS sp_imprimir_ticket_abono;
	DELIMITER //
	CREATE PROCEDURE sp_imprimir_ticket_abono(
		IN p_idabono INT(11)
	)
	BEGIN


        DECLARE p_idmax int;
        DECLARE p_idparametro int;
        DECLARE p_empresa varchar(150);
        DECLARE p_propietario varchar(150);
        DECLARE p_direccion varchar(200);
        DECLARE p_clave_rfc varchar(20);
        DECLARE p_regimen_fiscal varchar(14);
        DECLARE p_fecha_resolucion datetime;
        DECLARE p_numero_resolucion varchar(80);
        DECLARE p_serie varchar(175);
        DECLARE p_moneda varchar(35);
        DECLARE p_idcurrency int;
		DECLARE p_simbolo varchar(3);

		DECLARE p_idcredito int;
        DECLARE p_codigo_credito varchar(175);
        DECLARE p_monto_credito decimal(8,2);
        DECLARE p_monto_abonado decimal(8,2);
        DECLARE p_monto_restante decimal(8,2);
        DECLARE p_fecha_abono datetime;
        DECLARE p_monto_abono decimal(8,2);
        DECLARE p_total_abonado decimal(8,2);
        DECLARE p_restante_credito decimal(8,2);
        DECLARE p_cliente varchar(150);
        DECLARE p_usuario varchar(8);

        SET p_idmax = (SELECT MAX(idabono) FROM abono);
        SET p_idparametro = (SELECT MAX(idparametro) FROM parametro);
        SET p_idcurrency = (SELECT idcurrency FROM parametro WHERE idparametro = p_idparametro);
        SET p_empresa = (SELECT nombre_empresa FROM parametro);
        SET p_propietario = (SELECT propietario FROM parametro);
        SET p_direccion = (SELECT direccion_empresa FROM parametro);
        SET p_clave_rfc = (SELECT clave_rfc FROM parametro);
        SET p_regimen_fiscal = (SELECT regimen_fiscal FROM parametro);
        SET p_fecha_resolucion = (SELECT fecha_resolucion FROM tiraje_comprobante WHERE idcomprobante = 1);
        SET p_numero_resolucion = (SELECT numero_resolucion FROM tiraje_comprobante WHERE idcomprobante = 1);
        SET p_serie = (SELECT serie FROM tiraje_comprobante WHERE idcomprobante = 1);
        SET p_moneda = (SELECT CurrencyName	FROM currency WHERE idcurrency = p_idcurrency);
		SET p_simbolo = (SELECT Symbol FROM currency WHERE idcurrency = p_idcurrency);




		IF (p_idabono = '') THEN

        SET p_idcredito = (SELECT idcredito FROM abono WHERE idabono = p_idmax);
        SET p_fecha_abono = (SELECT fecha_abono FROM abono where idabono = p_idmax);
        SET p_monto_abono = (SELECT monto_abono FROM abono where idabono = p_idmax);
        SET p_total_abonado = (SELECT total_abonado FROM abono where idabono = p_idmax);
        SET p_restante_credito = (SELECT restante_credito FROM abono where idabono = p_idmax);
        SET p_usuario = (SELECT usuario FROM view_abonos where idabono = p_idmax);
		SET p_codigo_credito = (SELECT codigo_credito FROM credito WHERE idcredito = p_idcredito);
        SET p_monto_credito = (SELECT monto_credito  FROM credito WHERE idcredito = p_idcredito);
        SET p_monto_abonado = (SELECT monto_abonado FROM credito WHERE idcredito = p_idcredito);
        SET p_monto_restante = (SELECT monto_restante FROM credito WHERE idcredito = p_idcredito);
        SET p_cliente = (SELECT cliente FROM view_creditos_venta WHERE idcredito = p_idcredito);


        SELECT p_empresa, p_propietario, p_direccion, p_clave_rfc , p_regimen_fiscal,
        DATE_FORMAT(p_fecha_resolucion,'%d/%m/%Y %k:%i %p')  as p_fecha_resolucion,p_numero_resolucion,
        p_serie,p_fecha_abono,p_monto_abono,p_codigo_credito,p_monto_credito,p_monto_abonado,p_monto_restante,
        p_total_abonado,p_restante_credito,p_moneda,p_simbolo,p_cliente,p_usuario;

        ELSE

        SET p_idcredito = (SELECT idcredito FROM abono WHERE idabono = p_idabono);
        SET p_fecha_abono = (SELECT fecha_abono FROM abono where idabono = p_idabono);
        SET p_monto_abono = (SELECT monto_abono FROM abono where idabono = p_idabono);
		SET p_total_abonado = (SELECT total_abonado FROM abono where idabono = p_idabono);
        SET p_usuario = (SELECT usuario FROM view_abonos where idabono = p_idabono);
        SET p_restante_credito = (SELECT restante_credito FROM abono where idabono = p_idabono);
		SET p_codigo_credito = (SELECT codigo_credito FROM credito WHERE idcredito = p_idcredito);
        SET p_monto_credito = (SELECT monto_credito  FROM credito WHERE idcredito = p_idcredito);
        SET p_monto_abonado = (SELECT monto_abonado FROM credito WHERE idcredito = p_idcredito);
        SET p_monto_restante = (SELECT monto_restante FROM credito WHERE idcredito = p_idcredito);
        SET p_cliente = (SELECT cliente FROM view_creditos_venta WHERE idcredito = p_idcredito);

        SELECT p_empresa, p_propietario, p_direccion, p_clave_rfc , p_regimen_fiscal,
        DATE_FORMAT(p_fecha_resolucion,'%d/%m/%Y %k:%i %p')  as p_fecha_resolucion,p_numero_resolucion,
        p_serie,p_fecha_abono,p_monto_abono,p_codigo_credito,p_monto_credito,p_monto_abonado,p_monto_restante,
        p_total_abonado,p_restante_credito,p_moneda,p_simbolo,p_cliente,p_usuario;

		END IF;

	END //
	DELIMITER ;

	DROP PROCEDURE IF EXISTS sp_view_total_abonos_fechas;
	DELIMITER //
	CREATE PROCEDURE sp_view_total_abonos_fechas(
		IN p_date	varchar(10),
		IN p_date2  varchar(10)
	)
	BEGIN
		 SELECT codigo_credito, nombre_credito, monto_abono, DATE_FORMAT(fecha_abono,'%d/%m/%Y') as fecha_abono
         FROM view_abonos WHERE DATE_FORMAT(fecha_abono,'%Y-%m-%d') BETWEEN p_date AND p_date2
		 ORDER BY monto_abono, DATE_FORMAT(fecha_abono,'%d/%m/%Y')  DESC;
	END //
	DELIMITER ;

-- CREDITOS


-- COTIZACIONES

DROP PROCEDURE IF EXISTS sp_insert_cotizacion;
DELIMITER //
CREATE PROCEDURE sp_insert_cotizacion(
IN p_a_nombre varchar(175),
IN p_tipo_pago varchar(60),
IN p_entrega varchar(60),
IN p_sumas decimal(8,2),
IN p_iva decimal(8,2),
IN p_exento decimal(8,2),
IN p_retenido decimal(8,2),
IN p_descuento decimal(8,2),
IN p_total decimal(8,2),
IN p_sonletras varchar(150),
IN p_idusuario int(11),
IN p_idcliente int(11)
)
BEGIN
INSERT INTO `cotizacion`(`fecha_cotizacion`, `a_nombre`,
`tipo_pago`, `entrega`, `sumas`, `iva`,
`exento`, `retenido`, `descuento`, `total`,
`sonletras`,`idusuario`,`idcliente`)
VALUES (NOW(), p_a_nombre,
p_tipo_pago, p_entrega, p_sumas, p_iva,
p_exento, p_retenido, p_descuento, p_total,
p_sonletras, p_idusuario,p_idcliente);
END //
DELIMITER ;




DROP PROCEDURE IF EXISTS sp_view_cotizacion;
DELIMITER //
CREATE PROCEDURE sp_view_cotizacion(
	p_fecha  DATE,
    p_fecha2 DATE
)
BEGIN
	  IF(p_fecha = '' AND p_fecha2 ='') THEN

			SELECT * FROM view_cotizaciones
			GROUP BY numero_cotizacion;

	   ELSE
			SELECT * FROM view_cotizaciones WHERE
			fecha_cotizacion BETWEEN p_fecha AND p_fecha2
			GROUP BY numero_cotizacion;

	  END IF;
END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_insert_detallecotizacion;
DELIMITER //
CREATE PROCEDURE sp_insert_detallecotizacion(
IN p_idproducto int(11),
IN p_cantidad decimal(8,2),
IN p_disponible tinyint(1),
IN p_precio_unitario decimal(8,2),
IN p_exento decimal(8,2),
IN p_descuento decimal(8,2),
IN p_importe decimal(8,2)
)
BEGIN
	DECLARE p_idcotizacion int(11);
	SET p_idcotizacion  = (SELECT MAX(idcotizacion) FROM cotizacion);

    IF p_idcotizacion IS NULL OR p_idcotizacion = '' THEN
		INSERT INTO `detallecotizacion`(`idcotizacion`, `idproducto`, `cantidad`, `disponible`,
        `precio_unitario`, `exento`, `descuento`, `importe`)
		VALUES (1, p_idproducto, p_cantidad, p_disponible, p_precio_unitario,
		p_exento, p_descuento, p_importe);
	ELSE
		INSERT INTO `detallecotizacion`(`idcotizacion`, `idproducto`, `cantidad`, `disponible`,
        `precio_unitario`,
		`exento`, `descuento`, `importe`)
		VALUES (p_idcotizacion, p_idproducto, p_cantidad, p_disponible, p_precio_unitario,
		p_exento, p_descuento, p_importe);

    END IF;
END //
DELIMITER ;




DROP PROCEDURE IF EXISTS sp_view_cotizacion_detalle;
DELIMITER //
CREATE PROCEDURE sp_view_cotizacion_detalle(
	p_idcotizacion int
)
BEGIN
	IF  p_idcotizacion  = '' THEN

		SET p_idcotizacion = (SELECT MAX(idcotizacion) FROM cotizacion);

		SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,disponible,
		nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,importe
		FROM view_cotizaciones WHERE idcotizacion = p_idcotizacion;

	ELSE

		SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,disponible,
		nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,importe
		FROM view_cotizaciones WHERE idcotizacion = p_idcotizacion;

    END IF;

END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_delete_cotizacion;
DELIMITER //
CREATE PROCEDURE sp_delete_cotizacion(
IN p_idcotizacion int(11))
BEGIN
DELETE FROM `cotizacion`
WHERE `idcotizacion` = p_idcotizacion;
END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_view_info_cotizacion;
DELIMITER //
CREATE PROCEDURE sp_view_info_cotizacion(
	IN p_idcotizacion INT(11)
)
BEGIN

	IF  p_idcotizacion  = '' THEN

		SET p_idcotizacion = (SELECT MAX(idcotizacion) FROM cotizacion);

		SELECT numero_cotizacion,fecha_cotizacion,a_nombre,clave_rfc,
        direccion_cliente,numero_telefono,email,tipo_pago,entrega,
		sumas,iva,(sumas + iva) as subtotal,
		total_exento,retenido,total_descuento,total,empleado
		FROM view_cotizaciones WHERE idcotizacion = p_idcotizacion
		GROUP BY numero_cotizacion;

    ELSE

		SELECT numero_cotizacion,fecha_cotizacion,a_nombre,clave_rfc,
        direccion_cliente,numero_telefono,email,tipo_pago,entrega,
		sumas,iva,(sumas + iva) as subtotal,
		total_exento,retenido,total_descuento,total,empleado
		FROM view_cotizaciones WHERE idcotizacion = p_idcotizacion
		GROUP BY numero_cotizacion;

    END IF;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_count_cotizaciones;
DELIMITER //
CREATE PROCEDURE sp_count_cotizaciones(
	IN p_date	varchar(10),
	IN p_date2  varchar(10)
)
	BEGIN

		IF (p_date = '' AND p_date2 = '') THEN

			SELECT COUNT(*) AS total_cotizaciones FROM cotizacion;

		ELSE

			SELECT COUNT(*) AS total_cotizaciones
            FROM cotizacion WHERE fecha_cotizacion
            BETWEEN p_date AND p_date2;

		END IF;


END //
DELIMITER ;


-- COTIZACIONES


-- TALLER

DROP PROCEDURE IF EXISTS sp_insert_tecnico;
DELIMITER //
CREATE PROCEDURE sp_insert_tecnico(
IN p_tecnico varchar(150),
IN p_telefono varchar(20)
)
BEGIN
 IF NOT EXISTS (SELECT * FROM tecnico WHERE tecnico = p_tecnico) THEN
	INSERT INTO `tecnico`(`tecnico`, `telefono`)
	VALUES (p_tecnico, p_telefono);
 END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_tecnico;
DELIMITER //
CREATE PROCEDURE sp_view_tecnico()
BEGIN
	SELECT `idtecnico`, `tecnico`, `telefono`, `estado`
	FROM `tecnico`;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_tecnico_activo;
DELIMITER //
CREATE PROCEDURE sp_view_tecnico_activo()
BEGIN
	SELECT `idtecnico`, `tecnico`, `telefono`, `estado`
	FROM `tecnico` WHERE `estado` = 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_tecnico;
DELIMITER //
CREATE PROCEDURE sp_update_tecnico(
IN p_idtecnico int(11),
IN p_tecnico varchar(150),
IN p_telefono varchar(20),
IN p_estado tinyint(1)
)
BEGIN
	UPDATE `tecnico`
	SET `tecnico` = p_tecnico, `telefono` = p_telefono, `estado` = p_estado
	WHERE `idtecnico` = p_idtecnico;
END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_insert_ordentaller;
DELIMITER //
CREATE PROCEDURE sp_insert_ordentaller(
IN p_idcliente int(11),
IN p_aparato varchar(125),
IN p_modelo varchar(125),
IN p_idmarca int(11),
IN p_serie varchar(125),
IN p_idtecnico int(11),
IN p_averia varchar(200),
IN p_observaciones varchar(200),
IN p_deposito_revision decimal(8,2),
IN p_deposito_reparacion decimal(8,2),
IN p_parcial_pagar decimal(8,2)
)
BEGIN
	INSERT INTO `ordentaller`(`fecha_ingreso`, `idcliente`,
	`aparato`, `modelo`, `idmarca`, `serie`, `idtecnico`, `averia`, `observaciones`, `deposito_revision`,
	`deposito_reparacion`,`parcial_pagar`)
	VALUES (NOW(), p_idcliente,
	p_aparato, p_modelo, p_idmarca, p_serie,
	p_idtecnico, p_averia, p_observaciones, p_deposito_revision,
	p_deposito_reparacion,p_parcial_pagar);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_insert_diagnostico;
DELIMITER //
CREATE PROCEDURE sp_insert_diagnostico(
IN p_idorden int(11),
IN p_diagnostico varchar(200),
IN p_estado_aparato varchar(200),
IN p_repuestos decimal(8,2),
IN p_mano_obra decimal(8,2),
IN p_fecha_alta datetime,
IN p_fecha_retiro datetime,
IN p_ubicacion varchar(150),
IN p_parcial_pagar decimal(8,2)
)
BEGIN
	UPDATE `ordentaller`
	SET `diagnostico` = p_diagnostico, `estado_aparato` = p_estado_aparato,
    `repuestos` = p_repuestos, `mano_obra` = p_mano_obra, `fecha_alta` = p_fecha_alta,
    `fecha_retiro` = p_fecha_retiro, `ubicacion` = p_ubicacion, `parcial_pagar` = p_parcial_pagar
	WHERE `idorden` = p_idorden;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_ordentaller;
DELIMITER //
CREATE PROCEDURE sp_update_ordentaller(
IN p_idorden int(11),
IN p_numero_orden varchar(175),
IN p_fecha_ingreso datetime,
IN p_idcliente int(11),
IN p_aparato varchar(125),
IN p_modelo varchar(125),
IN p_idmarca int(11),
IN p_serie varchar(125),
IN p_idtecnico int(11),
IN p_averia varchar(200),
IN p_observaciones varchar(200),
IN p_deposito_revision decimal(8,2),
IN p_deposito_reparacion decimal(8,2)
)
BEGIN
	DECLARE p_repuestos DECIMAL(8,2);
    DECLARE p_mano_obra DECIMAL(8,2);
    DECLARE p_costo_reparacion DECIMAL(8,2);
    DECLARE p_depositos DECIMAL(8,2);
    DECLARE p_parcial_pagar DECIMAL(8,2);

    SET p_repuestos = (SELECT repuestos FROM ordentaller WHERE idorden = p_idorden);
	SET p_mano_obra = (SELECT mano_obra FROM ordentaller WHERE idorden = p_idorden);

    SET p_costo_reparacion = (p_repuestos + p_mano_obra);
    SET p_depositos = (p_deposito_revision + p_deposito_reparacion);

    SET p_parcial_pagar = (p_costo_reparacion - p_depositos);

	UPDATE `ordentaller`
	SET `numero_orden` = p_numero_orden, `fecha_ingreso` = p_fecha_ingreso,
    `idcliente` = p_idcliente, `aparato` = p_aparato,
	`modelo` = p_modelo, `idmarca` = p_idmarca,
    `serie` = p_serie, `idtecnico` = p_idtecnico,
	`averia` = p_averia,
    `observaciones` = p_observaciones,
    `deposito_revision` = p_deposito_revision,
    `deposito_reparacion` = p_deposito_reparacion,
    `parcial_pagar` = p_parcial_pagar
	 WHERE `idorden` = p_idorden;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_ordentaller;
DELIMITER //
CREATE PROCEDURE sp_update_ordentaller(
IN p_idorden int(11),
IN p_numero_orden varchar(175),
IN p_fecha_ingreso datetime,
IN p_idcliente int(11),
IN p_aparato varchar(125),
IN p_modelo varchar(125),
IN p_idmarca int(11),
IN p_serie varchar(125),
IN p_idtecnico int(11),
IN p_averia varchar(200),
IN p_observaciones varchar(200),
IN p_deposito_revision decimal(8,2),
IN p_deposito_reparacion decimal(8,2),
IN p_diagnostico varchar(200),
IN p_estado_aparato varchar(200),
IN p_repuestos decimal(8,2),
IN p_mano_obra decimal(8,2),
IN p_fecha_alta datetime,
IN p_fecha_retiro datetime,
IN p_ubicacion varchar(150),
IN p_parcial_pagar decimal(8,2)
)
BEGIN
UPDATE `ordentaller`
SET `numero_orden` = p_numero_orden, `fecha_ingreso` = p_fecha_ingreso, `idcliente` = p_idcliente, `aparato` = p_aparato,
`modelo` = p_modelo, `idmarca` = p_idmarca, `serie` = p_serie, `idtecnico` = p_idtecnico,
`averia` = p_averia, `observaciones` = p_observaciones, `deposito_revision` = p_deposito_revision, `deposito_reparacion` = p_deposito_reparacion,
`diagnostico` = p_diagnostico, `estado_aparato` = p_estado_aparato, `repuestos` = p_repuestos, `mano_obra` = p_mano_obra,
`fecha_alta` = p_fecha_alta, `fecha_retiro` = p_fecha_retiro, `ubicacion` = p_ubicacion, `parcial_pagar` = p_parcial_pagar
WHERE `idorden` = p_idorden;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_ordentaller;
DELIMITER //
CREATE PROCEDURE sp_view_ordentaller(
	IN p_date	varchar(10),
	IN p_date2  varchar(10)
)
BEGIN

 IF (p_date = '' AND p_date2 = '') THEN
		SELECT * FROM view_taller ORDER BY fecha_ingreso DESC;
	ELSE
		 SELECT * FROM view_taller WHERE DATE_FORMAT(fecha_ingreso,'%Y-%m-%d') BETWEEN p_date AND p_date2
		 ORDER BY  DATE_FORMAT(fecha_ingreso,'%Y-%m-%d') DESC;
    END IF;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_count_ordenes;
DELIMITER //
CREATE PROCEDURE sp_count_ordenes(
	IN p_date	varchar(10),
	IN p_date2  varchar(10)
)
BEGIN

 IF (p_date = '' AND p_date2 = '') THEN
		SELECT COUNT(*) as total_ordenes FROM view_taller ORDER BY fecha_ingreso DESC;
	ELSE
		 SELECT COUNT(*) as total_ordenes  FROM view_taller WHERE DATE_FORMAT(fecha_ingreso,'%Y-%m-%d') BETWEEN p_date AND p_date2
		 ORDER BY  DATE_FORMAT(fecha_ingreso,'%Y-%m-%d') DESC;
    END IF;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_delete_ordentaller;
DELIMITER //
CREATE PROCEDURE sp_delete_ordentaller(
IN p_idorden int(11))
BEGIN
	DELETE FROM `ordentaller`
	WHERE `idorden` = p_idorden;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_view_report_ordentaller;
DELIMITER //
CREATE PROCEDURE sp_view_report_ordentaller(
	IN p_id INT
)
BEGIN
	DECLARE p_idmax int;
	 IF (p_id  = '0') THEN
		SET p_idmax = (SELECT MAX(idorden) FROM ordentaller);
		SELECT * FROM view_taller WHERE idorden = p_idmax;
	 ELSE
		 SELECT * FROM view_taller WHERE idorden = p_id;
	 END IF;
END //
DELIMITER ;
-- TALLER


-- APARTADOS

DROP PROCEDURE IF EXISTS sp_insert_apartado;
DELIMITER //
CREATE PROCEDURE sp_insert_apartado(
IN p_fecha_limite_retiro datetime,
IN p_sumas decimal(8,2),
IN p_iva decimal(8,2),
IN p_exento decimal(8,2),
IN p_retenido decimal(8,2),
IN p_descuento decimal(8,2),
IN p_total decimal(8,2),
IN p_abonado_apartado decimal(8,2),
IN p_restante_pagar decimal(8,2),
IN p_sonletras varchar(150),
IN p_idcliente int(11),
IN p_idusuario int(11)
)
BEGIN
	INSERT INTO `apartado`(`fecha_apartado`,
	`fecha_limite_retiro`, `sumas`, `iva`, `exento`, `retenido`, `descuento`,
	`total`, `abonado_apartado`, `restante_pagar`, `sonletras`,`idcliente`, `idusuario`)
	VALUES (NOW(), p_fecha_limite_retiro,
	p_sumas, p_iva, p_exento, p_retenido, p_descuento, p_total, p_abonado_apartado,
	p_restante_pagar, p_sonletras, p_idcliente, p_idusuario);

    CALL sp_insert_caja_apartado(p_abonado_apartado);

END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_insert_detalleapartado;
DELIMITER //
CREATE PROCEDURE sp_insert_detalleapartado(
IN p_idproducto int(11),
IN p_cantidad decimal(8,2),
IN p_precio_unitario decimal(8,2),
IN p_exento decimal(8,2),
IN p_descuento decimal(8,2),
IN p_fecha_vence date,
IN p_importe decimal(8,2)
)
BEGIN

	DECLARE p_idapartado int(11);
    DECLARE p_numero_apartado VARCHAR(175);
    DECLARE p_precio_compra DECIMAL(8,2);
    DECLARE p_costo DECIMAL(8,2);
    DECLARE p_total DECIMAL(8,2);
    DECLARE p_descr_salida varchar(150);
    DECLARE p_inventariable int(11);
    DECLARE	p_estado tinyint(1);
    DECLARE p_stock DECIMAL(8,2);
    DECLARE p_cantidad_perecedero DECIMAL(8,2);


    SET p_idapartado = (SELECT MAX(idapartado) FROM apartado);
    SET p_total = (SELECT total FROM apartado WHERE idapartado = p_idapartado);
    SET p_precio_compra = (SELECT precio_compra FROM producto WHERE idproducto = p_idproducto);
    SET p_numero_apartado = (SELECT numero_apartado FROM apartado WHERE idapartado = p_idapartado);
    SET p_costo = (p_cantidad * p_precio_compra);


    SET p_descr_salida = (CONCAT('POR APARTADO',' # ',p_numero_apartado));
    SET p_inventariable = (SELECT inventariable FROM producto WHERE idproducto = p_idproducto);
    SET p_estado = (SELECT estado FROM apartado WHERE idapartado = p_idapartado);
    SET p_cantidad_perecedero = (SELECT cantidad_perecedero FROM perecedero WHERE idproducto = p_idproducto
    AND fecha_vencimiento = p_fecha_vence AND estado = 1);
    SET p_stock = (SELECT stock FROM producto WHERE idproducto = p_idproducto);

		IF (p_inventariable  = 0) THEN

			IF p_idapartado IS NULL OR p_idapartado= '' THEN

				INSERT INTO `detalleapartado`(`idapartado`, `idproducto`, `cantidad`, `precio_unitario`,
				`fecha_vence`, `exento`, `descuento`, `importe`)
				VALUES (1, p_idproducto, p_cantidad, p_precio_unitario,
				p_fecha_vence, p_exento, p_descuento, p_importe);


				ELSE

				INSERT INTO `detalleapartado`(`idapartado`, `idproducto`, `cantidad`, `precio_unitario`,
				`fecha_vence`, `exento`, `descuento`, `importe`)
				VALUES (p_idapartado, p_idproducto, p_cantidad, p_precio_unitario,
				p_fecha_vence, p_exento, p_descuento, p_importe);

			END IF; -- IF p_idapartadoIS NULL OR p_idapartado= '' THEN


		ELSE -- ELSE p_inventariable  = 0

			IF (p_fecha_vence != '2000-01-01') THEN

				IF p_idapartado IS NULL OR p_idapartado= '' THEN

                    IF (p_stock > 0) THEN

							INSERT INTO `detalleapartado`(`idapartado`, `idproducto`, `cantidad`, `precio_unitario`,
							`fecha_vence`, `exento`, `descuento`, `importe`)
							VALUES (1, p_idproducto, p_cantidad, p_precio_unitario,
							p_fecha_vence, p_exento, p_descuento, p_importe);

							INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
							`precio_unitario_salida`, `costo_total_salida`,`idproducto`,`idapartado`)
							VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_salida,p_cantidad,p_precio_compra,p_costo,p_idproducto,1);

							UPDATE `inventario` SET
							`saldo_final` = `saldo_final` - p_cantidad,
							`salidas` = `salidas` + p_cantidad
							WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
							AND fecha_cierre = LAST_DAY(CURDATE());

							CALL sp_descontar_perecedero(p_idproducto, p_cantidad, p_fecha_vence);

							UPDATE `producto` SET
							`stock` = `stock` - p_cantidad
							WHERE idproducto = p_idproducto;

                    END IF; -- IF p_stock > 0;

			ELSE -- ELSE p_idapartado IS NULL OR p_idapartado= ''

					 IF (p_stock > 0) THEN

							INSERT INTO `detalleapartado`(`idapartado`, `idproducto`, `cantidad`, `precio_unitario`,
							`fecha_vence`, `exento`, `descuento`, `importe`)
							VALUES (p_idapartado, p_idproducto, p_cantidad, p_precio_unitario,
							p_fecha_vence, p_exento, p_descuento, p_importe);

							INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
							`precio_unitario_salida`, `costo_total_salida`,`idproducto`,`idapartado`)
							VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_salida,p_cantidad,p_precio_compra,p_costo,p_idproducto,p_idapartado);

							UPDATE `inventario` SET
							`saldo_final` = `saldo_final` - p_cantidad,
							`salidas` = `salidas` + p_cantidad
							WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
							AND fecha_cierre = LAST_DAY(CURDATE());

							CALL sp_descontar_perecedero(p_idproducto, p_cantidad, p_fecha_vence);

							UPDATE `producto` SET
							`stock` = `stock` - p_cantidad
							WHERE idproducto = p_idproducto;

						END IF; -- IF p_stock > 0;

					END IF; -- IF p_idapartadoIS NULL OR p_idapartado= ''

				ELSE  -- ELSE p_fecha_vencimiento != '2000-01-01'

                IF p_idapartado IS NULL OR p_idapartado= '' THEN

                    IF (p_stock > 0) THEN

                            INSERT INTO `detalleapartado`(`idapartado`, `idproducto`, `cantidad`, `precio_unitario`,
							`fecha_vence`, `exento`, `descuento`, `importe`)
							VALUES (1, p_idproducto, p_cantidad, p_precio_unitario,
							NULL, p_exento, p_descuento, p_importe);

							INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
							`precio_unitario_salida`, `costo_total_salida`,`idproducto`,`idapartado`)
							VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_salida,p_cantidad,p_precio_compra,p_costo,p_idproducto,1);

							UPDATE `inventario` SET
							`saldo_final` = `saldo_final` - p_cantidad,
							`salidas` = `salidas` + p_cantidad
							WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
							AND fecha_cierre = LAST_DAY(CURDATE());


							UPDATE `producto` SET
							`stock` = `stock` - p_cantidad
							WHERE idproducto = p_idproducto;

                    END IF; -- IF p_stock > 0;

			ELSE -- ELSE p_idapartadoIS NULL OR p_idapartado= ''

					 IF (p_stock > 0) THEN

							INSERT INTO `detalleapartado`(`idapartado`, `idproducto`, `cantidad`, `precio_unitario`,
							`fecha_vence`, `exento`, `descuento`, `importe`)
							VALUES (p_idapartado, p_idproducto, p_cantidad, p_precio_unitario,
							NULL, p_exento, p_descuento, p_importe);

							INSERT INTO `salida`(`mes_inventario`,`fecha_salida`, `descripcion_salida`, `cantidad_salida`,
							`precio_unitario_salida`, `costo_total_salida`,`idproducto`,`idapartado`)
							VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),NOW(),p_descr_salida,p_cantidad,p_precio_compra,p_costo,p_idproducto,p_idapartado);

							UPDATE `inventario` SET
							`saldo_final` = `saldo_final` - p_cantidad,
							`salidas` = `salidas` + p_cantidad
							WHERE idproducto = p_idproducto AND fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
							AND fecha_cierre = LAST_DAY(CURDATE());


							UPDATE `producto` SET
							`stock` = `stock` - p_cantidad
							WHERE idproducto = p_idproducto;

						END IF; -- IF p_stock > 0;

					END IF; -- IF p_idapartadoIS NULL OR p_idapartado= ''

			END IF; -- IF p_fecha_vencimiento != '2000-01-01'

		END IF;  -- IF p_inventariable  = 0

END //
DELIMITER ;


-- APARTADOS


-- CONSULTA APARTADOS

DROP PROCEDURE IF EXISTS sp_consulta_apartados_totales;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_apartados_totales(
		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10),
        IN p_estado varchar(2)
    )
	BEGIN

		IF(p_criterio = 'MES') THEN

		  IF (p_date = '')THEN

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE MONTH(fecha_apartado) = MONTH(CURDATE());

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE MONTH(fecha_apartado) = MONTH(CURDATE())
					AND estado = p_estado;

				END IF;


			ELSE

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE MONTH(fecha_apartado) = p_date;

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE MONTH(fecha_apartado) = p_date
					AND estado = p_estado;

				END IF;

		  END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

		   IF (p_date = '' AND p_date2 ='')THEN

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE MONTH(fecha_apartado) = MONTH(CURDATE());

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE MONTH(fecha_apartado) = MONTH(CURDATE());

				END IF;

			ELSE

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE fecha_apartado BETWEEN p_date AND p_date2;

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE fecha_apartado BETWEEN p_date AND p_date2
					AND estado = p_estado;

				END IF;

			END IF;

		ELSEIF (p_criterio = 'HOY') THEN

				IF(p_estado = '') THEN
					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE DATE_FORMAT(fecha_apartado,'%Y-%m-%d') = CURDATE();

				ELSEIF (p_estado != '') THEN

					SELECT SUM(iva) as total_iva, SUM(exento) as total_exento,
                    SUM(retenido) as total_retenido, SUM(descuento) as total_descuento,
                    SUM(total) as total_apartado FROM apartado
                    WHERE DATE_FORMAT(fecha_apartado,'%Y-%m-%d') = CURDATE()
					AND estado = p_estado;

				END IF;

        END IF;

	END //
	DELIMITER ;

	DROP PROCEDURE IF EXISTS sp_consulta_apartados;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_apartados(
		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10),
        IN p_estado varchar(2)
    )
	BEGIN

		IF(p_criterio = 'MES') THEN

		  IF (p_date = '')THEN

				IF(p_estado = '') THEN
					SELECT * FROM view_apartados WHERE MONTH(fecha_apartado) = MONTH(CURDATE())
                    GROUP BY numero_apartado;

				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_apartados WHERE MONTH(fecha_apartado) = MONTH(CURDATE())
					AND estado_apartado = p_estado  GROUP BY numero_apartado;


				END IF;


			ELSE

				IF(p_estado = '') THEN
					SELECT * FROM view_apartados WHERE MONTH(fecha_apartado) = p_date 
                     GROUP BY numero_apartado;


				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_apartados WHERE MONTH(fecha_apartado) = p_date
					AND estado_apartado = p_estado  GROUP BY numero_apartado;


				END IF;

		  END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

		   IF (p_date = '' AND p_date2 ='')THEN

				IF(p_estado = '') THEN
					SELECT * FROM view_apartados WHERE MONTH(fecha_apartado) = MONTH(CURDATE())
                     GROUP BY numero_apartado;


				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_apartados WHERE MONTH(fecha_apartado) = MONTH(CURDATE())
					AND estado_apartado = p_estado  GROUP BY numero_apartado;


				END IF;

			ELSE

				IF(p_estado = '') THEN
					SELECT * FROM view_apartados WHERE fecha_apartado BETWEEN p_date AND p_date2
                     GROUP BY numero_apartado;

				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_apartados WHERE fecha_apartado BETWEEN p_date AND p_date2
					AND estado_apartado = p_estado GROUP BY numero_apartado;


				END IF;

			END IF;

		ELSEIF (p_criterio = 'HOY') THEN

				IF(p_estado = '') THEN
					SELECT * FROM view_apartados WHERE DATE_FORMAT(fecha_apartado,'%Y-%m-%d') = CURDATE()
                     GROUP BY numero_apartado;

				ELSEIF (p_estado != '') THEN

					SELECT * FROM view_apartados WHERE DATE_FORMAT(fecha_apartado,'%Y-%m-%d') = CURDATE()
					AND estado_apartado = p_estado GROUP BY numero_apartado;

				END IF;

        END IF;

	END //
	DELIMITER ;


DROP PROCEDURE IF EXISTS sp_consulta_apartados_detalle;
	DELIMITER //
	CREATE PROCEDURE sp_consulta_apartados_detalle(
		IN p_criterio VARCHAR(10),
        IN p_date	varchar(10),
        IN p_date2  varchar(10),
        IN p_estado varchar(2)
    )
	BEGIN


		IF(p_criterio = 'MES') THEN

		  IF (p_date = '')THEN

				IF(p_estado = '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE MONTH(fecha_apartado) = MONTH(CURDATE()) ;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE MONTH(fecha_apartado) = MONTH(CURDATE())
					AND estado_apartado = p_estado
					;

				END IF;


			ELSE

				IF(p_estado = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE MONTH(fecha_apartado) = p_date;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE MONTH(fecha_apartado) = p_date
					AND estado_apartado = p_estado
					;

				END IF;

		  END IF;

		ELSEIF (p_criterio = 'FECHAS') THEN

		   IF (p_date = '' AND p_date2 ='')THEN

				IF(p_estado = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE MONTH(fecha_apartado) = MONTH(CURDATE())
					;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE MONTH(fecha_apartado) = MONTH(CURDATE())
					AND estado_apartado = p_estado
					;

				END IF;

			ELSE

				IF(p_estado = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE fecha_apartado BETWEEN p_date AND p_date2
					;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE fecha_apartado BETWEEN p_date AND p_date2
					AND estado_apartado = p_estado
					;

				END IF;

			END IF;

		ELSEIF (p_criterio = 'HOY') THEN

				IF(p_estado = '') THEN
					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE DATE_FORMAT(fecha_apartado,'%Y-%m-%d') = CURDATE()
					;

				ELSEIF (p_estado != '') THEN

					SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
					nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,(importe-descuento)
                    as importe,sumas,
					iva,total_exento,retenido,total_descuento,total,fecha_vence,precio_compra,
					((precio_unitario - precio_compra) * cantidad) - descuento AS utilidad_total
					FROM view_apartados WHERE DATE_FORMAT(fecha_apartado,'%Y-%m-%d') = CURDATE()
					AND estado_apartado = p_estado
					;

				END IF;

        END IF;

	END //
	DELIMITER ;

  DROP PROCEDURE IF EXISTS sp_count_apartados;
 DELIMITER //
 CREATE PROCEDURE sp_count_apartados(

   IN p_criterio VARCHAR(10),
       IN p_date	varchar(10),
       IN p_date2  varchar(10)
   )
 BEGIN

       DECLARE apartados_anuladas INT;
       DECLARE apartados_vigentes INT;
	   DECLARE apartados_saldados INT;

   IF (p_criterio = 'MES') THEN

     IF (p_date = '') THEN

       SET apartados_anuladas = (SELECT COUNT(*) AS apartados_anuladas
	   FROM apartado WHERE estado = 0 AND DATE_FORMAT(fecha_apartado,'%m-%Y') =  MONTH(CURDATE()));
       SET apartados_vigentes = (SELECT COUNT(*) AS apartados_vigentes
	   FROM apartado WHERE estado = 1 AND DATE_FORMAT(fecha_apartado,'%m-%Y') = MONTH(CURDATE()));
	   SET apartados_saldados = (SELECT COUNT(*) AS apartados_vigentes
	   FROM apartado WHERE estado = 2 AND DATE_FORMAT(fecha_apartado,'%m-%Y') = MONTH(CURDATE()));

		SELECT apartados_anuladas,apartados_vigentes,apartados_saldados;

     ELSE

       SET apartados_anuladas = (SELECT COUNT(*) AS apartados_anuladas FROM apartado
	   WHERE DATE_FORMAT(fecha_apartado,'%m-%Y') = p_date AND estado = 0 );
       SET apartados_vigentes = (SELECT COUNT(*) AS apartados_vigentes FROM apartado
	   WHERE DATE_FORMAT(fecha_apartado,'%m-%Y') = p_date AND estado = 1);
	   SET apartados_saldados = (SELECT COUNT(*) AS apartados_vigentes FROM apartado
	   WHERE DATE_FORMAT(fecha_apartado,'%m-%Y') = p_date AND estado = 2);

       SELECT apartados_anuladas,apartados_vigentes,apartados_saldados;

           END IF;

   ELSEIF (p_criterio = 'FECHAS') THEN

       IF (p_date = '' AND p_date2 = '') THEN

       SET apartados_anuladas = (SELECT COUNT(*) AS apartados_anuladas
       FROM apartado WHERE estado = 0 AND DATE_FORMAT(fecha_apartado,'%m-%Y') =  MONTH(CURDATE()));
       SET apartados_vigentes = (SELECT COUNT(*) AS apartados_vigentes
	   FROM apartado WHERE estado = 1 AND DATE_FORMAT(fecha_apartado,'%m-%Y') = MONTH(CURDATE()));
	   SET apartados_saldados = (SELECT COUNT(*) AS apartados_vigentes
	   FROM apartado WHERE estado = 2 AND DATE_FORMAT(fecha_apartado,'%m-%Y') = MONTH(CURDATE()));

		SELECT apartados_anuladas,apartados_vigentes,apartados_saldados;

     ELSE

       SET apartados_anuladas = (SELECT COUNT(*) AS apartados_anuladas FROM apartado
       WHERE estado = 0 AND DATE_FORMAT(fecha_apartado,'%Y-%m-%d') BETWEEN p_date AND p_date2);
       SET apartados_vigentes = (SELECT COUNT(*) AS apartados_vigentes FROM apartado
       WHERE estado = 1 AND DATE_FORMAT(fecha_apartado,'%Y-%m-%d') BETWEEN p_date AND p_date2);
	   SET apartados_saldados = (SELECT COUNT(*) AS apartados_vigentes FROM apartado
       WHERE estado = 2 AND DATE_FORMAT(fecha_apartado,'%Y-%m-%d') BETWEEN p_date AND p_date2);

       SELECT apartados_anuladas,apartados_vigentes,apartados_saldados;

           END IF;

   ELSEIF (p_criterio = 'HOY') THEN

     SET apartados_anuladas = (SELECT COUNT(*) AS apartados_anuladas
     FROM apartado WHERE estado = 0 AND DATE_FORMAT(fecha_apartado,'%Y-%m-%d') =  CURDATE());
     SET apartados_vigentes = (SELECT COUNT(*) AS apartados_vigentes
     FROM apartado WHERE estado = 1 AND DATE_FORMAT(fecha_apartado,'%Y-%m-%d') =  CURDATE());
     SET apartados_saldados = (SELECT COUNT(*) AS apartados_vigentes
     FROM apartado WHERE estado = 2 AND DATE_FORMAT(fecha_apartado,'%Y-%m-%d') =  CURDATE());


     SELECT apartados_anuladas,apartados_vigentes,apartados_saldados;

 END IF;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_apartado;
DELIMITER //
CREATE PROCEDURE sp_view_apartado(
	IN p_idapartado INT(11)
)
BEGIN

	SELECT numero_apartado,fecha_apartado,fecha_limite_retiro,cliente,
    sumas,iva,(sumas + iva) as subtotal,
    total_exento,retenido,total_descuento,total
    FROM view_apartados WHERE idapartado = p_idapartado
    GROUP BY numero_apartado;

END //
DELIMITER ;



DROP PROCEDURE IF EXISTS sp_view_detalleapartado;
DELIMITER //
CREATE PROCEDURE sp_view_detalleapartado(
	IN p_idapartado INT(11)
)
BEGIN

	SELECT idproducto,codigo_barra,codigo_interno,nombre_producto,
	nombre_marca,siglas,cantidad,precio_unitario,exento,descuento,importe,sumas,
	iva,total_exento,retenido,total_descuento,total,fecha_vence FROM
	view_apartados WHERE idapartado = p_idapartado;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_imprimir_ticket_apartado;
	DELIMITER //
	CREATE PROCEDURE sp_imprimir_ticket_apartado(
		IN p_idapartado INT(11)
	)
	BEGIN


        DECLARE p_idmax int;
        DECLARE p_idparametro int;
        DECLARE p_empresa varchar(150);
        DECLARE p_propietario varchar(150);
        DECLARE p_direccion varchar(200);
        DECLARE p_clave_rfc varchar(20);
        DECLARE p_regimen_fiscal varchar(14);
        DECLARE p_fecha_resolucion datetime;
        DECLARE p_numero_resolucion varchar(80);
        DECLARE p_serie varchar(175);
        DECLARE p_subtotal decimal(8,2);
        DECLARE p_exento decimal(8,2);
        DECLARE p_descuento decimal(8,2);
        DECLARE p_total decimal(8,2);
        DECLARE p_numero_productos decimal(8,2);
        DECLARE p_empleado varchar(181);
        DECLARE p_numero_apartado varchar(175);
        DECLARE p_fecha_apartado datetime;
        DECLARE p_moneda varchar(35);
        DECLARE p_idcurrency int;
        DECLARE p_estado tinyint(1);

		DECLARE p_abonado_apartado decimal(8,2);
        DECLARE p_restante_pagar decimal(8,2);
		DECLARE p_fecha_limite_retiro datetime;
        DECLARE p_diferencia_fechas int;

        SET p_idmax = (SELECT MAX(idapartado) FROM apartado);
        SET p_idparametro = (SELECT MAX(idparametro) FROM parametro);
        SET p_idcurrency = (SELECT idcurrency FROM parametro WHERE idparametro = p_idparametro);
        SET p_empresa = (SELECT nombre_empresa FROM parametro);
        SET p_propietario = (SELECT propietario FROM parametro);
        SET p_direccion = (SELECT direccion_empresa FROM parametro);
        SET p_clave_rfc = (SELECT clave_rfc FROM parametro);
        SET p_regimen_fiscal = (SELECT regimen_fiscal FROM parametro);
        SET p_fecha_resolucion = (SELECT fecha_resolucion FROM tiraje_comprobante WHERE idcomprobante = 1);
        SET p_numero_resolucion = (SELECT numero_resolucion FROM tiraje_comprobante WHERE idcomprobante = 1);
        SET p_serie = (SELECT serie FROM tiraje_comprobante WHERE idcomprobante = 1);
        SET p_moneda = (SELECT CurrencyName	FROM currency WHERE idcurrency = p_idcurrency);



		IF (p_idapartado= '') THEN

		SET p_subtotal = (SELECT (sumas + iva) as subtotal FROM apartado WHERE idapartado= p_idmax);
		SET p_exento = (SELECT exento FROM apartado WHERE idapartado= p_idmax);
		SET p_descuento = (SELECT descuento FROM apartado WHERE idapartado= p_idmax);
		SET p_total = (SELECT total FROM apartado WHERE idapartado= p_idmax);
		SET p_numero_productos = (SELECT SUM(cantidad) FROM detalleapartado WHERE idapartado= p_idmax);
		SET p_empleado = (SELECT empleado FROM view_apartados WHERE idapartado= p_idmax GROUP BY empleado);
		SET p_numero_apartado = (SELECT numero_apartado FROM apartado WHERE idapartado= p_idmax);
		SET p_fecha_apartado = (SELECT fecha_apartado FROM apartado WHERE idapartado= p_idmax);
		SET p_abonado_apartado  = (SELECT abonado_apartado FROM apartado WHERE idapartado= p_idmax);
		SET p_restante_pagar  = (SELECT restante_pagar FROM apartado WHERE idapartado= p_idmax);
		SET p_fecha_limite_retiro = (SELECT fecha_limite_retiro	 FROM apartado WHERE idapartado= p_idmax);
		SET p_estado = (SELECT estado FROM apartado WHERE idapartado= p_idmax);
        SET p_diferencia_fechas = (SELECT DATEDIFF(p_fecha_limite_retiro, p_fecha_apartado));


        SELECT p_empresa, p_propietario, p_direccion, p_clave_rfc , p_regimen_fiscal,
        DATE_FORMAT(p_fecha_resolucion,'%d/%m/%Y %k:%i %p')  as p_fecha_resolucion,p_numero_resolucion,
        p_serie, p_subtotal, p_exento, p_descuento, p_total, p_numero_productos,
		p_empleado,DATE_FORMAT(p_fecha_apartado,'%d/%m/%Y %k:%i %p') as p_fecha_apartado ,p_numero_apartado,
      	p_fecha_limite_retiro, p_restante_pagar ,p_abonado_apartado,p_moneda,p_estado,p_diferencia_fechas;

        ELSE

		SET p_subtotal = (SELECT (sumas + iva) as subtotal FROM apartado WHERE idapartado= p_idapartado);
		SET p_exento = (SELECT exento FROM apartado WHERE idapartado= p_idapartado);
		SET p_descuento = (SELECT descuento FROM apartado WHERE idapartado= p_idapartado);
        SET p_total = (SELECT total FROM apartado WHERE idapartado= p_idapartado);
        SET p_numero_productos = (SELECT SUM(cantidad) FROM detalleapartado WHERE idapartado= p_idapartado);
        SET p_empleado = (SELECT empleado FROM view_apartados WHERE idapartado=  p_idapartado GROUP BY empleado);
		SET p_numero_apartado = (SELECT numero_apartado FROM apartado WHERE idapartado= p_idapartado);
		SET p_fecha_apartado = (SELECT fecha_apartado FROM apartado WHERE idapartado=  p_idapartado);
		SET p_abonado_apartado  = (SELECT abonado_apartado FROM apartado WHERE idapartado= p_idapartado);
		SET p_restante_pagar  = (SELECT restante_pagar FROM apartado WHERE idapartado= p_idapartado);
		SET p_fecha_limite_retiro = (SELECT fecha_limite_retiro	 FROM apartado WHERE idapartado= p_idapartado);
        SET p_estado = (SELECT estado FROM apartado WHERE idapartado= p_idapartado);
		SET p_diferencia_fechas = (SELECT DATEDIFF(p_fecha_limite_retiro, p_fecha_apartado));

		SELECT p_empresa, p_propietario, p_direccion, p_clave_rfc , p_regimen_fiscal,
        DATE_FORMAT(p_fecha_resolucion,'%d/%m/%Y %k:%i %p')  as p_fecha_resolucion,p_numero_resolucion,
        p_serie,  p_subtotal, p_exento, p_descuento, p_total, p_numero_productos,
		p_empleado,DATE_FORMAT(p_fecha_apartado,'%d/%m/%Y %k:%i %p') as p_fecha_apartado ,p_numero_apartado,
      	p_fecha_limite_retiro, p_restante_pagar ,p_abonado_apartado,p_moneda,p_estado,p_diferencia_fechas;

		END IF;

	END //
	DELIMITER ;



	DROP PROCEDURE IF EXISTS sp_detalle_imprimir_ticket_apartado;
	DELIMITER //
	CREATE PROCEDURE sp_detalle_imprimir_ticket_apartado(
		IN p_idapartado INT(11)
	)
	BEGIN

		DECLARE p_idmax int;
				SET p_idmax = (SELECT MAX(idapartado) FROM apartado);


		IF (p_idapartado = '') THEN

		SELECT cantidad, substring(nombre_producto,1,12) as descripcion,precio_unitario,
				if(producto_exento = '1', CONCAT(importe,'E'), CONCAT(importe,'G')) as importe
				FROM view_apartados
				WHERE idapartado = p_idmax;

				ELSE

		SELECT cantidad, substring(nombre_producto,1,12) as descripcion,precio_unitario,
				if(producto_exento = '1', CONCAT(importe,'E'), CONCAT(importe,'G')) as importe
				FROM view_apartados
				WHERE idapartado = p_idapartado;

		END IF;

	END //
	DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_venta_apartado;
DELIMITER //
CREATE PROCEDURE sp_insert_venta_apartado(
IN p_idapartado int(11),
IN p_tipo_pago varchar(75),
IN p_tipo_comprobante tinyint(1),
IN p_pago_efectivo decimal(8,2),
IN p_pago_tarjeta decimal(8,2),
IN p_numero_tarjeta varchar(16),
IN p_tarjeta_habiente varchar(90),
IN p_cambio decimal(8,2),
IN p_idcliente int(11),
IN p_idusuario int(11)
)
BEGIN

	DECLARE p_numero_comprobante INT;
    DECLARE p_abono_credito DECIMAL(8,2);
    DECLARE p_idventa INT;
    DECLARE p_sumas decimal(8,2);
  	DECLARE p_iva decimal(8,2);
  	DECLARE p_exento decimal(8,2);
  	DECLARE p_retenido decimal(8,2);
  	DECLARE p_descuento decimal(8,2);
  	DECLARE p_total decimal(8,2);
  	DECLARE p_sonletras varchar(150);

  	SET p_numero_comprobante = (SELECT usados + 1 FROM view_comprobantes WHERE idcomprobante = p_tipo_comprobante);
    SET p_sumas = (SELECT sumas FROM apartado WHERE idapartado = p_idapartado);
    SET p_iva = (SELECT iva FROM apartado WHERE idapartado = p_idapartado);
    SET p_exento = (SELECT exento FROM apartado WHERE idapartado = p_idapartado);
    SET p_retenido = (SELECT retenido FROM apartado WHERE idapartado = p_idapartado);
    SET p_descuento = (SELECT descuento FROM apartado WHERE idapartado = p_idapartado);
    SET p_total = (SELECT total FROM apartado WHERE idapartado = p_idapartado);
    SET p_sonletras = (SELECT sonletras FROM apartado WHERE idapartado = p_idapartado);


		  IF NOT EXISTS (SELECT * FROM venta WHERE `numero_comprobante` = p_numero_comprobante
		  AND `tipo_comprobante` = p_tipo_comprobante AND `fecha_venta` = NOW()) THEN


				IF p_numero_comprobante = '0' THEN

					INSERT INTO `venta`(`fecha_venta`, `tipo_pago`,
					`numero_comprobante`, `tipo_comprobante`, `sumas`, `iva`,
					`exento`, `retenido`, `descuento`, `total`,
					`sonletras`, `pago_efectivo`, `pago_tarjeta`, `numero_tarjeta`,
					`tarjeta_habiente`, `cambio`, `estado`, `idcliente`, `idusuario`)
					VALUES (NOW(), p_tipo_pago,
					1, p_tipo_comprobante, p_sumas, p_iva,
					p_exento, p_retenido, p_descuento, p_total,
					p_sonletras, p_pago_efectivo, p_pago_tarjeta, p_numero_tarjeta,
					p_tarjeta_habiente, p_cambio, 1, NULL, p_idusuario);
                    
					UPDATE `tiraje_comprobante` SET
					`disponibles` = `disponibles` - 1
					WHERE idcomprobante = p_tipo_comprobante;


					IF (p_tipo_pago = 'EFECTIVO') THEN
						CALL sp_insert_caja_venta(p_total);
					ELSEIF (p_tipo_pago = 'EFECTIVO Y TARJETA') THEN
						CALL sp_insert_caja_venta(p_pago_efectivo);
					END IF;

				ELSE

					INSERT INTO `venta`(`fecha_venta`, `tipo_pago`,
					`numero_comprobante`, `tipo_comprobante`, `sumas`, `iva`,
					`exento`, `retenido`, `descuento`, `total`,
					`sonletras`, `pago_efectivo`, `pago_tarjeta`, `numero_tarjeta`,
					`tarjeta_habiente`, `cambio`, `estado`, `idcliente`, `idusuario`)
					VALUES (NOW(), p_tipo_pago,
					p_numero_comprobante, p_tipo_comprobante, p_sumas, p_iva,
					p_exento, p_retenido, p_descuento, p_total,
					p_sonletras, p_pago_efectivo, p_pago_tarjeta, p_numero_tarjeta,
					p_tarjeta_habiente, p_cambio, 1, NULL, p_idusuario);
                    
					UPDATE `tiraje_comprobante` SET
					`disponibles` = `disponibles` - 1
					WHERE idcomprobante = p_tipo_comprobante;


					IF (p_tipo_pago = 'EFECTIVO') THEN
						CALL sp_insert_caja_venta(p_total);
					ELSEIF (p_tipo_pago = 'EFECTIVO Y TARJETA') THEN
						CALL sp_insert_caja_venta(p_pago_efectivo);
					END IF;

				END IF;

				UPDATE `apartado` SET
				`estado` = 2
				WHERE idapartado = p_idapartado;

                SET p_idventa = (SELECT MAX(idventa) FROM venta);

				INSERT INTO `detalleventa`(`idventa`, `idproducto`, `cantidad`, `precio_unitario`, `fecha_vence`,
                `exento`, `descuento`, `importe`)
				SELECT p_idventa, idproducto,cantidad,precio_unitario,fecha_vence,exento,descuento,importe FROM detalleapartado
				WHERE idapartado = p_idapartado;

		END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_anular_apartado;
DELIMITER //
CREATE PROCEDURE sp_anular_apartado(
	IN p_idapartado INT(11)
)
BEGIN	

		DECLARE p_numero_apartado varchar(175);
		DECLARE p_descripcion_movimiento varchar(80);
		SET p_numero_apartado = (SELECT numero_apartado FROM apartado WHERE idapartado = p_idapartado);
		SET p_descripcion_movimiento = (CONCAT('POR APARTADO #',' ',p_numero_apartado));



		DELETE FROM `caja_movimiento` 
        WHERE `descripcion_movimiento` = p_descripcion_movimiento;

		UPDATE `apartado` SET
		`estado` = 0
		WHERE idapartado = p_idapartado;
        
        DELETE FROM `salida`
        WHERE idapartado = p_idapartado;
        
		UPDATE inventario t2
		JOIN detalleapartado t1 ON t1.idproducto = t2.idproducto
        SET t2.salidas = t2.salidas - t1.cantidad,
        t2.saldo_final = t2.saldo_final + t1.cantidad
		WHERE t1.idapartado = p_idapartado AND t2.idproducto = t1.idproducto		
        AND t2.fecha_apertura =  DATE_FORMAT(CURDATE(),'%Y-%m-01')
		AND t2.fecha_cierre = LAST_DAY(CURDATE());

		UPDATE perecedero t2
		JOIN detalleapartado t1 ON t1.idproducto = t2.idproducto
		SET t2.cantidad_perecedero = t2.cantidad_perecedero + t1.cantidad
		WHERE t1.idapartado = p_idapartado AND t2.idproducto = t1.idproducto
        AND t2.fecha_vencimiento = t1.fecha_vence;

		UPDATE producto t2
		JOIN detalleapartado t1 ON t1.idproducto = t2.idproducto
		SET t2.stock = t2.stock + t1.cantidad
		WHERE t1.idapartado = p_idapartado AND t2.idproducto = t1.idproducto;


END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_devolver_productos_apartados;
DELIMITER //
CREATE PROCEDURE sp_devolver_productos_apartados()
	BEGIN
		
		DECLARE i int;
        DECLARE temp_id INT;
        DECLARE p_count INT;
        DECLARE p_idmax INT;
        
        SET p_count = (SELECT COUNT(*) FROM apartado WHERE `estado` = 1
		AND fecha_limite_retiro < CURDATE());
        SET i = 0;
        SET temp_id = 0;
        
        WHILE (i < p_count) DO
        
			DROP TABLE IF EXISTS temporal_apartados;
			CREATE TEMPORARY TABLE IF NOT EXISTS temporal_apartados
			SELECT idapartado FROM apartado WHERE `estado` = 1
			AND fecha_limite_retiro < CURDATE();
        
			SET p_idmax = (SELECT max(idapartado) FROM temporal_apartados);
			
            IF(temp_id != p_idmax) THEN
            
				SET temp_id = (p_idmax);
				CALL sp_anular_apartado(temp_id);
                
			END IF;
            
			SET i = i + 1;
            
        END WHILE;
        
	END //
DELIMITER ;


-- MONEDAS

DROP PROCEDURE IF EXISTS sp_insert_currency;
DELIMITER //
CREATE PROCEDURE sp_insert_currency(
IN p_CurrencyISO varchar(3), 
IN p_Language varchar(3), 
IN p_CurrencyName varchar(35), 
IN p_Money varchar(30), 
IN p_Symbol varchar(3)
)
BEGIN
IF NOT EXISTS (SELECT * FROM `currency` WHERE `CurrencyName` = p_CurrencyName) THEN
		INSERT INTO `currency`(`CurrencyISO`, `Language`, `CurrencyName`, 
		`Money`, `Symbol`) 
		VALUES (p_CurrencyISO, p_Language, p_CurrencyName, 
		p_Money, p_Symbol);
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_view_currency;
DELIMITER //
CREATE PROCEDURE sp_view_currency()
BEGIN
SELECT `idcurrency`, `CurrencyISO`, `Language`, `CurrencyName`, 
`Money`, `Symbol`
FROM `currency`;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_currency;
DELIMITER //
CREATE PROCEDURE sp_update_currency(
IN p_idcurrency int(11), 
IN p_CurrencyISO varchar(3), 
IN p_Language varchar(3), 
IN p_CurrencyName varchar(35), 
IN p_Money varchar(30), 
IN p_Symbol varchar(3)
)
BEGIN
UPDATE `currency` 
SET `CurrencyISO` = p_CurrencyISO, `Language` = p_Language, `CurrencyName` = p_CurrencyName, `Money` = p_Money, 
`Symbol` = p_Symbol
WHERE `idcurrency` = p_idcurrency;
END //
DELIMITER ;



