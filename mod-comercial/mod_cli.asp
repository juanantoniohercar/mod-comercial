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
 		<meta name="viewport" content="width=device-width, initial-scale=1.0">
 		<script type="text/javascript" src="js/funciones.js"></script>
 		<script src="jquery-2.1.3.min.js" type="text/javascript"></script>
	<title>Gesti&oacuten Comercia - Modificar Cliente</title>	
	</script>
	
</head>
<body>
	<script type="text/javascript">
		window.onload=function(){
			var pos=window.name || 0;
			window.scrollTo(0,pos);
		}
		window.onunload=function(){
			window.name=self.pageYOffset || (document.documentElement.scrollTop+document.body.scrollTop);
		}
	</script>
	<% pag=3 %>
	<!--#include file="menu.asp"-->
	<!--#include file="funciones.asp"-->
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
	<%
		id_cli=request.querystring("id")
		id_prov=request.querystring("provincia")
		 call datos_cli_cto(id_cli, "CLI")
		idprov = CStr(idprov)

		bus_dnicif=request.querystring("bus_dnicif")
		bus_nombre=request.querystring("bus_nombre")
		bus_dom=request.querystring("bus_dom")
		bus_localidad=request.querystring("bus_localidad")
		
	%>
<div class="container">
	<h3>Cliente a modificar</h3>
	<hr color="DFDCDC">
	<%
	 						if bus_dnicif <> "" then
	 					%>
	 							<input type="hidden" name="bus_dnicif" id="bus_dnicif" value="<%=request.querystring("bus_dnicif")%>">
	 					<%
	 							texto_prov="location.href='mod_cli.asp?provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&tlf_cto=' + form_modificar_cto.tlf_cto.value + '&email_cto=' + form_modificar_cto.email_cto.value + '&bus_dnicif=' + document.getElementById('bus_dnicif').value + '&mostrar=' + 1"

	 							texto_pob="location.href='mod_cli.asp?poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&tlf_cto=' + form_modificar_cto.tlf_cto.value + '&email_cto=' + form_modificar_cto.email_cto.value + '&bus_dnicif=' + document.getElementById('bus_dnicif').value"

	 							texto_cto="location.href='mod_cli.asp?contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&bus_dnicif=' + document.getElementById('bus_dnicif').value + '&mostrar=' + 0 "
	 						else
	 					%>
	 							<input type="hidden" name="bus_dnicif" id="bus_dnicif">
	 					<%
	 						end if 

	 						if bus_nombre <> "" then
	 					%>
	 							<input type="hidden" name="bus_nombre" id="bus_nombre" value="<%=request.querystring("bus_nombre")%>">
	 					<%
	 							texto_prov="location.href='mod_cli.asp?provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&tlf_cto=' + form_modificar_cto.tlf_cto.value + '&email_cto=' + form_modificar_cto.email_cto.value + '&bus_nombre=' + document.getElementById('bus_nombre').value + '&mostrar=' + 1"

	 							texto_pob="location.href='mod_cli.asp?poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&tlf_cto=' + form_modificar_cto.tlf_cto.value + '&email_cto=' + form_modificar_cto.email_cto.value + '&bus_nombre=' + document.getElementById('bus_nombre').value"

	 							texto_cto="location.href='mod_cli.asp?contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&bus_nombre=' + document.getElementById('bus_nombre').value + '&mostrar=' + 0 "
	 						else
	 					%>
	 							<input type="hidden" name="bus_nombre" id="bus_nombre">
	 					<%
	 						end if 
	 				
	 						if bus_dom <> "" then
	 					%>
	 							<input type="hidden" name="bus_dom" id="bus_dom" value="<%=request.querystring("bus_dom")%>">
	 					<%
	 							texto_prov="location.href='mod_cli.asp?provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&tlf_cto=' + form_modificar_cto.tlf_cto.value + '&email_cto=' + form_modificar_cto.email_cto.value + '&bus_dom=' + document.getElementById('bus_dom').value + '&mostrar=' + 1"

	 							texto_pob="location.href='mod_cli.asp?poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&tlf_cto=' + form_modificar_cto.tlf_cto.value + '&email_cto=' + form_modificar_cto.email_cto.value + '&bus_dom=' + document.getElementById('bus_dom').value"

	 							texto_cto="location.href='mod_cli.asp?contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&bus_dom=' + document.getElementById('bus_dom').value + '&mostrar=' + 0 "
	 						else
	 					%>
	 							<input type="hidden" name="bus_dom" id="bus_dom">

	 					<%
	 						end if 

	 						if bus_localidad <> "" then
	 					%>
	 							<input type="hidden" name="bus_localidad" id="bus_localidad" value="<%=request.querystring("bus_localidad")%>">
	 					<%
	 							texto_prov="location.href='mod_cli.asp?provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&tlf_cto=' + form_modificar_cto.tlf_cto.value + '&email_cto=' + form_modificar_cto.email_cto.value + '&bus_localidad=' + document.getElementById('bus_localidad').value + '&mostrar=' + 1"

	 							texto_pob="location.href='mod_cli.asp?poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&tlf_cto=' + form_modificar_cto.tlf_cto.value + '&email_cto=' + form_modificar_cto.email_cto.value + '&bus_localidad=' + document.getElementById('bus_localidad').value"

	 							texto_cto="location.href='mod_cli.asp?contacto=' + form_modificar_cto.nombre_cto.options[form_modificar_cto.nombre_cto.selectedIndex].value + '&poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&id=' + form_modificar_cli.codigo_cliente.value + '&cif=' + form_modificar_cli.cif.value + '&nombre=' + form_modificar_cli.nombre.value + '&direccion=' + form_modificar_cli.direccion.value + '&tlf_cli=' + form_modificar_cli.tlf_cli.value + '&bus_localidad=' + document.getElementById('bus_localidad').value + '&mostrar=' + 0 "
	 						else
	 					%>
	 							<input type="hidden" name="bus_localidad" id="bus_localidad">
	 					<%
	 						end if
	 					%>
