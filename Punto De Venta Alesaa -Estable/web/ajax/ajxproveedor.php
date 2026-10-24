<?php 

	function __autoload($className){
		$model = "../../model/". $className ."_model.php";
		$controller = "../../controller/". $className ."_controller.php";
	
		require_once($model);
		require_once($controller);
	}

	$funcion = new Proveedor();

	if(isset($_POST['nombre_proveedor']) && isset($_POST['clave_rfc'])){
		
		try {


			$proceso = $_POST['proceso'];
			$id = $_POST['id'];
			$nombre_proveedor = trim($_POST['nombre_proveedor']);
			$numero_telefono = trim($_POST['numero_telefono']);
			$clave_rfc = trim($_POST['clave_rfc']);
			$regimen_fiscal = trim($_POST['regimen_fiscal']);
			$direccion_proveedor = trim($_POST['direccion_proveedor']);			
			$nombre_contacto = trim($_POST['nombre_contacto']);
			$telefono_contacto = trim($_POST['telefono_contacto']);
			$estado = trim($_POST['estado']);

			$numero_telefono =  str_replace ( "-", "", $numero_telefono);
			$telefono_contacto = str_replace ( "-", "", $telefono_contacto);
			$clave_rfc = str_replace ( "-", "", $clave_rfc);

			switch($proceso){

			case 'Registro':
				$funcion->Insertar_Proveedor($nombre_proveedor, $numero_telefono, $clave_rfc, $regimen_fiscal, $direccion_proveedor,
				$nombre_contacto, $telefono_contacto);
			break;

			case 'Edicion':
				$funcion->Editar_Proveedor($id,$nombre_proveedor, $numero_telefono, $clave_rfc, $regimen_fiscal, $direccion_proveedor,
				$nombre_contacto, $telefono_contacto, $estado);
			break;

			default:
				$data = "Error";
 	   		 	echo json_encode($data);
			break;
		}
			
		} catch (Exception $e) {
			
			$data = "Error";
 	   		echo json_encode($data);
		}

	}
	
	

  	

?>
