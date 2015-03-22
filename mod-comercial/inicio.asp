<%@ Language=VBScript %>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">

        <title>Gesti&oacuten Comercia - Login</title>
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <link href="link.css" rel="stylesheet" type="txt/css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Inicio</title>
</head>
<body>
	<!--#include file="menu.html"-->
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
<div class="container"></div>
	<button onclick="window.location.href='nue_cli.asp'" class="btn btn-lg col-lg-12">
    		<span class="glyphicon glyphicon-user"> Nuevo Cliente</span>
	</button><br><br><br>
	<button onclick="window.location.href='gest_comercial.asp'" class="btn btn-lg col-lg-12">
    		<span class="glyphicon glyphicon-th-list"> Nueva Visita</span>
	</button><br><br><br>
	<button onclick="window.location.href='gest_visitas.asp'" class="btn btn-lg col-lg-12">
    		<span class="glyphicon glyphicon-eye-open"> Ver visita</span>
	</button>
</div>
</body>
</html>
