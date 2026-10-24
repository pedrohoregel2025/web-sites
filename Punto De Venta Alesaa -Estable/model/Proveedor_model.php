<?php 

	require_once('Conexion.php');

	class ProveedorModel extends Conexion
	{
		public static function Listar_Proveedores()
		{
			$dbconec = Conexion::Conectar();

			try 
			{
				$query = "CALL sp_view_proveedor();";
				$stmt = $dbconec->prepare($query);
				$stmt->execute();
				$count = $stmt->rowCount();

				if($count > 0)
				{
					return $stmt->fetchAll();
				}

				
				$dbconec = null;
			} catch (Exception $e) {
				
				echo '<span class="label label-danger label-block">ERROR AL CARGAR LOS DATOS, PRESIONE F5</span>';
			}
		}

		public static function Insertar_Proveedor($nombre_proveedor, $numero_telefono, $clave_rfc, $regimen_fiscal, $direccion_proveedor,
		$nombre_contacto, $telefono_contacto)
		{
			$dbconec = Conexion::Conectar();
			try 
			{
				$query = "CALL sp_insert_proveedor(:nombre_proveedor, :numero_telefono, :clave_rfc, :regimen_fiscal, :direccion_proveedor,
				:nombre_contacto, :telefono_contacto)";
				$stmt = $dbconec->prepare($query);
				$stmt->bindParam(":nombre_proveedor",$nombre_proveedor);
				$stmt->bindParam(":numero_telefono",$numero_telefono);
				$stmt->bindParam(":clave_rfc",$clave_rfc);
				$stmt->bindParam(":regimen_fiscal",$regimen_fiscal);
				$stmt->bindParam(":direccion_proveedor",$direccion_proveedor);
				$stmt->bindParam(":nombre_contacto",$nombre_contacto);
				$stmt->bindParam(":telefono_contacto",$telefono_contacto);

				if($stmt->execute())
				{
					$count = $stmt->rowCount();
					if($count == 0){
						$data = "Duplicado";
 	   					echo json_encode($data);
					} else {
						$data = "Validado";
 	   					echo json_encode($data);
					}
				} else {

					$data = "Error";
 	   		 	 	echo json_encode($data);
				}
				$dbconec = null;
			} catch (Exception $e) {
				$data = "Error";
				echo json_encode($data);
				
			}

		}

		public static function Editar_Proveedor($idproveedor ,$nombre_proveedor, $numero_telefono, $clave_rfc, $regimen_fiscal, $direccion_proveedor,
		$nombre_contacto, $telefono_contacto,$estado)
		{
			$dbconec = Conexion::Conectar();
			try 
			{
				$query = "CALL sp_update_proveedor(:idproveedor, :nombre_proveedor, :numero_telefono, :clave_rfc, :regimen_fiscal, :direccion_proveedor,
				:nombre_contacto, :telefono_contacto, :estado);";
				$stmt = $dbconec->prepare($query);
				$stmt->bindParam(":idproveedor",$idproveedor);
				$stmt->bindParam(":nombre_proveedor",$nombre_proveedor);
				$stmt->bindParam(":numero_telefono",$numero_telefono);
				$stmt->bindParam(":clave_rfc",$clave_rfc);
				$stmt->bindParam(":regimen_fiscal",$regimen_fiscal);
				$stmt->bindParam(":direccion_proveedor",$direccion_proveedor);
				$stmt->bindParam(":nombre_contacto",$nombre_contacto);
				$stmt->bindParam(":telefono_contacto",$telefono_contacto);
				$stmt->bindParam(":estado",$estado);


				if($stmt->execute())
				{

				  $data = "Validado";
   				  echo json_encode($data);
				
				} else {

					$data = "Error";
 	   		 	 	echo json_encode($data);
				}
				$dbconec = null;
			} catch (Exception $e) {
				$data = "Error";
				echo json_encode($data);
			
			}

		}

	}


 ?>