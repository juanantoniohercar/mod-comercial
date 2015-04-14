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
  <% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
	<!--#include file="menu.asp"-->
  <!--#include file="funciones.asp"-->
<div class="container">
<form action="gest_visitas.asp" method="POST" name="form_busq_visitas" id="form_busq_visitas" class="form-horizontal" role="form">
	<div class="form-group col-lg-12">
 		<h3>Buscar Visitas</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group form-inline col-lg-7">
		<label>Fecha: DESDE</label>
		<input type="date" class="form-control" id="busv_fecha1" name="busv_fecha1">
    <label> HASTA</label>
    <input type="date" class="form-control" id="busv_fecha2" name="busv_fecha2">
  </div>
  <div class="form-group form-inline">
    <label for="estado">Estado visita</label>
    <select class="form-control" id="busv_estado" name="busv_estado">
          <option>Selecciona un estado</option>
          <% call select_est() %>
          <option value="3">Todas</option>
      </select>
  </div>
  <div class="form-group col-lg-12">
    <button type="submit" class="btn btn-info">
        <span class="glyphicon glyphicon-search"></span>
    </button>
  </div>
</form>
  <div class="form-group">
 		<br><br><h3>Listado de Visitas</h3>
		<hr class="" color="DFDCDC">

  </div>
  <div class="form-group">
    <%call bus_visita()%>
  </div>
</div>
</body>
</html>
