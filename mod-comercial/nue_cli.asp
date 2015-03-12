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
	<!--#include file="menu.html"-->
	<!--#include file="connectionbd.asp"-->
	<!--#include file="funciones.asp"-->
	
<div class="container">
	<h3>Nuevo Cliente</h3>
	<hr color="DFDCDC">
<form action="ins_cli.asp" method="POST" name="form_nuevo_cli" class="form-horizontal" >

	

	<div class="form-group col-lg-2">
		<label for="codigo_cliente">C&oacutedigo Cliente</label>
		<input type="text" class="form-control" id="codigo_cliente" name="codigo_cliente" placeholder="Codigo" maxlength="9" value="<%=generar_cod("CLI","cli_id")%>" readonly>
	</div> 
	<div class="form-group col-lg-2">
		<label for="cif">C. I. F.</label>
		<input type="text" class="form-control" id="cif" placeholder="C. I. F." maxlength="9" name="cif" value='<%=request.querystring("cif")%>'>
	</div> 
	<div class="form-group col-lg-5">
		<label for="nombre">Nombre</label>
		<input type="text" class="form-control" id="nombre" placeholder="NOMBRE" maxlength="50" name="nombre" value='<%=request.querystring("nombre")%>'>
	</div>
	<div class="form-group col-lg-6">
		<label for="direccion">Direcci&oacuten</label>
		<input type="text" class="form-control" id="direccion" placeholder="DIRECCIÓN" maxlength="100" name="direccion" value='<%=request.querystring("direccion")%>'>
	</div>
	
	<div class="form-group col-lg-4">
		<label for="prov">Provincia</label>
		<select class="form-control" id="prov" name="provincia" onchange="location.href='nue_cli.asp?provincia=' + form_nuevo_cli.provincia.options[form_nuevo_cli.provincia.selectedIndex].value + '&cif=' + form_nuevo_cli.cif.value + '&nombre=' + form_nuevo_cli.nombre.value + '&direccion=' + form_nuevo_cli.direccion.value + '&tlf_cli=' + form_nuevo_cli.tlf_cli.value + '&nombre_cto=' + form_nuevo_cli.nombre_cto.value + '&tlf_cto=' + form_nuevo_cli.tlf_cto.value + '&email_cto=' + form_nuevo_cli.email_cto.value">
  			<option value=0>Seleccione una provincia</option>
  			<%
	  			SQL_prov="select * from PROV order by prov_nom asc"
				set RS_prov=createobject("ADODB.Recordset")
				RS_prov.open SQL_prov,Conexion
				
				do while not RS_prov.eof
				prov_nom = RS_prov("prov_nom")
				prov_id = RS_prov("prov_id")
				p = request.querystring("prov_nom")
				response.write p
				    if p <> "" then
				    	if p = prov_nom then
					    response.write "<option value="&prov_id&"&prov_nom="&prov_nom&" selected>"&prov_nom&"</option>"
				        elseif p <> prov_nom then
				        response.write "<option value="&prov_id&"&prov_nom="&prov_nom&">"&prov_nom&"</option>"
				        end if
					else
						response.write "<option value="&prov_id&"&prov_nom="&prov_nom&">"&prov_nom&"</option>"
					end if

				RS_prov.movenext
				loop
				RS_prov.close

			%>
		</select>
			
	</div>
	<div class="form-group col-lg-4">
		<label for="pob">Poblaci&oacuten</label>
		<select class="form-control" id="pob" name="poblacion" onchange="location.href='nue_cli.asp?poblacion=' + form_nuevo_cli.poblacion.options[form_nuevo_cli.poblacion.selectedIndex].value + '&provincia=' + form_nuevo_cli.provincia.options[form_nuevo_cli.provincia.selectedIndex].value + '&cif=' + form_nuevo_cli.cif.value + '&nombre=' + form_nuevo_cli.nombre.value + '&direccion=' + form_nuevo_cli.direccion.value + '&tlf_cli=' + form_nuevo_cli.tlf_cli.value + '&nombre_cto=' + form_nuevo_cli.nombre_cto.value + '&tlf_cto=' + form_nuevo_cli.tlf_cto.value + '&email_cto=' + form_nuevo_cli.email_cto.value">
			<option >Seleccione una poblaci&oacuten</option>
			<% 
				if request.querystring("provincia") <> "" then

		 		SQL_pob="select * from POB where pob_prov="&request.querystring("provincia")&"order by pob_nombre asc"
				set RS_pob=createobject("ADODB.Recordset")
				RS_pob.open SQL_pob,Conexion

				do while not RS_pob.eof
				pob_nombre=RS_pob("pob_nombre")
				cadena=Server.URLEncode(pob_nombre)
				pob_id=RS_pob("pob_id")
				pp = request.querystring("pob_nombre")
				
				    if pp <> "" then
				    	if pp = pob_nombre then
					    response.write "<option value="&pob_id&"&pob_nombre="&cadena&" selected>"&pob_nombre&"</option>"
				        elseif pp <> pob_nombre then
				        response.write "<option value="&pob_id&"&pob_nombre="&cadena&">"&pob_nombre&"</option>"
				        end if
					else
					response.write "<option value="&pob_id&"&pob_nombre="&cadena&" >"&pob_nombre&"</option>"
					end if
		
  				RS_pob.movenext
  				loop
  				RS_pob.close
  				end if

  			%>	
		</select>	
	</div>
			<%
				
				if request.querystring("poblacion") <> "" then

				
				SQL_cp= "select pob_cp from POB where pob_id="&request.querystring("poblacion")
				set RS_cp=createobject("ADODB.Recordset")
				RS_cp.open SQL_cp,Conexion

				do while not RS_cp.eof
				pob_cp=RS_cp("pob_cp")
				RS_cp.movenext
				loop
  				RS_cp.close
				end if	
			%>
	<div class="form-group col-lg-3">
		<label for="codigo_postal">C&oacutedigo Postal</label>
		<input type="text" class="form-control" id="codigo_postal" name="cp" placeholder="CP" maxlength="5"  value="<%=pob_cp%>" disabled>
	</div>
	
 	<div class="form-group col-lg-3">
 		<label for="telefono">Tel&eacutefono</label>
 		<input type="text" class="form-control" id="telefono" placeholder="Teléfono o móvil" maxlength="9" name="tlf_cli" value='<%=request.querystring("tlf_cli")%>'>
 	</div>
 	<div class="form-group col-lg-12"><br>
 		<h3>Contacto</h3>
		<hr class="" color="DFDCDC">
		<button type="button" class="btn btn-success btn-xs" onclick="">
    		<span class="glyphicon glyphicon-plus-sign"></span>
		</button>
	</div>
	<div class="form-group col-lg-5">
		<input type="hidden" value="<%=generar_cod("CLI_CTO","cto_id")%>" name="id_cto">
		<label for="nombre_cto">Nombre</label>
		<input type="text" class="form-control" id="nombre_cto" placeholder="NOMBRE Y APELLIDOS" maclength="45" name="nombre_cto" value='<%=request.querystring("nombre_cto")%>'>
	</div>
	<div class="form-group col-lg-3">
		<label for="telefono_cto">Tel&eacutefono</label>
 		<input type="text" class="form-control" id="telefono_cto" placeholder="Teléfono o móvil" maxlength="9" name="tlf_cto" value='<%=request.querystring("tlf_cto")%>'>
	</div>
	<div class="form-group col-lg-4">
		<label for="email_cto">E-mail</label>
		<input type="email" class="form-control" id="email_cto" placeholder="email@ejemplo.com" name="email_cto" value='<%=request.querystring("email_cto")%>'>
	</div>
	<div class="form-group col-lg-2">
		<input type="submit" name="crear_cliente" value="Crear" class="btn btn-primary btn-lg">
	</div>
</form>


</div>
</body>
</html>