<form action="modificar_cli.asp" method="POST" name="form_modificar_cli" class="form-horizontal" onsubmit="return validacioncli()" >

	<div class="form-group col-lg-2">
		<label for="codigo_cliente">C&oacutedigo Cliente</label>
		<input type="text" class="form-control" id="codigo_cliente" name="codigo_cliente" placeholder="Codigo" maxlength="9" value="<%=cod%>" readonly required>
	</div> 
	<div class="form-group col-lg-2">
		<label for="cif">N. I. F. / C. I. F.</label>
		<input type="text" class="form-control" id="cif" placeholder="N. I. F. / C. I. F." maxlength="9" name="cif" value="<%=dnicif%> " onblur="comprobarNifCif(document.getElementById('cif').value)" required>
	</div> 
	<div class="form-group col-lg-5">
		<label for="nombre">Nombre</label>
		<input type="text" class="form-control" id="nombre" placeholder="NOMBRE" maxlength="50" name="nombre" value="<%=nombre%>" required>
	</div>
	<div class="form-group col-lg-6">
		<label for="direccion">Direcci&oacuten</label>
		<input type="text" class="form-control" id="direccion" placeholder="DIRECCIÓN" maxlength="100" name="direccion" value="<%=direccion%>" required>
	</div>
	
	<div class="form-group col-lg-4">
		<label for="prov">Provincia</label>
		<select class="form-control" id="prov" name="provincia" onchange="<%=texto_prov%>">
 			<option value="" label="Seleciona una provincia"></option>
 			<option value="<%=idprov%>" selected><%=prov%></option>

 			<%
	 			SQL_prov="select * from PROV order by prov_nom asc"
				set RS_prov=createobject("ADODB.Recordset")
				RS_prov.open SQL_prov,Conexion
				
				do while not RS_prov.eof
				prov_nom = RS_prov("prov_nom")
				prov_id = RS_prov("prov_id")
				p = request.querystring("prov_nom")
				response.write p
				
				if prov <> prov_nom then
					if p = prov_nom then
						response.write "<option value="&prov_id&"&prov_nom="&prov_nom&" selected>"&prov_nom&"</option>"
					elseif p <>prov_nom then
						response.write "<option value="&prov_id&"&prov_nom="&prov_nom&">"&prov_nom&"</option>"
					end if
				else
					
				end if
				RS_prov.movenext
				loop
				RS_prov.close

			%>
		</select>
			
	</div>
	<div class="form-group col-lg-4">
		<label for="pob">Poblaci&oacuten</label>
		<select title= "Seleccione una poblacion" class="form-control" id="poblacion" name="poblacion" onchange="<%=texto_pob%>">
			<option value="" label="Seleciona una población"></option>
			
			<% 
				espacios=Server.URLEncode(pob)
				if request.querystring("mostrar") = "0" then
					response.write"<option value="&idpob&" selected>"&pob&"</option>"
				else
					idpob = ""
					pob = ""
				end if
				
				if request.querystring("provincia") <> "" then

		 		SQL_pob="select * from POB where pob_prov='"&request.querystring("provincia")&"'order by pob_nom asc"
				set RS_pob=createobject("ADODB.Recordset")
				RS_pob.open SQL_pob,Conexion

				do while not RS_pob.eof
				pob_nombre=RS_pob("pob_nom")
				cadena=Server.URLEncode(pob_nombre)
				pob_id=RS_pob("pob_id")
				pp = request.querystring("pob_nombre")
				
				if pob <> pob_nombre then
					if pp = pob_nombre then
						response.write "<option value="&pob_id&"&pob_nombre="&cadena&" selected>"&pob_nombre&"</option>"
					elseif pp <>pob_nombre then
						response.write "<option value="&pob_id&"&pob_nombre="&cadena&">"&pob_nombre&"</option>"
					end if	 
				
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
	<div class="form-group col-lg-2">
		<label for="codigo_postal">C&oacutedigo Postal</label>
		<input type="text" class="form-control" id="codigo_postal" name="cp" placeholder="CP" maxlength="5" value="<%=pob_cp%>" disabled>
	</div>
	
 	<div class="form-group col-lg-3">
 		<label for="telefono">Tel&eacutefono</label>
 		<input type="tel" class="form-control" id="telefono" placeholder="Teléfono o móvil" maxlength="9" name="tlf_cli" value="<%=tlf%>" required>
 	</div>
	<div class="form-group col-lg-9">
		<button type="submit" name="modificar_cliente" class="btn btn-primary btn-lg">
			<span>Modificar Cliente</span>
		</button>
		
	</div>
