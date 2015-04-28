
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
        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/bootstrap-confirmation.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if%>
	<nav class="navbar navbar-default" role="navigation">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
				<span class="sr-only">Menu</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
		<%
		 	
			if pag=0 then

					seccion="Inicio"
			end if
			if pag=1 then

					seccion="Nuevo Cliente"
			end if
			if pag=2 then

					seccion="B&uacutesqueda Cliente"
			end if
			if pag=3 then

					seccion="Modificar Cliente"
			end if
			if pag=4 then

					seccion="Listar Cliente"
			end if
			if pag=5 then

					seccion="Nueva Visita"
			end if
			if pag=6 then

					seccion="B&uacutesqueda Visita"
			end if
			if pag=7 then

					seccion="Modificar Visita"
			end if
			if pag=8 then

					seccion="Buscar Presupuesto"
			end if
			if pag=9 then

					seccion="Cargando..."
			end if

		%>
			<a class="navbar-brand" href="inicio.asp" ><%=seccion%></a>
		</div>
		<div class="collapse navbar-collapse navbar-ex1-collapse">
			<ul class="nav navbar-nav">
				<li><a href="inicio.asp"><span class="glyphicon glyphicon-home"></span>Inicio</a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Cliente <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="nue_cli.asp">Nuevo Cliente</a></li>
						<li><a href="bus_cli.asp">Busqueda Cliente</a></li>
					</ul>
				</li>
				<li> <a href="gest_comercial.asp">Gesti&oacuten Comercial</a></li>
				<li> <a href="gest_visitas.asp">Gesti&oacuten Visitas</a></li>
				<li><a href="salir.asp">Salir</a></li>
				
			</ul>
		</div>
	</nav>
</body>
</html>