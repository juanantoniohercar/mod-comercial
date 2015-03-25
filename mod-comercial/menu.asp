<html>
<head>
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <title>Gesti&oacuten Comercia - Login</title>
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/bootstrap-confirmation.js"></script>
        

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Inicio</title>
</head>
<body>
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
	<nav class="navbar navbar-default" role="navigation">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
				<span class="sr-only">Menu</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="inicio.asp" >Moneleg - Gestion Comercial</a>
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
				<li><button type="button" class="btn btn-danger" onclick='location.href="Default.asp"'>
 					<span class="glyphicon glyphicon-remove"> Salir</span>
					</button>
				</li>
			</ul>
		</div>
	</nav>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>