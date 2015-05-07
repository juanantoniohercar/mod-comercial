
<%Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"%><!DOCTYPE html>
<html lang="es">
<head>
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <script type="text/javascript" src="js/funciones.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Nuevo Cliente</title>
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
	<% pag=1 %>
	<!--#include file="menu.asp"-->
	<!--#include file="funciones.asp"-->
	<% autorizar session("autorizacion") %>
	
<div class="container">
	<h3>Nuevo Cliente</h3>
	<hr color="DFDCDC">
	
<form action="ins_cli.asp" method="POST" name="form_nuevo_cli" class="form-horizontal" onsubmit="return validacioncli()">

	

	<div class="form-group col-lg-2">
		<label for="codigo_cliente">C&oacutedigo Cliente</label>
		<input type="text" class="form-control" id="codigo_cliente" name="codigo_cliente" placeholder="Codigo" maxlength="9" value="<%=generar_cod("CLI","cli_id")%>" readonly>
	</div> 
	<div class="form-group col-lg-2">
		<label for="cif">N. I. F. / C. I. F.</label>
		<input type="text" class="form-control" id="cif" placeholder="N. I. F. / C. I. F." maxlength="9" name="cif" onblur="comprobarNifCif(document.getElementById('cif').value)" value='<%=request.querystring("cif")%>' required>
	</div> 
	<div class="form-group col-lg-5">
		<label for="nombre">Nombre</label>
		<input type="text" class="form-control" id="nombre" placeholder="NOMBRE" maxlength="50" name="nombre" value='<%=request.querystring("nombre")%>' required>
	</div>
	<div class="form-group col-lg-6">
		<label for="direccion">Direcci&oacuten</label>
		<input type="text" class="form-control" id="direccion" placeholder="DIRECCIÓN" maxlength="100" name="direccion" value='<%=request.querystring("direccion")%>' required>
	</div>
	
	<div class="form-group col-lg-4">
		<label for="prov">Provincia</label>
		<select class="form-control" id="provincia" name="provincia" onchange="location.href='nue_cli.asp?provincia=' + form_nuevo_cli.provincia.options[form_nuevo_cli.provincia.selectedIndex].value + '&cif=' + form_nuevo_cli.cif.value + '&nombre=' + form_nuevo_cli.nombre.value + '&direccion=' + form_nuevo_cli.direccion.value + '&tlf_cli=' + form_nuevo_cli.tlf_cli.value" onselect="location.href='nue_cli.asp?provincia=' + form_nuevo_cli.provincia.options[form_nuevo_cli.provincia.selectedIndex].value + '&cif=' + form_nuevo_cli.cif.value + '&nombre=' + form_nuevo_cli.nombre.value + '&direccion=' + form_nuevo_cli.direccion.value + '&tlf_cli=' + form_nuevo_cli.tlf_cli.value">
  			<option value=0>Seleccione una provincia</option>
  			<%
	  			SQL_prov="select * from PROV order by prov_nom asc"
				set RS_prov=createobject("ADODB.Recordset")
				RS_prov.open SQL_prov,Conexion
				
				do while not RS_prov.eof
				prov_nom = RS_prov("prov_nom")
				prov_id = RS_prov("prov_id")
				p = cint(request.querystring("provincia"))
				pro=11
				    if p <> 0 then
				    	if p = prov_id then
					    response.write "<option value="&prov_id&"&prov_nom="&prov_nom&" selected>"&prov_nom&"</option>"
				        elseif p <> prov_id then
				        response.write "<option value="&prov_id&"&prov_nom="&prov_nom&">"&prov_nom&"</option>"
				        end if
					else
						if pro = prov_id then

						response.write "<option value="&prov_id&"&prov_nom="&prov_nom&" selected>"&prov_nom&"</option>"
						else
						response.write "<option value="&prov_id&"&prov_nom="&prov_nom&">"&prov_nom&"</option>"

						end if
					end if

				RS_prov.movenext
				loop
				RS_prov.close

			%>
		</select>
			
	</div>
	<div class="form-group col-lg-4">
		<label for="pob">Poblaci&oacuten</label>
		<select class="form-control" id="poblacion" name="poblacion" onchange="location.href='nue_cli.asp?poblacion=' + form_nuevo_cli.poblacion.options[form_nuevo_cli.poblacion.selectedIndex].value + '&provincia=' + form_nuevo_cli.provincia.options[form_nuevo_cli.provincia.selectedIndex].value + '&cif=' + form_nuevo_cli.cif.value + '&nombre=' + form_nuevo_cli.nombre.value + '&direccion=' + form_nuevo_cli.direccion.value + '&tlf_cli=' + form_nuevo_cli.tlf_cli.value">
			<option value=0>Seleccione una poblaci&oacuten</option>
			<% 
				if cint(request.querystring("provincia")) <> 0 then

			 		SQL_pob="select * from POB where pob_prov="&request.querystring("provincia")&" order by pob_nom asc"
			 		response.write SQL_pob
					set RS_pob=createobject("ADODB.Recordset")
					RS_pob.open SQL_pob,Conexion

					do while not RS_pob.eof
					pob_nombre=RS_pob("pob_nom")
					cadena=Server.URLEncode(pob_nombre)
					pob_id=RS_pob("pob_id")
					pob_id=cstr(pob_id)
					pob_prov=RS_pob("pob_prov")
					pp = request.querystring("poblacion")
					
					    if pp <> 0 then
					    	if pp = pob_id then
						    response.write "<option value="&pob_id&"&pob_nombre="&cadena&" selected>"&pob_nombre&"-</option>"
					        elseif pp <> pob_id then
					        response.write "<option value="&pob_id&"&pob_nombre="&cadena&">"&pob_nombre&"--</option>"
					        end if
						else
							response.write "<option value="&pob_id&"&pob_nombre="&cadena&">"&pob_nombre&"---</option>"
						
						end if
				
	  				RS_pob.movenext
	  				loop
	  				RS_pob.close
  				else
	  				SQL_pob="select * from POB where pob_prov=11 order by pob_nom asc"
					set RS_pob=createobject("ADODB.Recordset")
					RS_pob.open SQL_pob,Conexion

					do while not RS_pob.eof
					pob_nombre=RS_pob("pob_nom")
					cadena=Server.URLEncode(pob_nombre)
					pob_id=RS_pob("pob_id")
					pob_prov=RS_pob("pob_prov")
					'pp = cint(request.querystring("poblacion"))
					
					
					    ''if pp <> 0 then
					    	'if pp = pob_id then
						   '' response.write "<option value="&pob_id&"&pob_nombre="&cadena&" selected>"&pob_nombre&".</option>"
					       '' elseif pp <> pob_id then
					       '' response.write "<option value="&pob_id&"&pob_nombre="&cadena&">"&pob_nombre&"..</option>"
					      ''  end if
						'else
							response.write "<option value="&pob_id&"&pob_nombre="&cadena&">"&pob_nombre&"...</option>"
						
						'end if

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
 		<input type="tel" class="form-control" id="telefono" placeholder="Teléfono o móvil" maxlength="9" name="tlf_cli" value='<%=request.querystring("tlf_cli")%>' required>
 	</div>
 	<div class="form-group col-lg-12"><br>
 		<h3>Contacto</h3>
		<hr class="" color="DFDCDC">
		<button type="button" class="btn btn-success btn-xs" onclick="crear_div()">
    		<span class="glyphicon glyphicon-plus-sign"></span>
		</button>
		<button type="button" class="btn btn-danger btn-xs" onclick="remover_inputs()">
    		<span class="glyphicon glyphicon-minus-sign"></span>
		</button>
	</div>

	<input type="hidden" id="id_cto0" name="id_cto0" value="<%=generar_cod("CLI_CTO","cc_id")%>">
			<div class="form-group" id="div_nomcto" ></div>
	
	<div class="form-group"  id="div_submit">
		<div class="col-xs-6 col-sm-6 col-md-6">
		<button type="submit" name="crear_cliente" class="btn btn-primary btn-lg">
			<span>Crear</span>
		</button>
		</div>
		<div class="pull-right col-xs-6 col-sm-6 col-md-6">
		<button type="button" class="btn btn-warning btn-lg pull-right" onclick='window.location.href="inicio.asp"'>
    		<span class="">Volver</span>
		</button>
		</div>
		
	</div>
	
	<input type="hidden" name="contador" id="contador" >
	<script type="text/javascript">
	var cod = document.getElementById('id_cto0').value;
	document.getElementById('contador').value = cont;</script>
</form>
</div>
</body>
</html>