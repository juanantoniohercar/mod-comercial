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
<body onload=document.getElementById("form_busqueda_cli").reset();>
	<!--#include file="menu.html"-->
	<!--#include file="busqueda_cli.asp"-->



<div class="container">
	<h3>Busqueda Cliente</h3>
	<hr color="DFDCDC">
<form action="bus_cli.asp" method="POST" name="form_busqueda_cli" id="form_busqueda_cli" class="form-horizontal" role="form">
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
			<input type="text" class="form-control" placeholder="DNI CIF" id="dnicif" name="bus_dnicif" maxlength="9">
		</div>
		<div class="form-group col-lg-4" style="display: none;" id="txt_nombre">
			<input type="text" class="form-control" placeholder="Nombre"  id="nombre" name="bus_nombre" maxlength="50">
		</div>
		<div class="form-group col-lg-5" style="display: none;" id="txt_domicilio">
			<input type="text" class="form-control" placeholder="Domicilio"  id="domicilio" name="bus_dom" maxlength="60">
		</div>
		<div class="form-group col-lg-5" style="display: none;" id="txt_localidad">
			<input type="text" class="form-control" placeholder="Localidad"  id="localidad" name="bus_localidad" maxlength="50">
		</div>
		<div class="form-group col-lg-12">
			<input type="submit" name="bus_clientes" value="Buscar" class="btn btn-info" >
			
		</div>

</form>
	<div class="form-group col-lg-12"><br>
 		<h3>Datos cliente</h3>
		<hr class="" color="DFDCDC">
		<button type="button" class="btn btn-success" onclick="window.location.href='bus_cli.asp'">Limpiar Tabla</button>
	</div>
	<%busqueda()%>
</div>
</body>
</html>
