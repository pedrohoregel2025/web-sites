<?php

	function __autoload($className){
		$model = "../../model/". $className ."_model.php";
		$controller = "../../controller/". $className ."_controller.php";

		require_once($model);
		require_once($controller);
	}

	$funcion = new Cliente();

	if(!empty($_GET)){
			$idcliente = isset($_GET['cliente']) ? $_GET['cliente'] : '';
			$funcion->Ver_Limite_Credito($idcliente);
	}

	if (!empty($_POST))
	{

	if(isset($_POST['nombre_cliente'])){

		try {

			$proceso = $_POST['proceso'];
			$id = $_POST['id'];
			$nombre_cliente = trim($_POST['nombre_cliente']);
			$regimen_fiscal = trim($_POST['regimen_fiscal']);
			$numero_telefono = trim($_POST['numero_telefono']);
			$clave_rfc = trim($_POST['clave_rfc']);
			$email = trim($_POST['email']);
			$giro = trim($_POST['giro']);
			$estado = trim($_POST['estado']);
			$direccion = trim($_POST['direccion']);
			$limite_credito = trim($_POST['limite_credito']);
			
			$numero_telefono =  str_replace ( "-", "", $numero_telefono);
			$clave_rfc = str_replace ( "-", "", $clave_rfc);

			switch($proceso){

			case 'Registro':
				$funcion->Insertar_Cliente($nombre_cliente,$clave_rfc,$regimen_fiscal,$direccion,
				$numero_telefono,$email,$giro,$limite_credito);
			break;

			case 'Edicion':
				$funcion->Editar_Cliente($id,$nombre_cliente,$clave_rfc,$regimen_fiscal,$direccion,
				$numero_telefono,$email,$giro,$limite_credito,$estado);
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

}




?>
