SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Table `categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre_categoria` VARCHAR(120) NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcategoria`))
;


-- -----------------------------------------------------
-- Table `marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marca` (
  `idmarca` INT NOT NULL AUTO_INCREMENT,
  `nombre_marca` VARCHAR(120) NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idmarca`))
;


-- -----------------------------------------------------
-- Table `presentacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `presentacion` (
  `idpresentacion` INT NOT NULL AUTO_INCREMENT,
  `nombre_presentacion` VARCHAR(120) NOT NULL,
  `siglas` VARCHAR(45) NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idpresentacion`))
;


-- -----------------------------------------------------
-- Table `producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `producto` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `codigo_interno` VARCHAR(175) NULL,
  `codigo_barra` VARCHAR(200) NULL,
  `nombre_producto` VARCHAR(175) NOT NULL,
  `precio_compra` DECIMAL(8,4) NOT NULL,
  `precio_venta` DECIMAL(8,2) NOT NULL,
  `precio_venta_mayoreo` DECIMAL(8,2) NOT NULL,
  `stock` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `stock_min` DECIMAL(8,2) NOT NULL DEFAULT 1.00,
  `idcategoria` INT NOT NULL,
  `idmarca` INT NULL,
  `idpresentacion` INT NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  `exento` TINYINT(1) NOT NULL DEFAULT 0,
  `inventariable` TINYINT(1) NOT NULL DEFAULT 1,
  `perecedero` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`idproducto`),
  UNIQUE INDEX `codigo_interno_UNIQUE` (`codigo_interno` ASC) ,
  INDEX `fk_producto_categoria_idx` (`idcategoria` ASC) ,
  INDEX `fk_producto_presentacion1_idx` (`idpresentacion` ASC) ,
  INDEX `fk_producto_marca1_idx` (`idmarca` ASC) ,
  CONSTRAINT `fk_producto_categoria`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_producto_presentacion`
    FOREIGN KEY (`idpresentacion`)
    REFERENCES `presentacion` (`idpresentacion`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_producto_marca`
    FOREIGN KEY (`idmarca`)
    REFERENCES `marca` (`idmarca`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proveedor` (
  `idproveedor` INT NOT NULL AUTO_INCREMENT,
  `codigo_proveedor` VARCHAR(175) NULL,
  `nombre_proveedor` VARCHAR(175) NOT NULL,
  `numero_telefono` VARCHAR(20) NOT NULL,
  `clave_rfc` VARCHAR(20) NOT NULL,
  `regimen_fiscal` VARCHAR(14) NOT NULL,
  `direccion_proveedor` VARCHAR(175) NOT NULL,
  `nombre_contacto` VARCHAR(150) NULL,
  `telefono_contacto` VARCHAR(20) NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idproveedor`),
  UNIQUE INDEX `codigo_proveedor_UNIQUE` (`codigo_proveedor` ASC) ,
  UNIQUE INDEX `nombre_proveedor_UNIQUE` (`nombre_proveedor` ASC) )
;


-- -----------------------------------------------------
-- Table `compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compra` (
  `idcompra` INT NOT NULL AUTO_INCREMENT,
  `fecha_compra` DATETIME NOT NULL,
  `idproveedor` INT NOT NULL,
  `tipo_pago` VARCHAR(75) NOT NULL,
  `numero_comprobante` VARCHAR(60) NOT NULL,
  `tipo_comprobante` VARCHAR(60) NOT NULL,
  `fecha_comprobante` DATE NULL,
  `sumas` DECIMAL(8,2) NOT NULL,
  `iva` DECIMAL(8,2) NOT NULL,
  `exento` DECIMAL(8,2) NOT NULL,
  `retenido` DECIMAL(8,2) NOT NULL,
  `total` DECIMAL(8,2) NOT NULL,
  `sonletras` VARCHAR(150) NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcompra`),
  INDEX `fk_compra_proveedor1_idx` (`idproveedor` ASC) ,
  CONSTRAINT `fk_compra_proveedor`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `proveedor` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `codigo_cliente` VARCHAR(175) NULL,
  `nombre_cliente` VARCHAR(150) NOT NULL,
  `clave_rfc` VARCHAR(20) NULL,
  `regimen_fiscal` VARCHAR(14) NULL,
  `direccion_cliente` VARCHAR(100) NULL,
  `numero_telefono` VARCHAR(20) NULL,
  `email` VARCHAR(80) NULL,
  `giro` VARCHAR(80) NULL,
  `limite_credito` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `codigo_cliente_UNIQUE` (`codigo_cliente` ASC) )
