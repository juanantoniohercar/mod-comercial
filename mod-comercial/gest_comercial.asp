<!DOCTYPE html>
<html>
<head>
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <title>Gesti&oacuten Comercia - Login</title>
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Inicio</title>
</head>
<body>
	<!--#include file="menu.html"-->
<div class="container">
<form action="#" method="POST" name="form_gest_com" id="form_gest_com" class="form-horizontal" role="form">
	<div class="from-group pull-right col-lg-4">
		<label>Comercial Asignado</label>
		<select class="form-control" id="nombre_cto">
  				<option>Pepe</option>
  				<option>Antonio</option>
 	 			<option>Luis</option>
			</select>
	</div>
	<div class="form-group col-lg-12">
 		<h3>Datos Del Cliente</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group col-lg-4">
		<label for="nombre_cli">Empresa</label>
		<div class="form-inline ">
			<input type="text" class="form-control" id="nombre_cli" maxlength="50">
			<button type="submit" class="btn btn-info">
    			<span class="glyphicon glyphicon-search"></span>
			</button>
			<button type="button" class="btn btn-success">
    		<a class="enlace" href="nue_cli"><span class="glyphicon glyphicon-plus-sign"></span></a>
		</button>
		</div>
	</div>
	<div class="form-group col-lg-5">
		<label>Telefono</label>
		<p class="form-control-static">000000000</p>
	</div>
	<div class="form-group col-lg-4">
		<label for="nombre_cto">Nombre Contacto</label>
		<select class="form-control" id="nombre_cto">
  				<option>Selecciona un contacto</option>
  				<option>Juan Antonio</option>
 	 			<option>Antonio</option>
			</select>
	</div>
	<div class="form-group col-lg-3">
		<label>Telefono</label>
		<p class="form-control-static">000000000</p>
	</div>
	<div class="form-group col-lg-4">
		<label>E-mail</label>
		<p class="form-control-static">email@ejemplo.com</p>
	</div>
	<div class="form-group col-lg-12">
 		<h3>Datos De La Visita</h3>
		<hr class="" color="DFDCDC">
	</div>

	<div class="form-group col-lg-3">
		<label for="fecha_hora_visita">Fecha/Hora Visita</label>
		<input type="datetime-local" class="form-control" id="fecha_hora_visita">
	</div>
	<div class="form-group col-lg-4">
		<label for="nombre_cto">Estado</label>
		<select class="form-control" id="nombre_cto">
  				<option>Selecciona un estado</option>
  				<option>Pendiente</option>
 	 			<option>Finalizada</option>
			</select>
	</div>
	<div class="form-group col-lg-7">
		<label for="resupuesto">Presupuesto</label>
		<div class="form-inline ">
			<input type="text" class="form-control" id="presupuesto">
			<button type="submit" class="btn btn-info">
    			<span class="glyphicon glyphicon-search"></span>
			</button>
		</div>
	</div>
	<div class="form-group col-lg-7">
		<label for="descripcion">Descripci&oacuten</label>
		<textarea class="form-control" rows="4"></textarea>
	</div>
	<div class="form-group col-lg-8">
		<button type="submit" class="btn btn-success">
    			<span class="glyphicon glyphicon-"></span>Guardar
			</button>
	</div>	

</form>
</div>
</body>
</html>
