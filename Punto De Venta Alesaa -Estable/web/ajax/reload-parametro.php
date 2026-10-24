<?php

	function __autoload($className){
		$model = "../../model/". $className ."_model.php";
		$controller = "../../controller/". $className ."_controller.php";

		require_once($model);
		require_once($controller);
	}

	$objParametro =  new Parametro();

 ?>
		<table class="table datatable-basic table-xxs table-hover">
						<thead>
							<tr>
								<th>No</th>
								<th>Empresa</th>
								<th>Propietario</th>
								<th>RFC</th>
								<th>% IVA</th>
								<th class="text-center">Opciones</th>
							</tr>
						</thead>

						<tbody>

						  <?php
								$filas = $objParametro->Listar_Parametros();
								if (is_array($filas) || is_object($filas))
								{
								foreach ($filas as $row => $column)
								{

									$rfc = $column['clave_rfc'];
									//$rfc =  substr($rfc, 0, 4).'-'.substr($rfc, 4, 6).'-'.substr($rfc, 10, 3).'-'.substr($rfc, 13);
								?>
									<tr>
					                	<td><?php print($column['idparametro']); ?></td>
					                	<td><?php print($column['nombre_empresa']); ?></td>
					                	<td><?php print($column['propietario']); ?></td>
					                	<td><?php print($rfc); ?></td>
					                	<td><?php print($column['porcentaje_iva']); ?></td>
					                	<td class="text-center">
										<ul class="icons-list">
											<li class="dropdown">
												<a href="#" class="dropdown-toggle" data-toggle="dropdown">
													<i class="icon-menu9"></i>
												</a>

												<ul class="dropdown-menu dropdown-menu-right">
													<li><a
													href="javascript:;" data-toggle="modal" data-target="#modal_iconified"
													onclick="openParametro('editar',
																'<?php print($column["idparametro"]); ?>',
																'<?php print($column["nombre_empresa"]); ?>',
																'<?php print($column["propietario"]); ?>',
																'<?php print($rfc); ?>',
																'<?php print($column["regimen_fiscal"]); ?>',
																'<?php print($column["porcentaje_iva"]); ?>',
																'<?php print($column["porcentaje_retencion"]); ?>',
																'<?php print($column["monto_retencion"]); ?>',
																'<?php print($column["idcurrency"]); ?>',
																'<?php print($column["direccion_empresa"]); ?>')">
												   <i class="icon-pencil6">
											       </i> Editar</a></li>
													<li><a
													href="javascript:;" data-toggle="modal" data-target="#modal_iconified"
													onclick="openParametro('ver',
																'<?php print($column["idparametro"]); ?>',
																'<?php print($column["nombre_empresa"]); ?>',
																'<?php print($column["propietario"]); ?>',
																'<?php print($rfc); ?>',
																'<?php print($column["regimen_fiscal"]); ?>',
																'<?php print($column["porcentaje_iva"]); ?>',
																'<?php print($column["porcentaje_retencion"]); ?>',
																'<?php print($column["monto_retencion"]); ?>',
																'<?php print($column["idcurrency"]); ?>',
																'<?php print($column["direccion_empresa"]); ?>')">
													<i class=" icon-eye8">
													</i> Ver</a></li>
												</ul>
											</li>
										</ul>
									</td>
					                </tr>
								<?php
								}
							}
							?>

						</tbody>
					</table>

<script type="text/javascript" src="web/custom-js/parametro.js"></script>
