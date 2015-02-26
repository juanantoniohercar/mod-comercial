<!DOCTYPE html>
<html>
<head>
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <title>Gesti&oacuten Comercia - Login</title>
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <link href="link.css" rel="stylesheet" type="txt/css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Inicio</title>
	<script src="jquery-2.1.3.min.js" type="text/javascript"></script>  
	
	<script type="text/javascript">
		function mostrar(sel){
			if (sel.value=="dni/cif"){
				document.getElementById('txt_dnicif').style.display = 'block';
			}else{
				document.getElementById('txt_dnicif').style.display = 'none';
			}
			if (sel.value=="nombre"){
				document.getElementById('txt_nombre').style.display = 'block';
			}else{
				document.getElementById('txt_nombre').style.display = 'none';
			}
			if (sel.value=="domicilio"){
				document.getElementById('txt_domicilio').style.display = 'block';
			}else{
				document.getElementById('txt_domicilio').style.display = 'none';
			}
			if (sel.value=="localidad"){
				document.getElementById('txt_localidad').style.display = 'block';
			}else{
				document.getElementById('txt_localidad').style.display = 'none';
			}
		}

	</script>
</head>
<body>
	<!--#include file="menu.html"-->
<div class="container">
	<h3>Busqueda Cliente</h3>
	<hr color="DFDCDC">
<form action="#" method="POST" name="form_busqueda_cli" id="form_busqueda_cli" class="form-horizontal" role="form">
	<div class="form-group col-lg-4">
		<label for="filtro">Filtro</label>
		<select class="form-control" id="cbb_filtro" onchange="mostrar(this);">
  				<option value="0" >Seleccione un filtro para la busqueda</option>
  				<option value="dni/cif" >DNI/CIF</option>
 	 			<option value="nombre">Nombre</option>
  				<option value="domicilio">Domicilio</option>
  				<option value="localidad">Localidad</option>
			</select>
	</div>
	<div class="form-group"></div>
		<div class="form-group col-lg-2" style="display: none;" id="txt_dnicif">
			<input type="text" class="form-control" placeholder="DNI CIF" id="dnicif" maxlength="9">
		</div>
		<div class="form-group col-lg-4" style="display: none;" id="txt_nombre">
			<input type="text" class="form-control" placeholder="Nombre"  id="nombre" maxlength="50">
		</div>
		<div class="form-group col-lg-5" style="display: none;" id="txt_domicilio">
			<input type="text" class="form-control" placeholder="Domicilio"  id="domicilio" maxlength="60">
		</div>
		<div class="form-group col-lg-5" style="display: none;" id="txt_localidad">
			<input type="text" class="form-control" placeholder="Localidad"  id="localidad" maxlength="50">
		</div>
		<div class="form-group col-lg-12">
			<input type="submit" id="buscar_cliente" value="Buscar" class="btn btn-info">
		</div>
</form>
	<div class="form-group col-lg-12"><br>
 		<h3>Datos cliente</h3>
		<hr class="" color="DFDCDC">
	</div>
 	<div class="form-group col-lg-12">
		<button type="submit" class="btn btn-success btn-xs">
    		<span class="glyphicon glyphicon-plus-sign"></span>
		</button>
	</div>
	<table border=3 class="table table-striped">
		<thead>
  			<tr>
  				<th>Nombre</th>
  				<th>Telefono</th>
  				<th>Domicilio</th>
  				<th>OPCIONES</th>
  			</tr>
  		</thead>
  		<tbody>
  			<tr>
  				<td>Juan antonio hernandez carrera</td>
  				<td>664296673</td>
  				<td>C/ Pintor Luis de Morales, 6</td>
  				<td>
  					<button type="submit" onclick="window.location.href='mod_cli.asp'"class="btn btn-primary btn-xs">
    					<span class="glyphicon glyphicon-pencil"></span></a>
					</button>
					<button type="submit" class="btn btn-success btn-xs">
						<a class="enlace" href="abrir_cli.asp"><span class="glyphicon glyphicon-open"></span></a>
					</button>
					<button type="submit" class="btn btn-danger btn-xs">
    					<span class="glyphicon glyphicon-remove-circle"></span>
					</button>
				</td>
  			</tr>
		</tbody>	
		</table>
</div>
</body>
</html>
