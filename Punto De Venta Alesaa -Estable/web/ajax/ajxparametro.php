<?php

	function __autoload($className){
		$model = "../../model/". $className ."_model.php";
		$controller = "../../controller/". $className ."_controller.php";

		require_once($model);
		require_once($controller);
	}

	$funcion = new Parametro();

	if (!empty($_GET)){
		$criterio = isset($_GET['criterio']) ? $_GET['criterio'] : '';

		if($criterio == "moneda"){
			$funcion->Ver_Moneda();

		} else if ($criterio =="iva"){
			$funcion->Ver_Impuesto();
		}

	}


	if (!empty($_POST))
	{
	if(isset($_POST['nombre_empresa'])){

		try {

			$proceso = $_POST['proceso'];
			$id = $_POST['id'];
			$nombre_empresa = trim($_POST['nombre_empresa']);
			$propietario = trim($_POST['propietario']);
			$clave_rfc = trim($_POST['clave_rfc']);
			$regimen_fiscal = trim($_POST['regimen_fiscal']);
			$porcentaje_iva = trim($_POST['porcentaje_iva']);
			$porcentaje_retencion = trim($_POST['porcentaje_retencion']);
			$monto_retencion = trim($_POST['monto_retencion']);
			$direccion_empresa = trim($_POST['direccion_empresa']);
			$idcurrency = trim($_POST['idcurrency']);

			$clave_rfc = str_replace ( "-", "", $clave_rfc);

			switch($proceso){

			case 'Registro':
				$funcion->Insertar_Parametro($nombre_empresa,$propietario,$clave_rfc,$regimen_fiscal,$porcentaje_iva,
				$porcentaje_retencion,$monto_retencion,$direccion_empresa,$idcurrency);
			break;

			case 'Edicion':
				$funcion->Editar_Parametro($id,$nombre_empresa,$propietario,$clave_rfc,$regimen_fiscal,$porcentaje_iva,
				$porcentaje_retencion,$monto_retencion,$direccion_empresa,$idcurrency);
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
