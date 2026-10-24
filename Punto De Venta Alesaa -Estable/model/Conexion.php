<?php

	class Conexion {

		public static function Conectar(){

			//Local
			/*$driver = 'mysql'; //mysql no cambiar
			$host = 'localhost'; //localhost
			$dbname = 'adminlaz_easypos'; //bdd
			$username ='adminlaz_easypos'; //usuario
			$passwd = 'N*7~]@V)sq1q'; //contra*/

			//Produccion
			$driver = 'mysql'; //mysql no cambiar
			$host = 'localhost'; //localhost
			$dbname = 'u347475349_work'; //bdd
			$username ='u347475349_work'; //usuario
			$passwd = 'W0rk2o18%'; //contra

			$server=$driver.':host='.$host.';dbname='.$dbname;

			try {

				$conexion = new PDO($server,$username,$passwd);
				//$conexion = exec("SET CHARACTER SET utf8");
				$conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			} catch (Exception $e) {

				$conexion = null;
            	echo '<span class="label label-danger label-block">ERROR AL CONECTARSE A LA BASE DE DATOS, PRESIONE F5</span>';
            	exit();
			}


			return $conexion;

		}

	}