;


-- -----------------------------------------------------
-- Table `empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empleado` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `codigo_empleado` VARCHAR(175) NULL,
  `nombre_empleado` VARCHAR(90) NOT NULL,
  `apellido_empleado` VARCHAR(90) NOT NULL,
  `telefono_empleado` VARCHAR(20) NOT NULL,
  `email_empleado` VARCHAR(80) NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idempleado`),
  UNIQUE INDEX `codigo_empleado_UNIQUE` (`codigo_empleado` ASC) )
;


-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(8) NOT NULL,
  `contrasena` VARCHAR(12) NOT NULL,
  `tipo_usuario` TINYINT(1) NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  `idempleado` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_empleado1_idx` (`idempleado` ASC) ,
  CONSTRAINT `fk_usuario_empleado`
    FOREIGN KEY (`idempleado`)
    REFERENCES `empleado` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `apartado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apartado` (
  `idapartado` INT NOT NULL AUTO_INCREMENT,
  `numero_apartado` VARCHAR(175) NULL,
  `fecha_apartado` DATETIME NOT NULL,
  `fecha_limite_retiro` DATETIME NOT NULL,
  `sumas` DECIMAL(8,2) NOT NULL,
  `iva` DECIMAL(8,2) NOT NULL,
  `exento` DECIMAL(8,2) NOT NULL,
  `retenido` DECIMAL(8,2) NOT NULL,
  `descuento` DECIMAL(8,2) NOT NULL,
  `total` DECIMAL(8,2) NOT NULL,
  `abonado_apartado` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `restante_pagar` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `sonletras` VARCHAR(150) NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  `idcliente` INT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idapartado`),
  UNIQUE INDEX `numero_venta_UNIQUE` (`numero_apartado` ASC) ,
  INDEX `fk_venta_cliente1_idx` (`idcliente` ASC) ,
  INDEX `fk_venta_usuario1_idx` (`idusuario` ASC) ,
  CONSTRAINT `fk_venta_cliente0`
    FOREIGN KEY (`idcliente`)
    REFERENCES `cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_usuario0`
    FOREIGN KEY (`idusuario`)
    REFERENCES `usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `entrada` (
  `identrada` INT NOT NULL AUTO_INCREMENT,
  `mes_inventario` VARCHAR(7) NOT NULL,
  `fecha_entrada` DATE NOT NULL,
  `descripcion_entrada` VARCHAR(150) NOT NULL,
  `cantidad_entrada` DECIMAL(8,2) NOT NULL,
  `precio_unitario_entrada` DECIMAL(8,2) NOT NULL,
  `costo_total_entrada` DECIMAL(8,2) NOT NULL,
  `idproducto` INT NOT NULL,
  `idcompra` INT NULL,
  `idapartado` INT NULL,
  PRIMARY KEY (`identrada`),
  INDEX `fk_entrada_producto1_idx` (`idproducto` ASC) ,
  INDEX `fk_entrada_compra1_idx` (`idcompra` ASC) ,
  INDEX `fk_entrada_apartado1_idx` (`idapartado` ASC) ,
  CONSTRAINT `fk_entrada_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_entrada_compra`
    FOREIGN KEY (`idcompra`)
    REFERENCES `compra` (`idcompra`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_entrada_apartado`
    FOREIGN KEY (`idapartado`)
    REFERENCES `apartado` (`idapartado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `venta` (
  `idventa` INT NOT NULL AUTO_INCREMENT,
  `numero_venta` VARCHAR(175) NULL,
  `fecha_venta` DATETIME NOT NULL,
  `tipo_pago` VARCHAR(75) NOT NULL,
  `numero_comprobante` INT NOT NULL,
  `tipo_comprobante` TINYINT(1) NOT NULL,
  `sumas` DECIMAL(8,2) NOT NULL,
  `iva` DECIMAL(8,2) NOT NULL,
  `exento` DECIMAL(8,2) NOT NULL,
  `retenido` DECIMAL(8,2) NOT NULL,
  `descuento` DECIMAL(8,2) NOT NULL,
  `total` DECIMAL(8,2) NOT NULL,
  `sonletras` VARCHAR(150) NOT NULL,
  `pago_efectivo` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `pago_tarjeta` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `numero_tarjeta` VARCHAR(16) NULL,
  `tarjeta_habiente` VARCHAR(90) NULL,
  `cambio` DECIMAL(8,2) NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  `idcliente` INT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idventa`),
  UNIQUE INDEX `numero_venta_UNIQUE` (`numero_venta` ASC) ,
  INDEX `fk_venta_cliente1_idx` (`idcliente` ASC) ,
  INDEX `fk_venta_usuario1_idx` (`idusuario` ASC) ,
  CONSTRAINT `fk_venta_cliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_usuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `salida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salida` (
  `idsalida` INT NOT NULL AUTO_INCREMENT,
  `mes_inventario` VARCHAR(7) NOT NULL,
  `fecha_salida` DATE NOT NULL,
  `descripcion_salida` VARCHAR(150) NOT NULL,
  `cantidad_salida` DECIMAL(8,2) NOT NULL,
  `precio_unitario_salida` DECIMAL(8,2) NOT NULL,
  `costo_total_salida` DECIMAL(8,2) NOT NULL,
  `idproducto` INT NOT NULL,
  `idventa` INT NULL,
  `idapartado` INT NULL,
  PRIMARY KEY (`idsalida`),
  INDEX `fk_entrada_producto1_idx` (`idproducto` ASC) ,
  INDEX `fk_salida_venta1_idx` (`idventa` ASC) ,
  INDEX `fk_salida_apartado1_idx` (`idapartado` ASC) ,
  CONSTRAINT `fk_salida_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_salida_venta`
    FOREIGN KEY (`idventa`)
    REFERENCES `venta` (`idventa`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_salida_apartado`
    FOREIGN KEY (`idapartado`)
    REFERENCES `apartado` (`idapartado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario` (
  `mes_inventario` VARCHAR(7) NULL,
  `fecha_apertura` DATE NOT NULL,
  `fecha_cierre` DATE NOT NULL,
  `saldo_inicial` DECIMAL(8,2) NOT NULL,
  `entradas` DECIMAL(8,2) NULL,
  `salidas` DECIMAL(8,2) NULL,
  `saldo_final` DECIMAL(8,2) NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  `idproducto` INT NOT NULL,
  INDEX `fk_inventario_producto1_idx` (`idproducto` ASC) ,
  CONSTRAINT `fk_inventario_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `proveedor_precio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proveedor_precio` (
  `idproveedor` INT NOT NULL,
  `idproducto` INT NOT NULL,
  `fecha_precio` DATE NOT NULL,
  `precio_compra` DECIMAL(8,4) NOT NULL,
  INDEX `fk_proveedor_precio_proveedor1_idx` (`idproveedor` ASC) ,
  INDEX `fk_proveedor_precio_producto1_idx` (`idproducto` ASC) ,
  CONSTRAINT `fk_proveedor_precio_proveedor`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `proveedor` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_proveedor_precio_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `producto_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `producto_proveedor` (
  `idproveedor` INT NOT NULL,
  `idproducto` INT NOT NULL,
  INDEX `fk_producto_proveedor_proveedor1_idx` (`idproveedor` ASC) ,
  INDEX `fk_producto_proveedor_producto1_idx` (`idproducto` ASC) ,
  CONSTRAINT `fk_producto_proveedor_proveedor`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `proveedor` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_proveedor_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `detallecompra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `detallecompra` (
  `idcompra` INT NOT NULL,
  `idproducto` INT NOT NULL,
  `fecha_vence` DATE NULL,
  `cantidad` DECIMAL(8,2) NOT NULL,
  `precio_unitario` DECIMAL(8,4) NOT NULL,
  `exento` DECIMAL(8,2) NOT NULL,
  `importe` DECIMAL(8,2) NOT NULL,
  INDEX `fk_detallecompra_producto1_idx` (`idproducto` ASC) ,
  INDEX `fk_detallecompra_compra1_idx` (`idcompra` ASC) ,
  CONSTRAINT `fk_detallecompra_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_detallecompra_compra`
    FOREIGN KEY (`idcompra`)
    REFERENCES `compra` (`idcompra`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `caja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caja` (
  `idcaja` INT NOT NULL AUTO_INCREMENT,
  `fecha_apertura` DATETIME NOT NULL,
  `monto_apertura` DECIMAL(8,2) NOT NULL,
  `monto_cierre` DECIMAL(8,2) NULL DEFAULT 0.00,
  `fecha_cierre` DATETIME NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcaja`))
;


-- -----------------------------------------------------
-- Table `caja_movimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caja_movimiento` (
  `idcaja` INT NOT NULL,
  `tipo_movimiento` TINYINT(1) NOT NULL DEFAULT 0,
  `monto_movimiento` DECIMAL(8,2) NOT NULL,
  `descripcion_movimiento` VARCHAR(80) NULL,
  `fecha_movimiento` DATE NOT NULL,
  INDEX `fk_caja_movimiento_caja1_idx` (`idcaja` ASC) ,
  CONSTRAINT `fk_caja_movimiento_caja`
    FOREIGN KEY (`idcaja`)
    REFERENCES `caja` (`idcaja`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `detalleventa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `detalleventa` (
  `idventa` INT NOT NULL,
  `idproducto` INT NOT NULL,
  `cantidad` DECIMAL(8,2) NOT NULL,
  `precio_unitario` DECIMAL(8,2) NOT NULL,
  `fecha_vence` DATE NULL,
  `exento` DECIMAL(8,2) NOT NULL,
  `descuento` DECIMAL(8,2) NOT NULL,
  `importe` DECIMAL(8,2) NOT NULL,
  INDEX `fk_detalleventa_venta1_idx` (`idventa` ASC) ,
  INDEX `fk_detalleventa_producto1_idx` (`idproducto` ASC) ,
  CONSTRAINT `fk_detalleventa_venta`
    FOREIGN KEY (`idventa`)
    REFERENCES `venta` (`idventa`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_detalleventa_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `comprobante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comprobante` (
  `idcomprobante` INT NOT NULL AUTO_INCREMENT,
  `nombre_comprobante` VARCHAR(75) NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcomprobante`))
;


-- -----------------------------------------------------
-- Table `tiraje_comprobante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiraje_comprobante` (
  `idtiraje` INT NOT NULL AUTO_INCREMENT,
  `fecha_resolucion` DATETIME NOT NULL,
  `numero_resolucion` VARCHAR(100) NULL,
  `serie` VARCHAR(175) NOT NULL,
  `desde` INT NOT NULL,
  `hasta` INT NOT NULL,
  `idcomprobante` INT NOT NULL,
  `disponibles` INT NOT NULL,
  PRIMARY KEY (`idtiraje`),
  INDEX `fk_tiraje_comprobante_comprobante1_idx` (`idcomprobante` ASC) ,
  CONSTRAINT `fk_tiraje_comprobante_comprobante`
    FOREIGN KEY (`idcomprobante`)
    REFERENCES `comprobante` (`idcomprobante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `currency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `currency` (
  `idcurrency` INT NOT NULL AUTO_INCREMENT,
  `CurrencyISO` VARCHAR(3) NULL,
  `Language` VARCHAR(3) NULL,
  `CurrencyName` VARCHAR(35) NULL,
  `Money` VARCHAR(30) NULL,
  `Symbol` VARCHAR(3) NULL,
  PRIMARY KEY (`idcurrency`))
;


-- -----------------------------------------------------
-- Table `parametro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parametro` (
  `idparametro` INT NOT NULL AUTO_INCREMENT,
  `nombre_empresa` VARCHAR(150) NOT NULL,
  `propietario` VARCHAR(150) NOT NULL,
  `clave_rfc` VARCHAR(20) NOT NULL,
  `regimen_fiscal` VARCHAR(14) NULL,
  `porcentaje_iva` DECIMAL(8,2) NOT NULL,
  `porcentaje_retencion` DECIMAL(8,2) NULL,
  `monto_retencion` DECIMAL(8,2) NULL,
  `direccion_empresa` VARCHAR(200) NOT NULL,
  `logo_empresa` VARCHAR(90) NULL,
  `idcurrency` INT NOT NULL,
  PRIMARY KEY (`idparametro`),
  INDEX `fk_parametro_currency1_idx` (`idcurrency` ASC) ,
  CONSTRAINT `fk_parametro_currency1`
    FOREIGN KEY (`idcurrency`)
    REFERENCES `currency` (`idcurrency`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `perecedero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perecedero` (
  `fecha_vencimiento` DATE NOT NULL,
  `cantidad_perecedero` DECIMAL(8,2) NOT NULL,
  `idproducto` INT NOT NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  INDEX `fk_perecedero_producto1_idx` (`idproducto` ASC) ,
  CONSTRAINT `fk_perecedero_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `credito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `credito` (
  `idcredito` INT NOT NULL AUTO_INCREMENT,
  `idventa` INT NULL,
  `codigo_credito` VARCHAR(175) NULL,
  `nombre_credito` VARCHAR(120) NOT NULL,
  `fecha_credito` DATETIME NOT NULL,
  `monto_credito` DECIMAL(8,2) NOT NULL,
  `monto_abonado` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `monto_restante` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `estado` TINYINT(1) NOT NULL DEFAULT 0,
  `idcliente` INT NULL,
  PRIMARY KEY (`idcredito`),
  INDEX `fk_credito_venta1_idx` (`idventa` ASC) ,
  INDEX `fk_credito_cliente1_idx` (`idcliente` ASC) ,
  CONSTRAINT `fk_credito_venta1`
    FOREIGN KEY (`idventa`)
    REFERENCES `venta` (`idventa`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_credito_cliente1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `abono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abono` (
  `idabono` INT NOT NULL AUTO_INCREMENT,
  `idcredito` INT NOT NULL,
  `fecha_abono` DATETIME NOT NULL,
  `monto_abono` DECIMAL(8,2) NOT NULL,
  `total_abonado` DECIMAL(8,2) NULL DEFAULT 0.00,
  `restante_credito` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idabono`),
  INDEX `fk_abono_credito1_idx` (`idcredito` ASC) ,
  INDEX `fk_abono_usuario1_idx` (`idusuario` ASC) ,
  CONSTRAINT `fk_abono_credito1`
    FOREIGN KEY (`idcredito`)
    REFERENCES `credito` (`idcredito`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_abono_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cotizacion` (
  `idcotizacion` INT NOT NULL AUTO_INCREMENT,
  `numero_cotizacion` VARCHAR(175) NULL,
  `fecha_cotizacion` DATETIME NOT NULL,
  `a_nombre` VARCHAR(175) NULL,
  `tipo_pago` VARCHAR(60) NOT NULL,
  `entrega` VARCHAR(60) NOT NULL,
  `sumas` DECIMAL(8,2) NOT NULL,
  `iva` DECIMAL(8,2) NOT NULL,
  `exento` DECIMAL(8,2) NOT NULL,
  `retenido` DECIMAL(8,2) NOT NULL,
  `descuento` DECIMAL(8,2) NOT NULL,
  `total` DECIMAL(8,2) NOT NULL,
  `sonletras` VARCHAR(150) NOT NULL,
  `idusuario` INT NOT NULL,
  `idcliente` INT NOT NULL,
  PRIMARY KEY (`idcotizacion`),
  INDEX `fk_cotizacion_usuario1_idx` (`idusuario` ASC) ,
  INDEX `fk_cotizacion_cliente1_idx` (`idcliente` ASC) ,
  CONSTRAINT `fk_cotizacion_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cotizacion_cliente1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `detallecotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `detallecotizacion` (
  `idcotizacion` INT NOT NULL,
  `idproducto` INT NOT NULL,
  `cantidad` DECIMAL(8,2) NOT NULL,
  `disponible` TINYINT(1) NOT NULL,
  `precio_unitario` DECIMAL(8,2) NOT NULL,
  `exento` DECIMAL(8,2) NOT NULL,
  `descuento` DECIMAL(8,2) NOT NULL,
  `importe` DECIMAL(8,2) NOT NULL,
  INDEX `fk_detallecotizacion_producto1_idx` (`idproducto` ASC) ,
  INDEX `fk_detallecotizacion_cotizacion1_idx` (`idcotizacion` ASC) ,
  CONSTRAINT `fk_detallecotizacion_producto1`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_detallecotizacion_cotizacion1`
    FOREIGN KEY (`idcotizacion`)
    REFERENCES `cotizacion` (`idcotizacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tecnico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tecnico` (
  `idtecnico` INT NOT NULL AUTO_INCREMENT,
  `tecnico` VARCHAR(150) NOT NULL,
  `telefono` VARCHAR(20) NULL,
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idtecnico`))
;


-- -----------------------------------------------------
-- Table `ordentaller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ordentaller` (
  `idorden` INT NOT NULL AUTO_INCREMENT,
  `numero_orden` VARCHAR(175) NULL,
  `fecha_ingreso` DATETIME NOT NULL,
  `idcliente` INT NOT NULL,
  `aparato` VARCHAR(125) NOT NULL,
  `modelo` VARCHAR(125) NULL,
  `idmarca` INT NOT NULL,
  `serie` VARCHAR(125) NULL,
  `idtecnico` INT NOT NULL,
  `averia` VARCHAR(200) NOT NULL,
  `observaciones` VARCHAR(200) NULL,
  `deposito_revision` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `deposito_reparacion` DECIMAL(8,2) NULL DEFAULT 0.00,
  `diagnostico` VARCHAR(200) NOT NULL,
  `estado_aparato` VARCHAR(200) NOT NULL,
  `repuestos` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `mano_obra` DECIMAL(8,2) NULL DEFAULT 0.00,
  `fecha_alta` DATETIME NULL,
  `fecha_retiro` DATETIME NULL,
  `ubicacion` VARCHAR(150) NULL,
  `parcial_pagar` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`idorden`),
  INDEX `fk_ordentaller_cliente1_idx` (`idcliente` ASC) ,
  INDEX `fk_ordentaller_marca1_idx` (`idmarca` ASC) ,
  INDEX `fk_ordentaller_tecnico1_idx` (`idtecnico` ASC) ,
  CONSTRAINT `fk_ordentaller_cliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ordentaller_marca`
    FOREIGN KEY (`idmarca`)
    REFERENCES `marca` (`idmarca`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ordentaller_tecnico`
    FOREIGN KEY (`idtecnico`)
    REFERENCES `tecnico` (`idtecnico`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table `detalleapartado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `detalleapartado` (
  `idapartado` INT NOT NULL,
  `idproducto` INT NOT NULL,
  `cantidad` DECIMAL(8,2) NOT NULL,
  `precio_unitario` DECIMAL(8,2) NOT NULL,
  `fecha_vence` DATE NULL,
  `exento` DECIMAL(8,2) NOT NULL,
  `descuento` DECIMAL(8,2) NOT NULL,
  `importe` DECIMAL(8,2) NOT NULL,
  INDEX `fk_detalleventa_producto1_idx` (`idproducto` ASC) ,
  INDEX `fk_detalleapartado_apartado1_idx` (`idapartado` ASC) ,
  CONSTRAINT `fk_detalleventa_producto0`
    FOREIGN KEY (`idproducto`)
    REFERENCES `producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_detalleapartado_apartado1`
    FOREIGN KEY (`idapartado`)
    REFERENCES `apartado` (`idapartado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
