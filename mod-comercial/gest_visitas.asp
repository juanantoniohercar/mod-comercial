<!DOCTYPE html>
<html lang="es">
<head>
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Gestion Visitas</title>
</head>
<body>
   <%
  pag=6 %>
  <% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
	<!--#include file="menu.asp"-->
  <!--#include file="funciones.asp"-->
 
<div class="container">
<form action="gest_visitas.asp" method="POST" name="form_busq_visitas" id="form_busq_visitas" class="form-horizontal" role="form">
	<div class="form-group col-xs-12 col-sm-12 col-md-12">
 		<h3>Buscar Visitas</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group form-inline col-xs-12 col-sm-4 col-md-4">
		<label >Fecha: DESDE</label>
		<input type="date" class="form-control" id="busv_fecha1" name="busv_fecha1">
  </div>
  <div class="form-group form-inline col-xs-12 col-sm-4 col-md-4">
    <label> HASTA</label>
    <input type="date" class="form-control" id="busv_fecha2" name="busv_fecha2">
  </div>
  <div class="form-group form-inline col-xs-12 col-sm-5 col-md-4">
    <label for="estado">Estado</label>
    <select class="form-control" id="busv_estado" name="busv_estado">
          <option>Selecciona un estado</option>
          <% call select_est() %>
          <option value="3">Todas</option>
      </select>
  </div>
  <div class="form-group col-xs-12 col-sm-12 col-md-12">
    <button type="submit" class="btn btn-info">
        <span class="glyphicon glyphicon-search"></span>
    </button>
  </div>
  <div class="form-group col-xs-12 col-sm-12 col-md-12">
    <h3 class="">Listado de Visitas</h3>
    <hr class="" color="DFDCDC">
  </div>
</form>
  
  <!--<label ><font color="#6ABAD0">Finalizada</font></label>
  <label >/</label>-->

   
  <div class="form-group">
     <label class="col-xs-12 col-sm-12 col-lg-12" ><font color="#FF4E4E">Pendientes</font></label>
    <%call bus_visita()%>
  </div>
</div>
</body>
</html>
