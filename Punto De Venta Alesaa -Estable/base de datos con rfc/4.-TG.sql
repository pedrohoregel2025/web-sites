-- Triggers

DROP TRIGGER IF EXISTS generar_codigo_proveedor;
DELIMITER //
CREATE TRIGGER generar_codigo_proveedor
BEFORE INSERT 
	ON proveedor FOR EACH ROW
	BEGIN
    
        DECLARE numero INT;
        
        SET numero = (SELECT max(idproveedor) FROM proveedor);
 
		IF numero IS NULL then
		  set numero=1;
        SET NEW.codigo_proveedor ='PROV00000001';

		ELSEIF numero >= 1 and numero < 9 then
			set numero=numero+1;
		SET NEW.codigo_proveedor =(select concat('PROV0000000',CAST(numero AS CHAR)));
        
		ELSEIF numero >=9 and numero<=99 then
			set numero=numero+1;
		SET NEW.codigo_proveedor =(select concat('PROV000000',CAST(numero AS CHAR)));
            
		ELSEIF numero>=99 and numero<=999 then
			set numero=numero+1;
		SET NEW.codigo_proveedor =(select concat('PROV00000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=999 and numero<=9999 then
		   set numero=numero+1;
		SET NEW.codigo_proveedor =(select concat('PROV0000',CAST(numero AS CHAR)));
           
		ELSEIF numero>=9999 and numero<=99999 then
			set numero=numero+1;
		SET NEW.codigo_proveedor =(select concat('PROV000',CAST(numero AS CHAR)));
             

		ELSEIF numero>=99999 and numero<=999999 then
			set numero=numero+1;
		SET NEW.codigo_proveedor =(select concat('PROV00',CAST(numero AS CHAR)));
            

		ELSEIF numero>=999999 and numero<=9999999 then
			set numero=numero+1;
		SET NEW.codigo_proveedor =(select concat('PROV0',CAST(numero AS CHAR)));
            
        ELSEIF numero>=9999999  then -- DIEZ MILLONES EN DELANTE
			set numero=numero+1;
		SET NEW.codigo_proveedor =(select concat('PROV',CAST(numero AS CHAR)));
            
		END IF;
        
    END; //
DELIMITER ;

DROP TRIGGER IF EXISTS generar_codigo_producto;
DELIMITER //
CREATE TRIGGER generar_codigo_producto
BEFORE INSERT 
	ON producto FOR EACH ROW
	BEGIN
    
        DECLARE numero INT;

        SET numero = (SELECT max(idproducto) FROM producto);
        
		IF numero IS NULL then
		  set numero=1;
        SET NEW.codigo_interno='PR00000001';

		ELSEIF numero >= 1 and numero < 9 then
			set numero=numero+1;
		SET NEW.codigo_interno=(select concat('PR0000000',CAST(numero AS CHAR)));
        
		ELSEIF numero >=9 and numero<=99 then
			set numero=numero+1;
		SET NEW.codigo_interno=(select concat('PR000000',CAST(numero AS CHAR)));
            
		ELSEIF numero>=99 and numero<=999 then
			set numero=numero+1;
		SET NEW.codigo_interno=(select concat('PR00000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=999 and numero<=9999 then
		   set numero=numero+1;
		SET NEW.codigo_interno=(select concat('PR0000',CAST(numero AS CHAR)));
           
		ELSEIF numero>=9999 and numero<=99999 then
			set numero=numero+1;
		SET NEW.codigo_interno=(select concat('PR000',CAST(numero AS CHAR)));
             

		ELSEIF numero>=99999 and numero<=999999 then
			set numero=numero+1;
		SET NEW.codigo_interno=(select concat('PR00',CAST(numero AS CHAR)));
            

		ELSEIF numero>=999999 and numero<=9999999 then
			set numero=numero+1;
		SET NEW.codigo_interno=(select concat('PR0',CAST(numero AS CHAR)));
            
        ELSEIF numero>=9999999  then -- DIEZ MILLONES EN DELANTE
			set numero=numero+1;
		SET NEW.codigo_interno=(select concat('PR',CAST(numero AS CHAR)));
            
		END IF;
    END; //
DELIMITER ;

DROP TRIGGER IF EXISTS generar_codigo_empleado;
DELIMITER //
CREATE TRIGGER generar_codigo_empleado
BEFORE INSERT 
	ON empleado FOR EACH ROW
	BEGIN
    
        DECLARE numero INT;
        
        SET numero = (SELECT max(idempleado) FROM empleado);
        
		IF numero IS NULL then
		  set numero=1;
        SET NEW.codigo_empleado='EM00000001';

		ELSEIF numero >= 1 and numero < 9 then
			set numero=numero+1;
		SET NEW.codigo_empleado=(select concat('EM0000000',CAST(numero AS CHAR)));
        
		ELSEIF numero >=9 and numero<=99 then
			set numero=numero+1;
		SET NEW.codigo_empleado=(select concat('EM000000',CAST(numero AS CHAR)));
            
		ELSEIF numero>=99 and numero<=999 then
			set numero=numero+1;
		SET NEW.codigo_empleado=(select concat('EM00000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=999 and numero<=9999 then
		   set numero=numero+1;
		SET NEW.codigo_empleado=(select concat('EM0000',CAST(numero AS CHAR)));
           
		ELSEIF numero>=9999 and numero<=99999 then
			set numero=numero+1;
		SET NEW.codigo_empleado=(select concat('EM000',CAST(numero AS CHAR)));
             

		ELSEIF numero>=99999 and numero<=999999 then
			set numero=numero+1;
		SET NEW.codigo_empleado=(select concat('EM00',CAST(numero AS CHAR)));
            

		ELSEIF numero>=999999 and numero<=9999999 then
			set numero=numero+1;
		SET NEW.codigo_empleado=(select concat('EM0',CAST(numero AS CHAR)));
            
        ELSEIF numero>=9999999  then -- DIEZ MILLONES EN DELANTE
			set numero=numero+1;
		SET NEW.codigo_empleado=(select concat('EM',CAST(numero AS CHAR)));
            
		END IF;
    END; //
DELIMITER ;

DROP TRIGGER IF EXISTS generar_codigo_cliente;
DELIMITER //
CREATE TRIGGER generar_codigo_cliente
BEFORE INSERT 
	ON cliente FOR EACH ROW
	BEGIN
    
        DECLARE numero INT;

        SET numero = (SELECT max(idcliente) FROM cliente);
        
		IF numero IS NULL then
		  set numero=1;
        SET NEW.codigo_cliente='CL00000001';

		ELSEIF numero >= 1 and numero < 9 then
			set numero=numero+1;
		SET NEW.codigo_cliente=(select concat('CL0000000',CAST(numero AS CHAR)));
        
		ELSEIF numero >=9 and numero<=99 then
			set numero=numero+1;
		SET NEW.codigo_cliente=(select concat('CL000000',CAST(numero AS CHAR)));
            
		ELSEIF numero>=99 and numero<=999 then
			set numero=numero+1;
		SET NEW.codigo_cliente=(select concat('CL00000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=999 and numero<=9999 then
		   set numero=numero+1;
		SET NEW.codigo_cliente=(select concat('CL0000',CAST(numero AS CHAR)));
           
		ELSEIF numero>=9999 and numero<=99999 then
			set numero=numero+1;
		SET NEW.codigo_cliente=(select concat('CL000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=99999 and numero<=999999 then
			set numero=numero+1;
		SET NEW.codigo_cliente=(select concat('CL00',CAST(numero AS CHAR)));
            
		ELSEIF numero>=999999 and numero<=9999999 then
			set numero=numero+1;
		SET NEW.codigo_cliente=(select concat('CL0',CAST(numero AS CHAR)));
            
        ELSEIF numero>=9999999  then -- DIEZ MILLONES EN DELANTE
			set numero=numero+1;
		SET NEW.codigo_cliente=(select concat('CL',CAST(numero AS CHAR)));
            
		END IF;
    END; //
DELIMITER ;



DROP TRIGGER IF EXISTS generar_numero_venta;
DELIMITER //
CREATE TRIGGER generar_numero_venta
BEFORE INSERT 
	ON venta FOR EACH ROW
	BEGIN
    
        DECLARE numero INT(11);

        SET numero = (SELECT max(idventa) FROM venta);
        
		IF numero IS NULL then
		  set numero=1;
        SET NEW.numero_venta='V00000001';

		ELSEIF numero >= 1 and numero < 9 then
			set numero=numero+1;
		SET NEW.numero_venta=(select concat('V0000000',CAST(numero AS CHAR)));
        
		ELSEIF numero >=9 and numero<=99 then
			set numero=numero+1;
		SET NEW.numero_venta=(select concat('V000000',CAST(numero AS CHAR)));
            
		ELSEIF numero>=99 and numero<=999 then
			set numero=numero+1;
		SET NEW.numero_venta=(select concat('V00000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=999 and numero<=9999 then
		   set numero=numero+1;
		SET NEW.numero_venta=(select concat('V0000',CAST(numero AS CHAR)));
           
		ELSEIF numero>=9999 and numero<=99999 then
			set numero=numero+1;
		SET NEW.numero_venta=(select concat('V000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=99999 and numero<=999999 then
			set numero=numero+1;
		SET NEW.numero_venta=(select concat('V00',CAST(numero AS CHAR)));
            
		ELSEIF numero>=999999 and numero<=9999999 then
			set numero=numero+1;
		SET NEW.numero_venta=(select concat('V0',CAST(numero AS CHAR)));
            
        ELSEIF numero>=9999999  then -- DIEZ MILLONES EN DELANTE
			set numero=numero+1;
		SET NEW.numero_venta=(select concat('V',CAST(numero AS CHAR)));
            
		END IF;
    END; //
DELIMITER ;



DROP TRIGGER IF EXISTS insertar_nuevo_producto_inventario;
DELIMITER //
CREATE TRIGGER insertar_nuevo_producto_inventario
AFTER INSERT
   ON producto FOR EACH ROW

BEGIN
    DECLARE p_idproducto INT;
    DECLARE p_stock INT;
    DECLARE p_precio DECIMAL(8,2);
    DECLARE p_costo_total DECIMAL(8,2);
    
	SET p_idproducto = (SELECT MAX(idproducto) FROM producto);
    SET p_stock = (SELECT stock FROM producto WHERE idproducto = p_idproducto);
    SET p_precio = (SELECT precio_compra FROM producto WHERE idproducto = p_idproducto);
    
    SET p_costo_total = p_stock * p_precio;
    
    INSERT INTO inventario (mes_inventario,fecha_apertura,fecha_cierre,saldo_inicial,entradas,salidas,saldo_final,estado,idproducto)
    SELECT DATE_FORMAT(CURDATE(),'%Y-%m'),DATE_FORMAT(CURDATE(),'%Y-%m-01'),LAST_DAY(CURDATE()),p_stock,p_stock,0,p_stock,1,p_idproducto;
	
    INSERT INTO entrada (mes_inventario,fecha_entrada,descripcion_entrada,
    cantidad_entrada,precio_unitario_entrada,costo_total_entrada,idproducto,idcompra)
    VALUES (DATE_FORMAT(CURDATE(),'%Y-%m'),CURDATE(),'INVENTARIO INICIAL',p_stock,p_precio,
    p_costo_total,p_idproducto,NULL);

END; //
DELIMITER ;

DROP TRIGGER IF EXISTS generar_numero_credito;
DELIMITER //
CREATE TRIGGER generar_numero_credito
BEFORE INSERT 
	ON credito FOR EACH ROW
	BEGIN
    
        DECLARE numero INT(11);

        SET numero = (SELECT max(idcredito) FROM credito);
        
		IF numero IS NULL then
		  set numero=1;
        SET NEW.codigo_credito='CRED00000001';

		ELSEIF numero >= 1 and numero < 9 then
			set numero=numero+1;
		SET NEW.codigo_credito=(select concat('CRED0000000',CAST(numero AS CHAR)));
        
		ELSEIF numero >=9 and numero<=99 then
			set numero=numero+1;
		SET NEW.codigo_credito=(select concat('CRED000000',CAST(numero AS CHAR)));
            
		ELSEIF numero>=99 and numero<=999 then
			set numero=numero+1;
		SET NEW.codigo_credito=(select concat('CRED00000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=999 and numero<=9999 then
		   set numero=numero+1;
		SET NEW.codigo_credito=(select concat('CRED0000',CAST(numero AS CHAR)));
           
		ELSEIF numero>=9999 and numero<=99999 then
			set numero=numero+1;
		SET NEW.codigo_credito=(select concat('CRED000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=99999 and numero<=999999 then
			set numero=numero+1;
		SET NEW.codigo_credito=(select concat('CRED00',CAST(numero AS CHAR)));
            
		ELSEIF numero>=999999 and numero<=9999999 then
			set numero=numero+1;
		SET NEW.codigo_credito=(select concat('CRED0',CAST(numero AS CHAR)));
            
        ELSEIF numero>=9999999  then -- DIEZ MILLONES EN DELANTE
			set numero=numero+1;
		SET NEW.codigo_credito=(select concat('CRED',CAST(numero AS CHAR)));
            
		END IF;
    END; //
DELIMITER ;

DROP TRIGGER IF EXISTS generar_numero_cotizacion;
DELIMITER //
CREATE TRIGGER generar_numero_cotizacion
BEFORE INSERT 
	ON cotizacion FOR EACH ROW
	BEGIN
    
        DECLARE numero INT(11);

        SET numero = (SELECT max(idcotizacion) FROM cotizacion);
        
		IF numero IS NULL then
		  set numero=1;
        SET NEW.numero_cotizacion='COTI00000001';

		ELSEIF numero >= 1 and numero < 9 then
			set numero=numero+1;
		SET NEW.numero_cotizacion=(select concat('COTI0000000',CAST(numero AS CHAR)));
        
		ELSEIF numero >=9 and numero<=99 then
			set numero=numero+1;
		SET NEW.numero_cotizacion=(select concat('COTI000000',CAST(numero AS CHAR)));
            
		ELSEIF numero>=99 and numero<=999 then
			set numero=numero+1;
		SET NEW.numero_cotizacion=(select concat('COTI00000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=999 and numero<=9999 then
		   set numero=numero+1;
		SET NEW.numero_cotizacion=(select concat('COTI0000',CAST(numero AS CHAR)));
           
		ELSEIF numero>=9999 and numero<=99999 then
			set numero=numero+1;
		SET NEW.numero_cotizacion=(select concat('COTI000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=99999 and numero<=999999 then
			set numero=numero+1;
		SET NEW.numero_cotizacion=(select concat('COTI00',CAST(numero AS CHAR)));
            
		ELSEIF numero>=999999 and numero<=9999999 then
			set numero=numero+1;
		SET NEW.numero_cotizacion=(select concat('COTI0',CAST(numero AS CHAR)));
            
        ELSEIF numero>=9999999  then -- DIEZ MILLONES EN DELANTE
			set numero=numero+1;
		SET NEW.numero_cotizacion=(select concat('COTI',CAST(numero AS CHAR)));
            
		END IF;
    END; //
DELIMITER ;

DROP TRIGGER IF EXISTS generar_codigo_ordentaller;
DELIMITER //
CREATE TRIGGER generar_codigo_ordentaller
BEFORE INSERT 
	ON ordentaller FOR EACH ROW
	BEGIN
    
        DECLARE numero INT;
        
        SET numero = (SELECT max(idorden) FROM ordentaller);
 
		IF numero IS NULL then
		  set numero=1;
        SET NEW.numero_orden ='00000001';

		ELSEIF numero >= 1 and numero < 9 then
			set numero=numero+1;
		SET NEW.numero_orden =(select concat('0000000',CAST(numero AS CHAR)));
        
		ELSEIF numero >=9 and numero<=99 then
			set numero=numero+1;
		SET NEW.numero_orden =(select concat('000000',CAST(numero AS CHAR)));
            
		ELSEIF numero>=99 and numero<=999 then
			set numero=numero+1;
		SET NEW.numero_orden =(select concat('00000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=999 and numero<=9999 then
		   set numero=numero+1;
		SET NEW.numero_orden =(select concat('0000',CAST(numero AS CHAR)));
           
		ELSEIF numero>=9999 and numero<=99999 then
			set numero=numero+1;
		SET NEW.numero_orden =(select concat('000',CAST(numero AS CHAR)));
             

		ELSEIF numero>=99999 and numero<=999999 then
			set numero=numero+1;
		SET NEW.numero_orden =(select concat('00',CAST(numero AS CHAR)));
            

		ELSEIF numero>=999999 and numero<=9999999 then
			set numero=numero+1;
		SET NEW.numero_orden =(select concat('0',CAST(numero AS CHAR)));
            
        ELSEIF numero>=9999999  then -- DIEZ MILLONES EN DELANTE
			set numero=numero+1;
		SET NEW.numero_orden =(numero);
            
		END IF;
        
    END; //
DELIMITER ;


DROP TRIGGER IF EXISTS generar_numero_apartado;
DELIMITER //
CREATE TRIGGER generar_numero_apartado
BEFORE INSERT 
	ON apartado FOR EACH ROW
	BEGIN
    
        DECLARE numero INT(11);

        SET numero = (SELECT max(idapartado) FROM apartado);
        
		IF numero IS NULL then
		  set numero=1;
        SET NEW.numero_apartado='APR00000001';

		ELSEIF numero >= 1 and numero < 9 then
			set numero=numero+1;
		SET NEW.numero_apartado=(select concat('APR0000000',CAST(numero AS CHAR)));
        
		ELSEIF numero >=9 and numero<=99 then
			set numero=numero+1;
		SET NEW.numero_apartado=(select concat('APR000000',CAST(numero AS CHAR)));
            
		ELSEIF numero>=99 and numero<=999 then
			set numero=numero+1;
		SET NEW.numero_apartado=(select concat('APR00000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=999 and numero<=9999 then
		   set numero=numero+1;
		SET NEW.numero_apartado=(select concat('APR0000',CAST(numero AS CHAR)));
           
		ELSEIF numero>=9999 and numero<=99999 then
			set numero=numero+1;
		SET NEW.numero_apartado=(select concat('APR000',CAST(numero AS CHAR)));
             
		ELSEIF numero>=99999 and numero<=999999 then
			set numero=numero+1;
		SET NEW.numero_apartado=(select concat('APR00',CAST(numero AS CHAR)));
            
		ELSEIF numero>=999999 and numero<=9999999 then
			set numero=numero+1;
		SET NEW.numero_apartado=(select concat('APR0',CAST(numero AS CHAR)));
            
        ELSEIF numero>=9999999  then -- DIEZ MILLONES EN DELANTE
			set numero=numero+1;
		SET NEW.numero_apartado=(select concat('APR',CAST(numero AS CHAR)));
            
		END IF;
    END; //
DELIMITER ;