</form>
<div class="form-group col-lg-12"><br>
 		<h3>Contacto a modificar</h3>
		<hr class="" color="DFDCDC">
		<button type="button" class="btn btn-primary btn-xs" onclick="mostrar_btn_mod()">
 		<span class="glyphicon glyphicon-pencil"> Modificar Contacto</span>
		</button>
		<button type="button" class="btn btn-success btn-xs" onclick="mostrar_btn_add()">
 		<span class="glyphicon glyphicon-plus-sign"> Añadir contacto</span>
		</button>
		
</div>
<div id="modificar_contacto">
<form action="modificar_cto.asp" method="POST" name="form_modificar_cto" class="form-horizontal" >
		<input type="hidden" id="valor_idcli" maxlength="50" name="valor_idcli" value="<%=request.querystring("id")%>">
  		<input type="hidden" id="valor_idprov" maxlength="50" name="valor_idprov" value="<%=request.querystring("provincia")%>">
  		<input type="hidden" id="valor_idpob" maxlength="50" name="valor_idpob" value="<%=request.querystring("poblacion")%>">

		<div class="form-group col-lg-5">
		<label for="nombre_cto">Filtro por Nombre</label>
		<div class="form-inline">
		<select class="form-control" id="nombre_cto" name="nombre_cto" onchange= "<%=texto_cto%>">
			<option value=0>Seleccione un contacto</option>
			<%call select_cto()%>
		</select>
		</div>	
		</div>
	<% call datos_cto()%>
	
	<div class="form-group"></div>
	<div class="form-group col-lg-5">
		<label for="nombre_cto">Nombre</label>
		<input type="hidden" name="idcontacto" value="<%=id_cont%>">
	<input type="text" class="form-control" id="nombrecto" placeholder="NOMBRE Y APELLIDOS" maclength="45" name="nombrecto" value='<%=nombrecto%>'>
	</div>
	<div class="form-group col-lg-3">
		<label for="telefono_cto">Tel&eacutefono</label>
 		<input type="tel" class="form-control" id="telefono_cto" placeholder="Teléfono o móvil" maxlength="9" name="tlf_cto" value='<%=tlf_cto%>'>
	</div>
	<div class="form-group col-lg-4">
		<label for="email_cto">E-mail</label>
		<input type="email" class="form-control" id="email_cto" placeholder="email@ejemplo.com" name="email_cto" value='<%=email_cto%>'>
	</div>
	<div class="form-group">
	<div class="col-xs-6 col-sm-6 col-md-6">
		<button type="submit" name="modificar_contacto" class="btn btn-primary btn-lg">
			<span>Modificar Contacto</span>
		</button>
		
	</div>
	<div class="pull-right col-xs-6 col-sm-6 col-md-6">
      <button type="button" class="btn btn-warning pull-right btn-lg" onclick="atrasbus()">
          <span class="">Atras</span>
      </button>
    </div>
