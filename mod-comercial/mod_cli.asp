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
	<div class="form-group col-lg-12"><br>
 		<h3>Cliente a modificar</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group col-lg-2">
		<label for="cif_modificar">C. I. F.</label>
		<input type="text" class="form-control" id="cif_modificar" maxlength="9">
	</div> 
	<div class="form-group col-lg-5">
		<label for="nombre_modificar">Nombre</label>
		<input type="text" class="form-control" id="nombre_modificar" maxlength="50">
	</div>
	<div class="form-group col-lg-6">
		<label for="direccion">Direcci&oacuten</label>
		<input type="text" class="form-control" id="direccion" maxlength="100">
	</div>
	<div class="form-group col-lg-4">
		<label for="poblacion">Poblaci&oacuten</label>
		<select class="form-control" id="poblacion">
  				<option>Seleccione una poblaci&oacuten</option>
  				<option>Chiclana de la Frontera</option>
 	 			<option>Arcos de la Frontera</option>
			</select>
	</div>
	<div class="form-group col-lg-2">
		<label for="codigo_postal_modificar">C&oacutedigo Postal</label>
		<input type="text" class="form-control" id="codigo_postal_modificar" maxlength="5">
	</div>

	<div class="form-group col-lg-3">
		<label for="provincia_modificar">Provincia</label>
		<select class="form-control" id="provincia_modificar">
  				<option>Seleccione una provincia</option>
  				<option>C&aacutediz</option>
 	 			<option>Malaga</option>
  				<option>Huelva</option>
  				<option>Granada</option>
  				<option>Almeria</option>
			</select>
 	</div>
 	<div class="form-group col-lg-3">
 		<label for="telefono_modificar">Tel&eacutefono</label>
 		<input type="text" class="form-control" id="telefono_modificar" maxlength="9">
 	</div>
 	<div class="form-group col-lg-12"><br>
 		<h3>Contacto a modificar</h3>
		<hr class="" color="DFDCDC">
		<button type="submit" class="btn btn-success btn-xs">
    		<span class="glyphicon glyphicon-plus-sign"></span>
		</button>
	</div>
	<div class="form-group col-lg-5">
		<label for="nombre_cto_modificar">Nombre</label>
		<input type="text" class="form-control" id="nombre_cto_modificar" maclength="45">
	</div>
	<div class="form-group col-lg-3">
		<label for="telefono_cto_modificar">Tel&eacutefono</label>
 		<input type="text" class="form-control" id="telefono_cto_modificar" maxlength="9" >
	</div>
	<div class="form-group col-lg-4">
		<label for="email_cto_modificar">E-mail</label>
		<input type="email" class="form-control" id="email_cto_modificar">

	</div>
	<div class="form-group col-lg-2">
		<input type="submit" name="modificar_cliente" value="Modificar" class="btn btn-primary btn-lg">
	</div>
</form>
</div>
</body>
</html>
