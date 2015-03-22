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
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
<div class="container">
	<div class="form-group col-lg-12"><br>
		<button type="submit" class="btn btn-default btn-sm pull-right">
    			<span class="glyphicon glyphicon-print"></span>
		</button>
		<button type="submit" class="btn btn-default btn-sm pull-right">
    			<span class="glyphicon glyphicon-floppy-save"></span>
		</button>
 		<h3>Datos cliente</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group col-lg-2">
		<label>C. I. F.</label>
		<p class="form-control-static"> x00000000</p>
	</div> 
	<div class="form-group col-lg-5">
		<label>Nombre</label>
		<p class="form-control-static"> Moneleg. S. L.</p>
	</div>
	<div class="form-group col-lg-6">
		<label>Direcci&oacuten</label>
	<p class="form-control-static"> Chiclana</p>
	</div>
	<div class="form-group col-lg-4">
		<label>Poblaci&oacuten</label>
		<p class="form-control-static"> Chiclana</p>	
	</div>
	<div class="form-group col-lg-2">
		<label>C&oacutedigo Postal</label>
		<p class="form-control-static"> 00000</p>	
	</div>
	<div class="form-group col-lg-3">
		<label>Provincia</label>
		<p class="form-control-static"> C&aacutediz</p>
 	</div>
 	<div class="form-group col-lg-3">
 		<label>Tel&eacutefono</label>
		<p class="form-control-static"> 999999999</p> 	
	</div>
	<div class="form-group col-lg-12">
 		<h3>Datos contacto</h3>
		<hr class="" color="DFDCDC">
	</div>
	<table border=3 class="table table-striped">
		<thead>
  			<tr>
  				<th>Nombre</th>
  				<th>Telefono</th>
  				<th>E-mail</th>
  			</tr>
  		</thead>
  		<tbody>
  			<tr>
  				<td>Juan antonio hernandez carrera</td>
  				<td>664296673</td>
  				<td>juanantonio.hercar@gmail.com</td>
  			</tr>
		</tbody>	
		</table>
</div>
</body>
</html>







