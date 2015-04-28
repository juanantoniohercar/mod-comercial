<%Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <link href="link.css" rel="stylesheet" type="txt/css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Inicio</title>
</head>
<body>
	<!--#include file="menu.asp"-->
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
<div class="row">
	<%
	pag=0 %>
	<div class="col-xs-6 col-sm-6 col-md-12 col-lg-12">
		<button type="button" onclick="window.location.href='nue_cli.asp'" class="btn btn-primary btn-g col-xs-12 col-sm-12 col-md-12 col-lg-12">
    		<span class="glyphicon glyphicon-user"> Nuevo Cliente</span>
		</button><br><br><br><br><br><br><br>
	</div>
	<div class="col-xs-6 col-sm-6 col-md-12 col-lg-12">
		<button type="button" onclick="window.location.href='gest_comercial.asp'" class="btn btn-primary btn-g col-xs-12 col-sm-12 col-md-12">
    		<span class="glyphicon glyphicon-th-list"> Nueva Visita</span>
		</button><br><br><br><br><br><br><br>
	</div>
</div>
<div class="row">
	<div class="col-xs-6 col-sm-6 col-md-12 col-lg-12">

		<button type="button" onclick="window.location.href='gest_visitas.asp'" class="btn btn-primary btn-g col-xs-12 col-sm-12 col-md-12">
    		<span class="glyphicon glyphicon-eye-open"> Ver visita</span>
		</button><br><br><br><br><br><br><br>
	</div>	
	<div class="col-xs-6 col-sm-6 col-md-12 col-lg-12">
	
		<button type="button" onclick="window.location.href='salir.asp'" class="btn btn-primary btn-g col-xs-12 col-sm-12 col-md-12">
    		<span class="glyphicon glyphicon-log-out"> Salir</span>
		</button>
	</div>
</div>
</body>
</html>