</div>
</form>
</div>

<div id="anadir_contacto" style="display: none;">
<form action="add_cto.asp" method="POST" name="form_add_cto" class="form-horizontal" >
		<input type="hidden" id="valor_idcli" maxlength="50" name="valor_idcli2" value="<%=request.querystring("id")%>">
  		<input type="hidden" id="valor_idprov" maxlength="50" name="valor_idprov2" value="<%=request.querystring("provincia")%>">
  		<input type="hidden" id="valor_idpob" maxlength="50" name="valor_idpob2" value="<%=request.querystring("poblacion")%>">
	<div class="form-group col-lg-5">
		<label for="nombre_cto">Nombre</label>
		<input type="hidden" name="idcontacto" value="<%=generar_cod("CLI_CTO","cc_id")%>">
		<input type="hidden" name="idcontacto_cli" value="<%=id_cli%>">
	<input type="text" class="form-control" placeholder="NOMBRE Y APELLIDOS" maclength="45" name="nombcto" required>
	</div>
	<div class="form-group col-lg-3">
		<label for="telefono_cto">Tel&eacutefono</label>
 		<input type="tel" class="form-control" placeholder="Teléfono o móvil" maxlength="9" name="telcto" >
	</div>
	<div class="form-group col-lg-4">
		<label for="email_cto">E-mail</label>
		<input type="email" class="form-control" placeholder="email@ejemplo.com" name="mailcto" >
	</div>
	<div class="form-group">
	<div class="col-xs-6 col-sm-6 col-md-6">
		<button type="submit" name="anadir_contacto"  value="Añadir Contacto" class="btn btn-success btn-lg">
			<span>Añadir Contacto</span>
		</button>
	</div>
    <div class="pull-right col-xs-6 col-sm-6 col-md-6">
      <button type="button" class="btn btn-warning pull-right btn-lg" onclick="atrasbus()" >
          <span class="">Atras</span>
      </button>
      
    </div>
  </div>
</form>
</div>

</div>

</body>
</html>