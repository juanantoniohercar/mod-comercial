<!DOCTYPE html>
<html lang="es">
<head>
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Modificar Visita</title>
</head>
<body onload="nombre()">
	<%
	pag=7 %>
	<!--#include file="menu.asp"-->
	<!--#include file="funciones.asp"-->
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if
		ges_com_id=request.querystring("id")
		cliente_id=request.querystring("cliente")
		descripcion=request.querystring("des")
		fecha=request.querystring("fecha")
		hora=request.querystring("hora")
		call datos_visita(ges_com_id)


	 %>



<div class="container">
<form action="modificar_visita.asp" method="post" name="form_mod_vi" id="form_mod_vi" class="form-horizontal" role="form">
	<input type="hidden" class="form-control" id="modv_ges_com_id" name="modv_ges_com_id" value="<%=ges_com_id%>">
	<input type="hidden" class="form-control" id="modv_nomcli2" name="modv_nomcli2" value="<%=cli_nom_vi%>">
	<input type="hidden" class="form-control" id="modv_idcli" name="modv_idcli" value="<%=cliente_id%>">
	<div class="from-group pull-right col-lg-4">
		<label>Comercial Asignado</label>
		<select class="form-control" id="modv_com" name="modv_com" onchange=  "location.href='mod_visita.asp?id=' + form_mod_vi.modv_ges_com_id.value + '&contacto=' + form_mod_vi.modv_nomcto.options[form_mod_vi.modv_nomcto.selectedIndex].value + '&cliente=' + form_mod_vi.modv_idcli.value + '&com_asignado=' + form_mod_vi.modv_com.options[form_mod_vi.modv_com.selectedIndex].value + '&estado=' + form_mod_vi.modv_estado.options[form_mod_vi.modv_estado.selectedIndex].value + '&presupuesto=' + form_mod_vi.modv_pre.options[form_mod_vi.modv_pre.selectedIndex].value + '&fecha=' + form_mod_vi.modv_fecha.value + '&hora=' + form_mod_vi.modv_hora.value + '&des=' + form_mod_vi.modv_desc.value">

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
		<p class="form-control-static"><%=cli_nom_vi%></p>
	</div>
	<div class="form-group col-lg-5">
		<label>Telefono</label>
		<p class="form-control-static"><%=cli_tlf_vi%></p>
	</div>

	<div class="form-group col-lg-4">
		<label for="modv_nomcto">Nombre Contacto</label>
		<select class="form-control" id="modv_nomcto" name="modv_nomcto" onchange= "location.href='mod_visita.asp?id=' + form_mod_vi.modv_ges_com_id.value + '&contacto=' + form_mod_vi.modv_nomcto.options[form_mod_vi.modv_nomcto.selectedIndex].value + '&cliente=' + form_mod_vi.modv_idcli.value + '&com_asignado=' + form_mod_vi.modv_com.options[form_mod_vi.modv_com.selectedIndex].value + '&estado=' + form_mod_vi.modv_estado.options[form_mod_vi.modv_estado.selectedIndex].value + '&presupuesto=' + form_mod_vi.modv_pre.options[form_mod_vi.modv_pre.selectedIndex].value + '&fecha=' + form_mod_vi.modv_fecha.value + '&hora=' + form_mod_vi.modv_hora.value + '&des=' + form_mod_vi.modv_desc.value">
  				<option value=0>Selecciona un contacto</option>
  				<option value="<%=cto_id_vi%>" selected><%=cto_nom_vi%></option>
  				<%call select_cli_cto_vi()%>

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
		<input type="date" class="form-control" id="modv_fecha" name="modv_fecha" value="<%=fecha%>">
	</div>
	<div class="form-group col-lg-3">
		<label for="addv_hora">Hora Visita</label>
		<input type="time" class="form-control" id="modv_hora" name="modv_hora" value="<%=hora%>">
	</div>
	<div class="form-group col-lg-4">
		<label for="modv_estado">Estado</label>
		<select class="form-control" id="modv_estado" name="modv_estado" onchange=  "location.href='mod_visita.asp?id=' + form_mod_vi.modv_ges_com_id.value + '&contacto=' + form_mod_vi.modv_nomcto.options[form_mod_vi.modv_nomcto.selectedIndex].value + '&cliente=' + form_mod_vi.modv_idcli.value + '&com_asignado=' + form_mod_vi.modv_com.options[form_mod_vi.modv_com.selectedIndex].value + '&estado=' + form_mod_vi.modv_estado.options[form_mod_vi.modv_estado.selectedIndex].value + '&presupuesto=' + form_mod_vi.modv_pre.options[form_mod_vi.modv_pre.selectedIndex].value + '&fecha=' + form_mod_vi.modv_fecha.value + '&hora=' + form_mod_vi.modv_hora.value + '&des=' + form_mod_vi.modv_desc.value">
  				<option value=0>Selecciona un estado</option>
  				<option value="<%=gce_id_vi%>" selected><%=gce_nom_vi%></option>
  				<%call select_est_vi()%>
		</select>
	</div>
	<div class="form-group col-lg-4">
		<label for="modv_pre">Presupuesto</label>
		<select class="form-control" id="modv_pre" name="modv_pre" onchange=  "location.href='mod_visita.asp?id=' + form_mod_vi.modv_ges_com_id.value + '&contacto=' + form_mod_vi.modv_nomcto.options[form_mod_vi.modv_nomcto.selectedIndex].value + '&cliente=' + form_mod_vi.modv_idcli.value + '&com_asignado=' + form_mod_vi.modv_com.options[form_mod_vi.modv_com.selectedIndex].value + '&estado=' + form_mod_vi.modv_estado.options[form_mod_vi.modv_estado.selectedIndex].value + '&presupuesto=' + form_mod_vi.modv_pre.options[form_mod_vi.modv_pre.selectedIndex].value + '&fecha=' + form_mod_vi.modv_fecha.value + '&hora=' + form_mod_vi.modv_hora.value + '&des=' + form_mod_vi.modv_desc.value">
  				<option value=0>Selecciona un presupuesto</option>
  				<option value="<%=gc_pre_vi%>" selected><%=gc_pre_vi%></option>
  				<%call select_pre_vi()%>
		</select>
	</div>
	<div class="form-group col-lg-9">
		<label for="addv_desc">Descripci&oacuten</label>
		<textarea class="form-control" rows="4" id="modv_desc" name="modv_desc"><%=descripcion%></textarea>
	</div>
	<div class="form-group col-lg-8">
		<button type="submit" class="btn btn-primary" name="modv_visita">
    			<span class="glyphicon glyphicon-"></span>Modificar
			</button>
	</div>	

</form>
</div>
</body>
</html>