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
<body onload="nombre()">
	<!--#include file="menu.asp"-->
	<!--#include file="funciones.asp"-->


	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
<div class="container">
<form action="gest_comercial.asp" method="get" name="form_gest_com_buscli" id="form_gest_com_buscli" class="form-horizontal" role="form" >
<div class="form-group col-lg-4">
		<label for="nombre_cli">Cliente a buscar</label>
		<div class="form-inline ">
			<input type="text" class="form-control" id="bus_nomcli" maxlength="50" name="bus_nomcli">
			<button type="submit" class="btn btn-info">
    			<span class="glyphicon glyphicon-search"></span>
			</button>
			<button type="button" class="btn btn-success" onclick='window.location.href="nue_cli.asp"'>
    		<span class="glyphicon glyphicon-plus-sign"></span>
			</button>
		</div>
	</div>
</form>
<%call bus_cliente()%>
<form action="add_visita.asp" method="post" name="form_gest_com" id="form_gest_com" class="form-horizontal" role="form">
	<input type="hidden" class="form-control" id="bus_nomcli2" maxlength="50" name="bus_nomcli2" value="<%=nombre_cliente%>">
	<input type="hidden" class="form-control" id="bus_idcli2" maxlength="50" name="bus_idcli2" value="<%=cli_id%>">
	<input type="hidden" class="form-control" id="addv_gcid" maxlength="50" name="addv_gcid" value="<%=generar_cod("GES_COM","gc_id")%>">
	<div class="from-group pull-right col-lg-4">
		<label>Comercial Asignado</label>
		<select class="form-control" id="addv_com" name="addv_com" onchange= "location.href='gest_comercial.asp?bus_nomcli=' + form_gest_com.bus_nomcli2.value + '&contacto=' + form_gest_com.addv_nomcto.options[form_gest_com.addv_nomcto.selectedIndex].value + '&com_asignado=' + form_gest_com.addv_com.options[form_gest_com.addv_com.selectedIndex].value + '&estado=' + form_gest_com.addv_estado.options[form_gest_com.addv_estado.selectedIndex].value + '&presupuesto=' + form_gest_com.addv_pre.options[form_gest_com.addv_pre.selectedIndex].value + '&fecha=' + form_gest_com.addv_fecha.value + '&hora=' + form_gest_com.addv_hora.value">

				<optgroup label="Sesion iniciada por el comercial ">
  					<option value="<%=session("emp_id")%>"><%=session("nombre_comercial")%></option>
  				</optgroup>
  				<optgroup label="Otros Comerciales">
  				<% call select_com() %>
  				</optgroup>
			</select>
	</div>


	<div class="form-group col-lg-12">
 		<h3>Datos Del Cliente</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group col-lg-5">
		<label>Nombre de Cliente</label>
		<p class="form-control-static"><%=cli_nom%></p>
	</div>
	<div class="form-group col-lg-5">
		<label>Telefono</label>
		<p class="form-control-static"><%=cli_tlf%></p>
	</div>
	<div class="form-group col-lg-4">
		<label for="addv_nomcto">Nombre Contacto</label>
		<select class="form-control" id="addv_nomcto" name="addv_nomcto" onchange= "location.href='gest_comercial.asp?bus_nomcli=' + form_gest_com.bus_nomcli2.value + '&contacto=' + form_gest_com.addv_nomcto.options[form_gest_com.addv_nomcto.selectedIndex].value + '&com_asignado=' + form_gest_com.addv_com.options[form_gest_com.addv_com.selectedIndex].value + '&estado=' + form_gest_com.addv_estado.options[form_gest_com.addv_estado.selectedIndex].value + '&presupuesto=' + form_gest_com.addv_pre.options[form_gest_com.addv_pre.selectedIndex].value + '&fecha=' + form_gest_com.addv_fecha.value + '&hora=' + form_gest_com.addv_hora.value">
  				<option value=0>Selecciona un contacto</option>
  				<%call bus_cli_cto()%>
			</select>
	</div>
	<%call datos_cto_cli() %>
	<div class="form-group col-lg-3">
		<label>Telefono</label>
		<p class="form-control-static"><%=cto_tlf%></p>
	</div>
	<div class="form-group col-lg-4">
		<label>E-mail</label>
		<p class="form-control-static"><%=cto_mail%></p>
	</div>
	<div class="form-group col-lg-12">
 		<h3>Datos De La Visita</h3>
		<hr class="" color="DFDCDC">
	</div>

	<div class="form-group col-lg-3">
		<label for="addv_fecha">Fecha Visita</label>
		<input type="date" class="form-control" id="addv_fecha" name="addv_fecha" value="<%=request.querystring("fecha")%>">
	</div>
	<div class="form-group col-lg-3">
		<label for="addv_hora">Hora Visita</label>
		<input type="time" class="form-control" id="addv_hora" name="addv_hora" value="<%=request.querystring("hora")%>">
	</div>
	<div class="form-group col-lg-4">
		<label for="addv_estado">Estado</label>
		<select class="form-control" id="addv_estado" name="addv_estado" onchange= "location.href='gest_comercial.asp?bus_nomcli=' + form_gest_com.bus_nomcli2.value + '&contacto=' + form_gest_com.addv_nomcto.options[form_gest_com.addv_nomcto.selectedIndex].value + '&com_asignado=' + form_gest_com.addv_com.options[form_gest_com.addv_com.selectedIndex].value + '&estado=' + form_gest_com.addv_estado.options[form_gest_com.addv_estado.selectedIndex].value + '&presupuesto=' + form_gest_com.addv_pre.options[form_gest_com.addv_pre.selectedIndex].value + '&fecha=' + form_gest_com.addv_fecha.value + '&hora=' + form_gest_com.addv_hora.value">
  				<option value=0>Selecciona un estado</option>
  				<%call select_est()%>
		</select>
	</div>
	<div class="form-group col-lg-4">
		<label for="addv_pre">Presupuesto</label>
		<select class="form-control" id="addv_pre" name="addv_pre" onchange= "location.href='gest_comercial.asp?bus_nomcli=' + form_gest_com.bus_nomcli2.value + '&contacto=' + form_gest_com.addv_nomcto.options[form_gest_com.addv_nomcto.selectedIndex].value + '&com_asignado=' + form_gest_com.addv_com.options[form_gest_com.addv_com.selectedIndex].value + '&estado=' + form_gest_com.addv_estado.options[form_gest_com.addv_estado.selectedIndex].value + '&presupuesto=' + form_gest_com.addv_pre.options[form_gest_com.addv_pre.selectedIndex].value + '&fecha=' + form_gest_com.addv_fecha.value + '&hora=' + form_gest_com.addv_hora.value">
  				<option value=0>Selecciona un presupuesto</option>
  				<%call select_pre()%>
		</select>
	</div>
		
	
	<div class="form-group col-lg-9">
		<label for="addv_desc">Descripci&oacuten</label>
		<textarea class="form-control" rows="4" id="addv_desc" name="addv_desc"></textarea>
	</div>
	<div class="form-group col-lg-8">
		<button type="submit" class="btn btn-success" name="addv_visita">
    			<span class="glyphicon glyphicon-"></span>Guardar
			</button>
	</div>	

</form>
</div>
</body>
</html>
