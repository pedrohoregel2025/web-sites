<?php

	$objProveedor =  new Proveedor();
	if($tipo_usuario==1){

?>

			<!-- Basic initialization -->
			<div class="panel panel-flat">
				<div class="breadcrumb-line">
					<ul class="breadcrumb">
						<li><a href="?View=Inicio"><i class="icon-home2 position-left"></i> Inicio</a></li>
						<li><a href="javascript:;">Compras</a></li>
						<li class="active">Proveedores</li>
					</ul>
				</div>
					<div class="panel-heading">
						<h5 class="panel-title">Proveedores</h5>

						<div class="heading-elements">
							<button type="button" class="btn btn-primary heading-btn"
							onclick="newProveedor()">
							<i class="icon-database-add"></i> Agregar Nuevo/a</button>


							<button type="button" id="print_proveedor" class="btn btn-info heading-btn">
							<i class="icon-file-pdf"></i> Imprimir Reporte</button>

						</div>
					</div>
					<div class="panel-body">
					</div>
					<div id="reload-div">
					<table class="table datatable-basic table-xxs table-hover">
						<thead>
							<tr>
								<th>No</th>
								<th>Proveedor</th>
								<th>RFC</th>
								<th>Tel&eacute;fono</th>
								<th>Estado</th>
								<th class="text-center">Opciones</th>
							</tr>
						</thead>

						<tbody>

						  <?php
								$filas = $objProveedor->Listar_Proveedores();
								if (is_array($filas) || is_object($filas))
								{
								foreach ($filas as $row => $column)
								{

									$rfc = $column['clave_rfc'];
									$telefono = $column['numero_telefono'];
									$telefono_contacto = $column['telefono_contacto'];

									//Dejar contenido sin formato
									//$rfc =  substr($rfc, 0, 4).'-'.substr($rfc, 4, 6).'-'.substr($rfc, 10, 3).'-'.substr($rfc, 13);									
									
									$telefono = substr($telefono, 0, 3).'-'.substr($telefono, 3, 3).'-'.substr($telefono, 6, 4);
									$telefono_contacto = substr($telefono_contacto, 0, 3).'-'.substr($telefono_contacto, 3, 3).'-'.substr($telefono_contacto, 6, 4);
								?>
									<tr>
					                	<td><?php print($column['codigo_proveedor']); ?></td>
					                	<td><?php print($column['nombre_proveedor']); ?></td>
					                	<td><?php print $rfc; ?></td>
					                	<td><?php print($telefono); ?></td>
					                	<td><?php if($column['estado'] == '1')
					                		echo '<span class="label label-success label-rounded"><span
					                		class="text-bold">VIGENTE</span></span>';
					                		else
					                		echo '<span class="label label-default label-rounded">
					                	<span
					                	    class="text-bold">DESCONTINUADO</span></span>'
						                ?></td>
					                	<td class="text-center">
										<ul class="icons-list">
											<li class="dropdown">
												<a href="#" class="dropdown-toggle" data-toggle="dropdown">
													<i class="icon-menu9"></i>
												</a>

												<ul class="dropdown-menu dropdown-menu-right">
													<li><a
													href="javascript:;" data-toggle="modal" data-target="#modal_iconified"
													onclick="openProveedor('editar',
								                     '<?php print($column["idproveedor"]); ?>',
								                     '<?php print($column["codigo_proveedor"]); ?>',
								                     '<?php print($column["nombre_proveedor"]); ?>',
								                     '<?php print($telefono); ?>',
								                     '<?php print($rfc); ?>',
								                     '<?php print($column["regimen_fiscal"]); ?>',
																		 '<?php print($column["direccion_proveedor"]); ?>',
								                     '<?php print($column["nombre_contacto"]); ?>',
								                     '<?php print($telefono_contacto); ?>',
								                     '<?php print($column["estado"]); ?>')">
												   <i class="icon-pencil6">
											       </i> Editar</a></li>
													<li><a
													href="javascript:;" data-toggle="modal" data-target="#modal_iconified"
													onclick="openProveedor('ver',
								                     '<?php print($column["idproveedor"]); ?>',
								                     '<?php print($column["codigo_proveedor"]); ?>',
								                     '<?php print($column["nombre_proveedor"]); ?>',
								                     '<?php print($telefono); ?>',
								                     '<?php print($rfc); ?>',
								                     '<?php print($column["regimen_fiscal"]); ?>',
																		 '<?php print($column["direccion_proveedor"]); ?>',
								                     '<?php print($column["nombre_contacto"]); ?>',
								                     '<?php print($telefono_contacto); ?>',
								                     '<?php print($column["estado"]); ?>')">
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
					</div>
				</div>

			<!-- Iconified modal -->
				<div id="modal_iconified" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h5 class="modal-title"><i class="icon-pencil7"></i> &nbsp; <span class="title-form"></span></h5>
							</div>

					        <form role="form" autocomplete="off" class="form-validate-jquery" id="frmModal">
								<div class="modal-body" id="modal-container">

								<div class="alert alert-info alert-styled-left text-blue-800 content-group">
						                <span class="text-semibold">Estimado usuario</span>
						                Los campos remarcados con <span class="text-danger"> * </span> son necesarios, 
														como adicional, no se puede agregar un proveedor nuevo con el nombre de uno ya existente.
						                <button type="button" class="close" data-dismiss="alert">×</button>
						                <input type="hidden" id="txtID" name="txtID" class="form-control" value="">
                                      	<input type="hidden" id="txtProceso" name="txtProceso" class="form-control" value="">
						           </div>


						           <div class="form-group">
										<div class="row">
											<div class="col-sm-6">
												<label>C&oacute;digo</label>
												<input type="text" id="txtCodigo" name="txtCodigo" placeholder="AUTOGENERADO"
												 class="form-control" style="text-transform:uppercase;"
                                        		onkeyup="javascript:this.value=this.value.toUpperCase();" readonly="" disabled="disabled">
											</div>
										</div>
									</div>

									<div class="form-group">
										<div class="row">
											<div class="col-sm-12">
												<label>Proveedor <span class="text-danger">*</span></label>
												<input type="text" id="txtProveedor" name="txtProveedor" placeholder="EJ. DISTRIBUIDORA"
												 class="form-control" style="text-transform:uppercase;"
                                        		onkeyup="javascript:this.value=this.value.toUpperCase();">
											</div>
										</div>
									</div>

									<div class="form-group">
										<div class="row">
											<div class="col-sm-6">
												<label>RFC (P&uacute;blico en general XAXX010101000) <span class="text-danger">*</span></label>
												<input type="text" id="txtRFC" name="txtRFC" placeholder="EJ. XAXX010101000"
												 class="form-control" style="text-transform:uppercase;"
                                        		onkeyup="javascript:this.value=this.value.toUpperCase();">
											</div>

											<div class="col-sm-6">
												<label>R&eacute;gimen Fiscal <span class="text-danger">*</span></label>
												<input type="text" id="txtREF" name="txtREF" placeholder="EJ. 621"
												 class="form-control" style="text-transform:uppercase;"
                                        		onkeyup="javascript:this.value=this.value.toUpperCase();">
											</div>

										</div>
									</div>

									<div class="form-group">
										<div class="row">
											<div class="col-sm-8">
												<label>Tel&eacute;fono <span class="text-danger">*</span></label>
												<input type="text" id="txtTelefono" name="txtTelefono" placeholder="EJ. 999-999-9999"
												 class="form-control" style="text-transform:uppercase;"
                                        		onkeyup="javascript:this.value=this.value.toUpperCase();">
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="row">
											<div class="col-sm-12">
												<label>Direcci&oacute;n <span class="text-danger">*</span></label>
												<input type="text" id="txtDireccionp" name="txtDireccionp" placeholder="EJ. CALLE #100, COLONIA EJEMPLO, CP 00000, M&Eacute;XICO"
												 class="form-control" style="text-transform:uppercase;"
                                        		onkeyup="javascript:this.value=this.value.toUpperCase();">
											</div>
										</div>
									</div>									

									<div class="form-group">
										<div class="row">
											<div class="col-sm-6">
												<label>Contacto</label>
												<input type="text" id="txtContacto" name="txtContacto" placeholder="EJ. ALEXANDER MTZ."
												 class="form-control" style="text-transform:uppercase;"
                                        		onkeyup="javascript:this.value=this.value.toUpperCase();">
											</div>

											<div class="col-sm-6">
												<label>Tel&eacute;fono Contacto</label>
												<input type="text" id="txtTelefonoC" name="txtTelefonoC" placeholder="EJ. 999-999-9999"
												 class="form-control" style="text-transform:uppercase;"
                                        		onkeyup="javascript:this.value=this.value.toUpperCase();">
											</div>

										</div>
									</div>

									<div class="form-group">
										<div class="row">
											<div class="col-sm-8">
												<div class="checkbox checkbox-switchery switchery-sm">
													<label>
													<input type="checkbox" id="chkEstado" name="chkEstado"
													 class="switchery" checked="checked" >
													 <span id="lblchk">VIGENTE</span>
												   </label>
												</div>
											</div>
										</div>
									</div>


								</div>

								<div class="modal-footer">
									<button id="btnGuardar" type="submit" class="btn btn-primary">Guardar</button>
									<button id="btnEditar" type="submit" class="btn btn-warning">Editar</button>
									<button  type="reset" class="btn btn-default" id="reset"
									class="btn btn-link" data-dismiss="modal">Cerrar</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- /iconified modal -->
				<?php include('./includes/footer.inc.php'); ?>
			</div>
			<!-- /content area -->
		</div>
		<!-- /main content -->
	</div>
	<!-- /page content -->
</div>
<!-- /page container -->
</body>
</html>
<script type="text/javascript" src="web/custom-js/proveedor.js"></script>

<?php } else { ?>

	<div class="panel-body">
		<div class="row">
			<div class="col-md-12">

				<!-- Widget with rounded icon -->
				<div class="panel">
					<div class="panel-body text-center">
						<div class="icon-object border-danger-400 text-primary-400"><i class="icon-lock5 icon-3x text-danger-400"></i>
						</div>
						<h2 class="no-margin text-semibold"> SU USUARIO NO POSEE PERMISOS SUFICIENTES </h2>
						<span class="text-uppercase text-size-mini text-muted">Su usuario no posee los permisos respectivos
						para poder accesar a este m&oacute;dulo. Lo invitamos a dar click </span> <a href="./?View=Inicio">AQU&Iacute;</a> <br><br>

					</div>
				</div>
				<!-- /widget with rounded icon -->
			</div>
		</div>

<?php } ?>
