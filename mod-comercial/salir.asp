<!DOCTYPE html>
<html lang="es">
<head>
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/tableresponsive.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Salir</title>
</head>
<body>
  <% 
  session("autorizacion")=-1
  if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>

  <!--#include file="funciones.asp"-->

</body>
</html>
