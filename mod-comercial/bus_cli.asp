<%Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <link href="link.css" rel="stylesheet" type="txt/css">
        <script type="text/javascript" src="js/funciones.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Buscar Cliente</title>
	<script src="jquery-2.1.3.min.js" type="text/javascript"></script>  
	
	<script type="text/javascript">
		


	</script>
</head>
<body onload=document.getElementById("form_busqueda_cli").reset();>
	<% pag=2 %>
	<!--#include file="menu.asp"-->
	<!--#include file="busqueda_cli.asp"-->
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>



<div class="container">
	<h3>Busqueda Cliente</h3>
	<hr color="DFDCDC">
<form action="bus_cli.asp" method="get" name="form_busqueda_cli" id="form_busqueda_cli" class="form-horizontal" role="form">
	<div class="form-group col-lg-4">
		<label for="filtro">Filtro</label>
		<select class="form-control" id="cbb_filtro" onchange="mostrar(this);">
 				<option value="0" >Seleccione un filtro para la busqueda</option>
 				<option value="dni/cif" >N. I. F. / C. I. F.</option>
 	 			<option value="nombre" selected>Nombre</option>
 				<option value="domicilio">Domicilio</option>
 				<option value="localidad">Localidad</option>
			</select>
	</div>
	<div class="form-group"></div>
		<div class="form-group col-lg-2" style="display: none;" id="txt_dnicif">
			<input type="text" class="form-control" placeholder="N. I. F. / C. I. F." id="bus_dnicif" name="bus_dnicif" maxlength="9" onblur="comprobarNifCif(document.getElementById('bus_dnicif').value)">
		</div>
		<div class="form-group col-lg-4" id="txt_nombre">
			<input type="text" class="form-control" placeholder="Nombre"  id="nombre" name="bus_nombre" maxlength="50">
		</div>
		<div class="form-group col-lg-5" style="display: none;" id="txt_domicilio">
			<input type="text" class="form-control" placeholder="Domicilio"  id="domicilio" name="bus_dom" maxlength="60">
		</div>
		<div class="form-group col-lg-5" style="display: none;" id="txt_localidad">
			<input type="text" class="form-control" placeholder="Localidad"  id="localidad" name="bus_localidad" maxlength="50">
		</div>
		<div class="form-group col-lg-12">
			<button  type="submit" class="btn btn-info">
				<span>Buscar</span>

			</button>
			
		</div>
		
</form>
	<div class="form-group col-lg-12"><br>
 		<h3>Datos cliente</h3>
		<hr class="" color="DFDCDC">
		<button type="button" class="btn btn-success" onclick="window.location.href='bus_cli.asp'">Limpiar listado</button>
	</div>
	<%busqueda()%>
	<div class="pull-right col-xs-6 col-sm-6 col-md-6">
		<button type="button" class="btn btn-warning btn-lg pull-right" onclick='window.location.href="inicio.asp"'>
    		<span class="">Volver</span>
		</button>
		</div>
</div>
</body>
</html>
