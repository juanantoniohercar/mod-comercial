<%Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"%>
<!--#include file="connectionbd.asp"-->
<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
	<link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
    <link href="css/login.css" rel="stylesheet" type="txt/css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<script src="jquery-2.1.3.min.js" type="text/javascript"></script>
	<link href="link.css" rel="stylesheet" type="txt/css">
	<script type="text/javascript">
		$(document).ready(function() {
			setTimeout(function() {
				$(".contenedor").fadeOut(1000);
			},1500);
		});

		function comprobarbtn(){

			
    		var respuesta = confirm("¿Deseas eleminar este registro?");
    		if (respuesta) {
        		window.location.replace("borrar_cli.asp");
        		return true;
    		} else {
        		alert("Registro no eliminado.");
        		return false;
    		}
    		
		}
		function abrir_cli(){
			document.form_listar.submit();
		}

	
	</script>
</head>
<body>
<%

	'***************declaracion de variables***********************'
	Dim consulta,objRS,nombre_usuario,password, SQL_idcomercial, SQL_comerciales, com_nom, com_id, SQL_bus_cli


	'****************Fin declaracion de variables********************'

	'funcion para autorizar el inicio de sesion'
	
	function iniciosesion ()
  		nombre_usuario=request.form("username")
  		password=request.form("password")

		consulta = "select USR_ID, USR_LOG, USR_PWD from USR"
		set objRS = conexion.Execute(consulta)

   		while (not objRS.Eof) 
       		if objRS("USR_LOG") = trim(nombre_usuario) and objRS("USR_PWD") = trim(password) then
       		'si todo es ok nos envia a otra pagina
       		session("emp_id")=objRS("USR_ID")
       		session	("nombre_comercial")=trim(request.form("username"))
       		session("autorizacion")=1
       		response.redirect("inicio.asp")
       		response.end
       		else
       			objRS.MoveNext
       		end if
   		wend
   		session("autorizacion")=-1
       	alert_formularios "USUARIO O CONTRASE&NtildeA NO V&AacuteLIDOS","warning"

   		set objRS = nothing 
   		iniciosesion = false
	end function

	'metodo para autorizar entrar a una pagina si se ha iniciado sesión o no
	sub autorizar(autorizacion)
		if autorizacion <> 1 then response.redirect("Default.asp") end if
	end sub

	'funcion alert para cuando para informar que se realizo correctamente la acción
	sub alert_formularios(texto,tipo_alert)
	%>
		<div class="notifications alert alert-<%=tipo_alert%> contenedor">
		<button type="button" class="close" data-dismiss="alert"></button>
		<strong><%=texto%></strong>
		</div>
	<%
	end sub

	'funcion para generar codigo automático para una tabla
	function generar_cod(tabla,id)
		dim SQL_consultaid
		SQL_consultaid = "select * from " & tabla
		set RS_consultaid = createobject("ADODB.Recordset")
		RS_consultaid.open SQL_consultaid,Conexion

		do while not RS_consultaid.eof
			identificador = RS_consultaid(id)
			RS_consultaid.movenext
		loop
			RS_consultaid.close
		
	 	cod = identificador + 1
	 	response.write cod

	
	end function

	
	'funcion para insertar cliente en la base de datos
	function insertar_cliente(id_cli,cli_cif,cli_nom,cli_prov,cli_pob,cli_dir,cli_tlf)

		
		dim ins_cli
		if id_cli = "" or cli_cif = "" or cli_nom = "" or cli_prov = "" or cli_pob = "" or cli_dir = "" or cli_tlf = "" then
			alert_formularios "FALTAN DATOS POR INTRODUCIR","warning"
		else
			ins_cli = "insert into CLI (cli_id, cli_cif, cli_nom, cli_pro, cli_pob, cli_dir, cli_tlf) values ("&id_cli&",'"&cli_cif&"','"&cli_nom&"',"&cli_prov&","&cli_pob&",'"&cli_dir&"','"&cli_tlf&"')"
			
			'Si hay un error en la base de datos permite continuar con la ejecucion del script
			on error resume next
			Conexion.Execute(ins_cli)
			'Si error es nivel distinto de cero nos mostrara mensaje de error, si el nivel es cero continua con introducir los datos del contacto
			if err <> 0 then
				alert_formularios "ERROR! No se pueden introducir los datos en la base de datos","danger"
			else
				alert_formularios "DATOS INTRODUCIDOS CORRECTAMENTE","success"
			end if		
		end if
		
	end function

	'Insertar contactos de nuevo cliente
	function insertar_contactos(id_cto,id_cli,nom_cto,tlf_cto,correo_cto)
		dim ins_cto
		
			
			ins_cto = "insert into CLI_CTO (cc_id, cc_cli, cc_nom, cc_tel, cc_ema) values ("&id_cto&","&id_cli&",'"&nom_cto&"','"&tlf_cto&"','"&correo_cto&"')"
			
				if nom_cto = "" and tlf_cto = "" and correo_cto = ""  then
					'alert_formularios "FALTAN DATOS POR INTRODUCIR","warning"
				else
					on error resume next
					Conexion.Execute(ins_cto)
				end if
				
				'Si nivel de error distinto de cero mostrar mensaje de error, si nivel indicara que se han introducido los datos correctamente
				if err <> 0 then
						alert_formularios "ERROR! No se pueden introducir los datos de los contactos en la base de datos","danger"		
				else
					alert_formularios "CONTACTOS INTRODUCIDOS CORRECTAMENTE","success"
					 
				end if
					
		
	end function

	'Crea la tabla con los resultado de busqueda cliente'
	function creartabla_bus(rs,dnicif,nombre,domicilio,localidad)
	%>
	
		<table border=0 class="table ">
		<thead>
			<tr>
				<!--<th>Nombre</th>
				<th>Telefono</th>
				<th>Domicilio</th>
				<th>OPCIONES</th>-->
			</tr>
		</thead>
 	
	<%
	do while not rs.eof
		
		cli_id = rs("cli_id")
		cli_nombre = rs("cli_nom")
		cli_dir = rs("cli_dir")
		cli_tlf = rs("cli_tlf")
		cli_prov = rs("cli_pro")
		cli_pob = rs("cli_pob")
		
		rs.movenext
	%>
		<tbody>

			<tr>

				<td width=100% onclick="window.location.href='abrir_cli.asp?id=' + document.getElementById('id<%=cli_id%>').value + '&provincia=' + document.getElementById('provincia<%=cli_id%>').value + '&poblacion=' + document.getElementById('poblacion<%=cli_id%>').value + '&mostrar=' + document.getElementById('mostrar<%=cli_id%>').value">
						<input type="hidden" name="id" id="id<%=cli_id%>" value="<%=cli_id%>">
						<input type="hidden" name="provincia" id="provincia<%=cli_id%>" value="<%=cli_prov%>">
						<input type="hidden" name="poblacion" id="poblacion<%=cli_id%>" value="<%=cli_pob%>">
	 					<input type="hidden" name="mostrar" id="mostrar<%=cli_id%>" value="0">
					
					<div class="col-xs-6 col-sm-6 col-md-6 ">
			
						<p class="pull-left"><%=cli_nombre%></p>

					</div>
					<div class="col-xs-3 col-sm-3 col-md-3">
						
						<p class="pull-left"><%=cli_tlf%></p>

					</div>
					<div class="col-xs-3 col-sm-3 col-md-3">
						
						<div class="pull-right">
					<form name="form_modificar" action="mod_cli.asp" method="get">
						<input type="hidden" name="id" id="id" value="<%=cli_id%>">
						<input type="hidden" name="provincia" id="provincia" value="<%=cli_prov%>">
						<input type="hidden" name="poblacion" id="poblacion" value="<%=cli_pob%>">
	 					<input type="hidden" name="mostrar" id="mostrar" value="0">
	 					<%
	 						if dnicif <> "" then
	 					%>
	 						<input type="hidden" name="bus_dnicif" id="bus_dnicif" value="<%=dnicif%>">
	 					<%

	 						end if 

	 						if nombre <> "" then
	 					%>
	 						<input type="hidden" name="bus_nombre" id="bus_nombre" value="<%=nombre%>">
	 					<%

	 						end if 
	 				
	 						if domicilio <> "" then
	 					%>
	 						<input type="hidden" name="bus_dom" id="bus_dom" value="<%=domicilio%>">
	 					<%

	 						end if 

	 						if localidad <> "" then
	 					%>
	 							<input type="hidden" name="bus_localidad" id="bus_localidad" value="<%=localidad%>">
	 					<%
	 						end if
	 					%>
						<button type="submit" class="btn btn-primary btn-xs">
	 						<span class="glyphicon glyphicon-pencil"></span>
						</button>
					</form>
					</div>
					</div>
					<div class="col-xs-12 col-sm-12 col-md-12">
					</div>
					<div class="col-xs-12 col-sm-4 col-md-4">
						<p class=""><%=cli_dir%></p>
					</div>
				</td>
				
				</td>
			</tr>

		
	<%
	loop
	%>
		</tbody>	
		</table>
	
<%

		rs.close

	end function

	'funcion que hace la consulta de cliente a modificar y vista de cliente'
	public SQL_cli, cod, dnicif, nombre, direccion, provincia, pobalcion, cp, tlf, SQL_cto, nombre_cto, tlf_cto, email_cto, id_cont
	function datos_cli_cto(id, tabla)
	
	SQL_cli="select * from "&tabla&" where cli_id='"&id&"'"
	SQL_cto="select CLI_CTO.cc_id, CLI_CTO.cc_nom, CLI_CTO.cc_tel, CLI_CTO.cc_ema from CLI, CLI_CTO where CLI.cli_id=CLI_CTO.cc_cli and CLI.cli_id='"&id&"'"
	set RS_cli = createobject("ADODB.Recordset")
	set RS_cto = createobject("ADODB.Recordset")
	RS_cli.open SQL_cli, Conexion
	RS_cto.open SQL_cto, Conexion

	'Recorremos en la base de datos para recuperar los datos del cliente'
	do while not RS_cli.eof
		cod=RS_cli("cli_id")
		dnicif=RS_cli("cli_cif")
		nombre=RS_cli("cli_nom")
		direccion=RS_cli("cli_dir")
		tlf=RS_cli("cli_tlf")
		
		RS_cli.movenext
	loop
		RS_cli.close

		datos_prov_pob(id)
	

	end function



	'funcions que recupera el dato del nombre de la provincia que tiene seleccionado el cliente'
	public SQL_prov, prov, idprov, SQL_pob, pob, idpob, cpostal
	function datos_prov_pob(id)
	SQL_prov= "select PROV.prov_nom, PROV.prov_id from CLI, PROV where CLI.cli_pro=PROV.prov_id and cli_id='"&id&"'"
	SQL_pob= "select * from CLI, POB where CLI.cli_pob=POB.pob_id AND CLI.cli_id='"&id&"'"
	set RS_prov= createobject("ADODB.Recordset")
	set RS_pob= createobject("ADODB.Recordset")
	RS_prov.open SQL_prov,Conexion
	RS_pob.open SQL_pob,Conexion

	'recorremos PROV y guardamos en una variable'
	do while not RS_prov.eof
	prov= RS_prov("prov_nom")
	idprov= RS_prov("prov_id")

	RS_prov.movenext
	loop
	RS_prov.close

	'recorremos POB y guardamos en variable
	do while not RS_pob.eof
	pob= RS_pob("pob_nom")
	cpostal=RS_pob("pob_cp")
	idpob = RS_pob("pob_id")

	RS_pob.movenext
	loop'
	RS_pob.close

	'Recorremos Los contactos que tienes el cliente que estamos buscando y lo guardamos'


	end function

	'Recuperar los datos del contacto para abrirlo sin que se pueda modificar'
	function creartabla_mostarcto()

	set RS_cto = createobject("ADODB.Recordset")
	RS_cto.open SQL_cto, Conexion

		%>
	
		<table border=0 class="table table-striped">
		<thead>
			<tr>
				
			</tr>
		</thead>
 	
	<%
	'Recorremos en la base de datos para recuperar los datos de los contactos de ese cliente'
	do while not RS_cto.eof
		nombre_cto=RS_cto("cc_nom")
		tlf_cto=RS_cto("cc_tel")
		email_cto=RS_cto("cc_ema")

		RS_cto.movenext
	%>
		<tbody>

			<tr>
				<td width=100%>
					<div class="col-xs-12 col-sm-4 col-md-4 ">
			
						<p class="pull-left"><%=nombre_cto%></p>

					</div>
					<div class="col-xs-5 col-sm-4 col-md-4">
						
						<p class="pull-left"><%=tlf_cto%></p>

					</div>
					<div class="col-xs-6 col-sm-4 col-md-4">
						<p class="pull-left"><%=email_cto%></p>
					</div>


				</td>
				
			</tr>

		
	<%
	loop
	%>
		</tbody>	
		</table>
	
<%
		RS_cto.close

	end function


	'Funcion para cargar los datos del contacto que vamos a modificar'
	public id_contacto
	function select_cto()

	set RS_cto = createobject("ADODB.Recordset")
	RS_cto.open SQL_cto, Conexion

	do while not RS_cto.eof
		id_contacto= RS_cto("cc_id")
		nombre_cto=RS_cto("cc_nom")
		nombre_cto_esp=Server.URLEncode(nombre_cto)
		ppp = request.querystring("nombre_cto")

			if id_contacto <> "" then
				if ppp = nombre_cto then
					response.write "<option value="&id_contacto&"&nombre_cto="&nombre_cto_esp&" selected>"&nombre_cto&"</option>"
				   	elseif ppp <> nombre_cto then
				        response.write "<option value="&id_contacto&"&nombre_cto="&nombre_cto_esp&" >"&nombre_cto&"</option>"
				    end if
				else
					response.write "<option value="&id_contacto&"&nombre_cto="&nombre_cto_esp&">"&nombre_cto&"</option>"
				end if

		RS_cto.movenext
	loop
		RS_cto.close
	end function

	'Funcion para obtener los datos del contacto segun el seleccionado'
	public nombrecto
	function datos_cto()
	if request.querystring("contacto") <> "" then

				SQL_datos_cto= "select cc_id, cc_nom, cc_tel, cc_ema from CLI_CTO where cc_id="&request.querystring("contacto")
				set RS_datos_cto=createobject("ADODB.Recordset")
				RS_datos_cto.open SQL_datos_cto,Conexion

				do while not RS_datos_cto.eof
				id_cont=RS_datos_cto("cc_id")
				nombrecto=RS_datos_cto("cc_nom")
				tlf_cto=RS_datos_cto("cc_tel")
				email_cto=RS_datos_cto("cc_ema")
				RS_datos_cto.movenext
				loop
 				RS_datos_cto.close				
 				end if	


	end function	

	'Funcion modificar cliente'
	function modificar_cli(id_cli, cli_cif,cli_nom,cli_prov,cli_pob,cli_dir,cli_tlf)

	
	if id_cli = "" or cli_cif = "" or cli_nom = "" or cli_prov = "" or cli_pob = "" or cli_dir = "" or cli_tlf = "" then
			alert_formularios "FALTAN DATOS POR INTRODUCIR","warning"
		else
			SQL_update_cli="update CLI set cli_cif='"&cli_cif&"', cli_nom='"&cli_nom&"', cli_pro='"&cli_prov&"', cli_pob='"&cli_pob&"', cli_dir='"&cli_dir&"', cli_tlf='"&cli_tlf&"' where cli_id='"&id_cli&"'"
			
			'Si hay un error en la base de datos permite continuar con la ejecucion del script
			on error resume next
			Conexion.Execute(SQL_update_cli)
			'Si error es nivel distinto de cero nos mostrara mensaje de error, si el nivel es cero continua con introducir los datos del contacto
			if err <> 0 then
				alert_formularios "ERROR! No se pueden modificar los datos en la base de datos","danger"
			else
				on error resume next
				Conexion.Execute(SQL_update_cli)
				'Si nivel de error distinto de cero mostrar mensaje de error, si nivel indicara que se han introducido los datos correctamente
				if err <> 0 then
					alert_formularios "ERROR! No se pueden modificar los datos del cliente en la base de datos","danger"		
				else

					alert_formularios "DATOS MODIFICADOS CORRECTAMENTE","success"
					
				end if 
			end if		
		end if
		%>
			<script language="JavaScript">
				var id = <%=id_cli%>;
				var provincia = <%=cli_prov%>; 
  				var poblacion = <%=cli_pob%>;
  				var mostrar = "0";
  				function redireccionar() {
    				setTimeout("location.href='mod_cli.asp?id=' + id + '&provincia=' + provincia + '&poblacion=' + poblacion + '&mostrar=' + mostrar", 2500);

  				}
  					redireccionar();
  			</script>
		<%

	end function

	'funcion modifica contacto '
	function modificar_cto(mod_cto_id,mod_cto_nom,mod_cto_tlf,mod_cto_mail,id_cli,idprov,idpob)

	if mod_cto_nom = "" or mod_cto_tlf = "" or mod_cto_mail = "" then
			alert_formularios "FALTAN DATOS POR INTRODUCIR","warning"
		else
			SQL_update_cto="update CLI_CTO set cc_nom='"&mod_cto_nom&"', cc_tel='"&mod_cto_tlf&"', cc_ema='"&mod_cto_mail&"' where cc_id='"&mod_cto_id&"'"

			'Si hay un error en la base de datos permite continuar con la ejecucion del script
			on error resume next
			Conexion.Execute(SQL_update_cto)
			'Si error es nivel distinto de cero nos mostrara mensaje de error, si el nivel es cero continua con introducir los datos del contacto
			if err <> 0 then
				alert_formularios "ERROR! No se pueden modificar los datos en la base de datos","danger"
			else
				on error resume next
				Conexion.Execute(SQL_update_cto)
				'Si nivel de error distinto de cero mostrar mensaje de error, si nivel indicara que se han introducido los datos correctamente
				if err <> 0 then
					alert_formularios "ERROR! No se pueden modificar los datos del contacto en la base de datos","danger"		
				else

					alert_formularios "DATOS MODIFICADOS CORRECTAMENTE","success"
				end if 
			end if		
		end if
		%>
		<script language="JavaScript">
				var id = <%=id_cli%>;
				var provincia = <%=idprov%>; 
  				var poblacion = <%=idpob%>;
  				var mostrar = "0";
  				alert(id);
  				alert(provincia);
  				alert(poblacion);
  				alert(mostrar);
  			function redireccionar() {
    			setTimeout("location.href='mod_cli.asp?id=' + id + '&provincia=' + provincia + '&poblacion=' + poblacion + '&mostrar=' + mostrar", 2500);
  			}
  						
  			redireccionar();
  		</script>
		<%

	end function

	'funcion que añade un contacto a un cliente ya creado'
	function add_cto(add_cto_id,add_cto_cli,add_cto_nom,add_cto_tlf,add_cto_mail,id_cli,idprov,idpob)

		SQL_insert_cto="insert into CLI_CTO (cc_id, cc_cli, cc_nom, cc_tel, cc_ema) values ("&add_cto_id&","&add_cto_cli&",'"&add_cto_nom&"','"&add_cto_tlf&"','"&add_cto_mail&"')"
		if add_cto_nom = "" and add_cto_tlf = "" and add_cto_mail = ""  then
			
		else
			'Si hay un error en la base de datos permite continuar con la ejecucion del script
			on error resume next
			Conexion.Execute(SQL_insert_cto)
			'Si error es nivel distinto de cero nos mostrara mensaje de error, si el nivel es cero continua con introducir los datos del contacto
			if err <> 0 then
				alert_formularios "ERROR! No se pueden introducir los datos en la base de datos","danger"
			else

				alert_formularios "DATOS INTRODUCIDOS CORRECTAMENTE","success"
				
			end if		
		end if

		%>
		<script language="JavaScript">
				var id = <%=id_cli%>;
				var provincia = <%=idprov%>; 
  				var poblacion = <%=idpob%>;
  				var mostrar = "0";
  			function redireccionar() {
    			setTimeout("location.href='mod_cli.asp?id=' + id + '&provincia=' + provincia + '&poblacion=' + poblacion + '&mostrar=' + mostrar", 2500);
  			}
  						
  			redireccionar();
  		</script>
		<%

	end function

	'funcion eliminar clientes'
	function eliminar_cli(id)

	SQL_delete_cto_cli="delete from CLI_CTO where cc_cli='"&id&"'" 
	SQL_delete_cli="delete from CLI where cli_id='"&id&"'" 
	
	on error resume next 
	Conexion.Execute(SQL_delete_cto_cli)
	Conexion.Execute(SQL_delete_cli)

	if err <> 0 then
		alert_formularios "ERROR! No se pudo eliminar el cliente y sus contactos","danger"
	else

		alert_formularios "DATOS ELIMINADOS CORRECTAMENTE","success"
				
	end if		

%>
		<script language="JavaScript">
  			function redireccionar() {
    			setTimeout('location.href="bus_cli.asp"', 2500);

  			}
  						
  			redireccionar();
  		</script>
  <%
	end function

	'funcion rellenar select asignacion de empleados'
	function select_com()
		SQL_comerciales="select * from USR where usr_log not like '"&session("nombre_comercial")&"'"
		set RS_comerciales=createobject("ADODB.Recordset")
		RS_comerciales.open SQL_comerciales,Conexion

		do while not RS_comerciales.eof
		com_id=RS_comerciales("usr_id")
		com_nom=RS_comerciales("usr_log")
		com_nom_esp=Server.URLEncode(com_nom)
		cadena = request.querystring("com_nom")

					if com_id <> "" then
						if cadena = com_nom then
							response.write "<option value="&com_id&"&com_nom="&com_nom_esp&" selected>"&com_nom&"</option>"
				   			elseif cadena <> com_nom then
				        		response.write "<option value="&com_id&"&com_nom="&com_nom_esp&" >"&com_nom&"</option>"
				   		 	end if
						else
							response.write "<option value="&com_id&"&com_nom="&com_nom_esp&">"&com_nom&"</option>"
						end if

			


		RS_comerciales.movenext
		loop
		RS_comerciales.close

	end function

	'funcions busqueda clientes para gestion comercial'
	public cli_id, cli_nom, cli_tlf, cto_id, cto_cli, cto_nom, cto_tlf, cto_mail, nombre_cliente, visible
	function bus_cliente()
	
		nombre_cliente=request.querystring("bus_nomcli")
		
		if nombre_cliente <> "" then
		response.write"<option value=''>Selecciona un cliente</option>"
		SQL_bus_cli="select * from CLI where cli_nom like '%"&nombre_cliente&"%'"
		set RS_bus_cli=createobject("ADODB.Recordset")
		RS_bus_cli.open SQL_bus_cli,Conexion
		do while not RS_bus_cli.eof
			cli_id=RS_bus_cli("cli_id")
			cli_nom=RS_bus_cli("cli_nom")
			cli_tlf=RS_bus_cli("cli_tlf")

			cli_nom_esp=Server.URLEncode(cli_nom)
			cadena = request.querystring("cliente_nom")
			
			if cli_id <> "" then
						if cadena = cli_nom then
							response.write "<option value="&cli_id&"&cliente_nom="&cli_nom_esp&"&tlf="&cli_tlf&" selected>"&cli_nom&"</option>"
				   			elseif cadena <> cli_nom then
				        		response.write "<option value="&cli_id&"&cliente_nom="&cli_nom_esp&"&tlf="&cli_tlf&" >"&cli_nom&"</option>"
				   		 	end if
						else
							response.write "<option value="&cli_id&"&cliente_nom="&cli_nom_esp&"&tlf="&cli_tlf&">"&cli_nom&"</option>"
						end if


		RS_bus_cli.movenext
		loop
		RS_bus_cli.close
		end if
	end function

	'funcion para la busqueda del contacto para el cliente que vamos a realizar la visita'
	function bus_cli_cto()
				cliente_id=request.querystring("cliente")
				response.write"<option value=0>Selecciona un contacto</option>"
				if cliente_id <> "" then
					
					SQL_bus_cli_cto="select * from CLI_CTO where cc_cli='"&cliente_id&"'"
					set RS_bus_cli_cto= createobject("ADODB.Recordset")
					RS_bus_cli_cto.open SQL_bus_cli_cto,Conexion
					
					do while not RS_bus_cli_cto.eof
						cto_id=RS_bus_cli_cto("cc_id")
						cto_cli=RS_bus_cli_cto("cc_cli")
						cto_nom=RS_bus_cli_cto("cc_nom")
						cto_nom_esp=Server.URLEncode(cto_nom)
						cadena = request.querystring("cto_nom")

						if cto_id <> "" then
							if cadena = cto_nom then
								response.write "<option value="&cto_id&"&cto_nom="&cto_nom_esp&" selected>"&cto_nom&"</option>"
					   			elseif cadena <> cto_nom then
					        		response.write "<option value="&cto_id&"&cto_nom="&cto_nom_esp&" >"&cto_nom&"</option>"
					   		 	end if
							else
								response.write "<option value="&cto_id&"&cto_nom="&cto_nom_esp&">"&cto_nom&"</option>"
							end if
						
						

					RS_bus_cli_cto.movenext
					loop
					RS_bus_cli_cto.close
				end if
	end function

	'funcion para obtener los datos del contacto seleccionado'
	function datos_cto_cli()
				if request.querystring("contacto") <> "" then

				SQL_datos_cli_cto= "select cc_tel, cc_ema from CLI_CTO where cc_id="&request.querystring("contacto")
				set RS_datos_cli_cto=createobject("ADODB.Recordset")
				RS_datos_cli_cto.open SQL_datos_cli_cto,Conexion

				do while not RS_datos_cli_cto.eof
				cto_tlf=RS_datos_cli_cto("cc_tel")
				cto_mail=RS_datos_cli_cto("cc_ema")
				RS_datos_cli_cto.movenext
				loop
 				RS_datos_cli_cto.close				
 				end if

	end function

	'funcion para obtener los datos de la tabla ESTADO de la base de datos'
	function select_est()
		SQL_estado="select * from GES_COM_EST"
		set RS_estado=createobject("ADODB.Recordset")
		RS_estado.open SQL_estado,Conexion

		do while not RS_estado.eof
			est_id=RS_estado("gce_id")
			est_nom	= RS_estado("gce_nom")
			est_nom_esp=Server.URLEncode(est_nom)
			cadena = request.querystring("est_nom")
			estide=2
			if cadena <> "" then
				if cadena = est_nom then
					response.write "<option value="&est_id&"&est_nom="&est_nom_esp&" selected>"&est_nom&"</option>"
				   	elseif cadena <> est_nom then
				        response.write "<option value="&est_id&"&est_nom="&est_nom_esp&" >"&est_nom&"</option>"
				end if
			else
				if estide = est_id then
					response.write "<option value="&est_id&"&est_nom="&est_nom_esp&" selected>"&est_nom&"</option>"
				else
					response.write "<option value="&est_id&"&est_nom="&est_nom_esp&">"&est_nom&"</option>"
				end if
			end if

		RS_estado.movenext
		loop
		RS_estado.close



	end function	

	'funcion para buscar los presupuestos
	function select_pre()
		cliente_id=request.querystring("id")
		SQL_pre="select * from PRE where pre_cli='"&cliente_id&"'"
				set RS_pre= createobject("ADODB.Recordset")
				RS_pre.open SQL_pre,Conexion
				
				do while not RS_pre.eof
					pre_id=RS_pre("pre_id")
					pre_cli=RS_pre("pre_cli")
					cadena = request.querystring("presupuesto")
					pre_id=cstr(pre_id)
					if pre_id <> "" then
						if cadena = pre_id then
							response.write "<option value="&pre_id&" selected>"&pre_id&"</option>"
				   			elseif cadena <> pre_id then
				        		response.write "<option value="&pre_id&" >"&pre_id&"</option>"
				   		 	end if
						else
							response.write "<option value="&pre_id&">"&pre_id&"</option>"
						end if
					
					

				RS_pre.movenext
				loop
				RS_pre.close

	end function

	'funcion para insertar datos en la tabla ges_com

	function insert_gescom(gc_id,gc_hora,gc_fec,gc_est,gc_com,gc_pre,gc_cli,gc_cli_cto,gc_des,gc_usu)
		' Presupuesto vacío
		if gc_pre = "" then
			gc_pre = "NULL"
		end if
		SQL_insert_gescom="insert into GES_COM (gc_id, gc_fec, gc_est, gc_com, gc_pre, gc_cli, gc_cli_con, gc_des, gc_usu) values ("&gc_id&",'"&gc_fec&" "&gc_hora&"',"&gc_est&","&gc_com&","&gc_pre&","&gc_cli&","&gc_cli_cto&",'"&gc_des&"',"&gc_usu&")"
		
		on error resume next
		Conexion.Execute(SQL_insert_gescom)
			'Si error es nivel distinto de cero nos mostrara mensaje de error, sino no mostrara mensaje de que se ha introducido correctamente el los datos en la base de datos
			if err <> 0 then
				alert_formularios "ERROR! No se pueden introducir los datos en la base de datos","danger"
			else
				alert_formularios "Datos de visita intrducidos correctamente","success"
			end if	


	end function

	'funcion que realiza la busqueda de las visitas'
	
	function bus_visita()
		visita_fecha1=request.form("busv_fecha1")
		visita_fecha2=request.form("busv_fecha2")
		cad_estado=request.form("busv_estado")
		cad_estado=split(cad_estado, "&")
		on error resume next
		visita_estado=cad_estado(0)
		visita_estado=cstr(visita_estado)
		comercial=session("emp_id")
		
		if visita_fecha1 = "" AND visita_fecha2 = "" then
			SQL_visitas="select GES_COM.gc_pre, CLI.cli_id, CLI_CTO.cc_id, GES_COM.gc_id, GES_COM_EST.gce_nom, GES_COM.gc_fec, CLI.cli_nom, CLI.cli_dir, CLI_CTO.cc_nom, CLI_CTO.cc_tel, CLI_CTO.cc_ema, GES_COM.gc_des from GES_COM_EST, GES_COM, CLI, CLI_CTO, USR where GES_COM.gc_usu=USR.usr_id and GES_COM_EST.gce_id=GES_COM.gc_est and GES_COM.gc_usu="&comercial&" and GES_COM_EST.gce_id=2 and GES_COM.gc_cli=CLI.cli_id and GES_COM.gc_cli_con=CLI_CTO.cc_id ORDER BY GES_COM.gc_fec ASC"
				set RS_visitas=createobject("ADODB.Recordset")
				RS_visitas.open SQL_visitas,Conexion

			tabla_visitas(RS_visitas)

		end if

		if visita_estado = 3 then
		visita_fecha1=CDate(request.form("busv_fecha1"))
		visita_fecha2=CDate(request.form("busv_fecha2"))
			SQL_visitas="select GES_COM.gc_pre, CLI.cli_id, CLI_CTO.cc_id, GES_COM.gc_id, GES_COM_EST.gce_nom, GES_COM.gc_fec, CLI.cli_nom, CLI.cli_dir, CLI_CTO.cc_nom, CLI_CTO.cc_tel, CLI_CTO.cc_ema, GES_COM.gc_des from GES_COM_EST, GES_COM, CLI, CLI_CTO, USR where GES_COM.gc_usu=USR.usr_id and GES_COM_EST.gce_id=GES_COM.gc_est and USR.usr_id="&comercial&" and GES_COM.gc_cli=CLI.cli_id and GES_COM.gc_cli_con=CLI_CTO.cc_id and GES_COM.gc_fec between '"&visita_fecha1&"' and '"&visita_fecha2&"' ORDER BY GES_COM.gc_fec ASC"
				set RS_visitas=createobject("ADODB.Recordset")
				RS_visitas.open SQL_visitas,Conexion

			tabla_visitas(RS_visitas)

			
		else
		visita_fecha1=CDate(request.form("busv_fecha1"))
		visita_fecha2=CDate(request.form("busv_fecha2"))
			SQL_visitas="select GES_COM.gc_pre, CLI.cli_id, CLI_CTO.cc_id, GES_COM.gc_id, GES_COM_EST.gce_nom, GES_COM.gc_fec, CLI.cli_nom, CLI.cli_dir, CLI_CTO.cc_nom, CLI_CTO.cc_tel, CLI_CTO.cc_ema, GES_COM.gc_des from GES_COM_EST, GES_COM, CLI, CLI_CTO, USR where GES_COM.gc_usu=USR.usr_id and GES_COM_EST.gce_id=GES_COM.gc_est and USR.usr_id="&comercial&" and GES_COM_EST.gce_id="&visita_estado&" and GES_COM.gc_cli=CLI.cli_id and GES_COM.gc_cli_con=CLI_CTO.cc_id and GES_COM.gc_fec between '"&visita_fecha1&"' and '"&visita_fecha2&"' ORDER BY GES_COM.gc_fec ASC"
				set RS_visitas=createobject("ADODB.Recordset")
				RS_visitas.open SQL_visitas,Conexion
		
			tabla_visitas(RS_visitas)
			
		end if
		
	end function

	'funcion que nos crea la tabla on los resultado de busqueda de las visitas'
	function tabla_visitas(rs)
	
	%>
	
	
		<table border=0 class="table">
			<thead>
  				<tr>
          			
  				</tr>
  			</thead>
  	<%
  			

  		do while not rs.eof
  			cli_id=rs("cli_id")
  			cto_id=rs("cc_id")
  			gc_id=rs("gc_id")
  			gce_nom=rs("gce_nom")
  			gc_fec=rs("gc_fec")
  			cli_nom=rs("cli_nom")
  			cli_dir=rs("cli_dir")
  			cto_nom=rs("cc_nom")
  			cto_tlf=rs("cc_tel")
  			cto_mail=rs("cc_ema")
  			gc_des=rs("gc_des")
  			gc_pre=rs("gc_pre")

  			rs.movenext
  			
  		
  	%>
  		<tbody>
  			<%
  			if gce_nom= "Pendiente" then
  			fec=FormatDateTime(gc_fec,2)
  			hora=FormatDateTime(gc_fec,4)
  			if hora= "00:00" then
  				hora=""
  			end if
  			%>

	  			<tr class="danger" onclick="window.location.href='mod_visita.asp?id=' + document.getElementById('visita<%=gc_id%>').value + '&contacto=' + document.getElementById('cto<%=cto_id%>').value + '&cliente=' + document.getElementById('cli<%=cli_id%>').value + '&des=' + document.getElementById('modv_desc<%=gc_id%>').value + '&fecha=' + document.getElementById('modv_fecha<%=gc_id%>').value + '&hora=' + document.getElementById('modv_hora<%=gc_id%>').value + '&presupuesto=' + document.getElementById('pre<%=gc_pre%>').value">
	  				
	  				<input type="hidden" id="visita<%=gc_id%>" name="visita<%=gc_id%>" value="<%=gc_id%>">
	  				<input type="hidden" id="modv_fecha<%=gc_id%>" name="modv_fecha<%=gc_id%>" value="<%=fec%>">
	  				<input type="hidden" id="modv_hora<%=gc_id%>" name="modv_hora<%=gc_id%>" value="<%=hora%>">
	  				<input type="hidden" id="cli<%=cli_id%>" name="cli<%=cli_id%>" value="<%=cli_id%>">
	  				<input type="hidden" id="cto<%=cto_id%>" name="cto<%=cto_id%>" value="<%=cto_id%>">
	  				<input type="hidden" id="pre<%=gc_pre%>" name="pre<%=gc_pre%>" value="<%=gc_pre%>">
	  				<textarea style="display:none;" class="form-control" rows="4" id="modv_desc<%=gc_id%>" name="modv_desc<%=gc_id%>"><%=gc_des%></textarea>

	  				<td width=100%> 
	  					<div class="col-xs-6 col-sm-6 col-md-6 ">
				
							<p class="pull-left"><%=cli_nom%> (<%=cli_dir%>)</p>

						</div>
						<div class="col-xs-6 col-sm-6 col-md-6">
							
							<p class="pull-right"><%=fec%> &nbsp <%=hora%></p>

						</div>
						<div class="col-xs-12 col-sm-12 col-md-12">
						</div>
						<div class="col-xs-12 col-sm-4 col-md-4">
							<p class=""><%=cto_nom%></p>
						</div>
						<div class="col-xs-4 col-sm-4 col-md-4">
							<p class=""><%=cto_tlf%></p>
						</div>
						<div class="col-xs-4 col-sm-4 col-md-4">
							<p class=""><%=cto_mail%></p>
						</div>
						<div class="col-xs-12 col-sm-12 col-md-12">
							
							<p><%=gc_des%></p>
						</div>
					</td>
	  			</tr>
  			<%
  			else
  			fec=FormatDateTime(gc_fec,2)
  			hora=FormatDateTime(gc_fec,4)
  			if hora= "00:00" then
  				hora=""
  			end if
  			%>
  				<tr class="" onclick="window.location.href='mod_visita.asp?id=' + document.getElementById('visita<%=gc_id%>').value + '&contacto=' + document.getElementById('cto<%=cto_id%>').value + '&cliente=' + document.getElementById('cli<%=cli_id%>').value + '&des=' + document.getElementById('modv_desc<%=gc_id%>').value + '&fecha=' + document.getElementById('modv_fecha<%=gc_id%>').value + '&hora=' + document.getElementById('modv_hora<%=gc_id%>').value + '&presupuesto=' + document.getElementById('pre<%=gc_pre%>').value">
  					<input type="hidden" id="visita<%=gc_id%>" name="visita<%=gc_id%>" value="<%=gc_id%>">
	  				<input type="hidden" id="modv_fecha<%=gc_id%>" name="modv_fecha<%=gc_id%>" value="<%=fec%>">
	  				<input type="hidden" id="modv_hora<%=gc_id%>" name="modv_hora<%=gc_id%>" value="<%=hora%>">
	  				<input type="hidden" id="cli<%=cli_id%>" name="cli<%=cli_id%>" value="<%=cli_id%>">
	  				<input type="hidden" id="cto<%=cto_id%>" name="cto<%=cto_id%>" value="<%=cto_id%>">
	  				<input type="hidden" id="pre<%=gc_pre%>" name="pre<%=gc_pre%>" value="<%=gc_pre%>">
	  				<textarea style="display:none;" class="form-control" rows="4" id="modv_desc<%=gc_id%>" name="modv_desc<%=gc_id%>"><%=gc_des%></textarea>

  				<td width=100%> 
	  					<div class="col-xs-6 col-sm-6 col-md-6 ">
				
							<p class="pull-left"><%=cli_nom%> (<%=cli_dir%>)</p>

						</div>
						<div class="col-xs-6 col-sm-6 col-md-6">
							
							<p class="pull-right"><%=fec%> &nbsp <%=hora%></p>

						</div>
						<div class="col-xs-12 col-sm-12 col-md-12">
						</div>
						<div class="col-xs-12 col-sm-4 col-md-4">
							<p class=""><%=cto_nom%></p>
						</div>
						<div class="col-xs-4 col-sm-4 col-md-4">
							<p class=""><%=cto_tlf%></p>
						</div>
						<div class="col-xs-4 col-sm-4 col-md-4">
							<p class=""><%=cto_mail%></p>
						</div>
						<div class="col-xs-12 col-sm-12 col-md-12">
							
							<p><%=gc_des%></p>
						</div>
					</td>
  			</tr>
  			<%
  			end if
  			
  	loop
  	%>
		</tbody>	
		</table>
	<%
	rs.close
	end function	

	'funcion que carga los datos de la visita a modificar'
	public cto_id_vi,gce_id_vi, gce_nom_vi, gc_fec_vi, gc_hora_vi, cli_nom_vi, cli_tlf_vi, cto_nom_vi, cto_tlf_vi, cto_mail_vi, gc_des_vi, gc_pre_vi, cli_id_vi
	function datos_visita(id)
		if gc_pre_vi = "0" then
		SQL_datos_visita="select CLI.cli_id, CLI_CTO.cc_id, CLI.cli_tlf, GES_COM.gc_pre, GES_COM.gc_id, GES_COM_EST.gce_id, GES_COM_EST.gce_nom, GES_COM.gc_fec, CLI.cli_nom, CLI.cli_dir, CLI_CTO.cc_nom, CLI_CTO.cc_tel, CLI_CTO.cc_ema, GES_COM.gc_des, PRE.pre_id from GES_COM_EST, GES_COM, CLI, CLI_CTO, USR, PRE where GES_COM.gc_com=USR.usr_id and GES_COM_EST.gce_id=GES_COM.gc_est and USR.usr_id='"&session("emp_id")&"' and GES_COM.gc_cli=CLI.cli_id and GES_COM.gc_cli_con=CLI_CTO.cc_id and PRE.pre_id=GES_COM.gc_pre and gc_id='"&id&"'"
			response.write SQL_datos_visita
		set RS_datos_visita=createobject("ADODB.Recordset")
		RS_datos_visita.open SQL_datos_visita,Conexion

		do while not RS_datos_visita.eof
			cli_id_vi=RS_datos_visita("cli_id")
			cto_id_vi=RS_datos_visita("cc_id")
			gce_id_vi=RS_datos_visita("gce_id")
			gce_nom_vi=RS_datos_visita("gce_nom")
  			gc_fec_vi=RS_datos_visita("gc_fec")
  			cli_nom_vi=RS_datos_visita("cli_nom")
  			cli_tlf_vi=RS_datos_visita("cli_tlf")
  			cto_nom_vi=RS_datos_visita("cc_nom")
  			cto_tlf_vi=RS_datos_visita("cc_tel")
  			cto_mail_vi=RS_datos_visita("cc_ema")
  			gc_des_vi=RS_datos_visita("gc_des")
  			gc_pre_vi=RS_datos_visita("gc_pre")

		RS_datos_visita.movenext
		loop
		RS_datos_visita.close
		else
			SQL_datos_visita="select distinct CLI.cli_id, CLI_CTO.cc_id, CLI.cli_tlf, GES_COM.gc_pre, GES_COM.gc_id, GES_COM_EST.gce_id, GES_COM_EST.gce_nom, GES_COM.gc_fec, CLI.cli_nom, CLI.cli_dir, CLI_CTO.cc_nom, CLI_CTO.cc_tel, CLI_CTO.cc_ema, GES_COM.gc_des from GES_COM_EST, GES_COM, CLI, CLI_CTO, USR, PRE where GES_COM.gc_com=USR.usr_id and GES_COM_EST.gce_id=GES_COM.gc_est and USR.usr_id='"&session("emp_id")&"' and GES_COM.gc_cli=CLI.cli_id and GES_COM.gc_cli_con=CLI_CTO.cc_id and gc_id='"&id&"'"
		set RS_datos_visita=createobject("ADODB.Recordset")
		RS_datos_visita.open SQL_datos_visita,Conexion

		do while not RS_datos_visita.eof
			cli_id_vi=RS_datos_visita("cli_id")
			cto_id_vi=RS_datos_visita("cc_id")
			gce_id_vi=RS_datos_visita("gce_id")
			gce_nom_vi=RS_datos_visita("gce_nom")
  			gc_fec_vi=RS_datos_visita("gc_fec")
  			cli_nom_vi=RS_datos_visita("cli_nom")
  			cli_tlf_vi=RS_datos_visita("cli_tlf")
  			cto_nom_vi=RS_datos_visita("cc_nom")
  			cto_tlf_vi=RS_datos_visita("cc_tel")
  			cto_mail_vi=RS_datos_visita("cc_ema")
  			gc_des_vi=RS_datos_visita("gc_des")
  			gc_pre_vi=RS_datos_visita("gc_pre")

		RS_datos_visita.movenext
		loop
		RS_datos_visita.close
		end if


	end function
	'funcions para cargar los datos del contacto en el modificar visitas'

	function select_cli_cto_vi()
				
				SQL_cli_cto_vi="select * from CLI_CTO where cc_cli="&cli_id_vi
				set RS_cli_cto_vi=createobject("ADODB.Recordset")
				RS_cli_cto_vi.open SQL_cli_cto_vi,Conexion
				
				do while not RS_cli_cto_vi.eof
				cto_nom = RS_cli_cto_vi("cc_nom")
				cto_id = RS_cli_cto_vi("cc_id")
				p = request.querystring("cto_nom")
				
				
				if cto_nom_vi <> cto_nom then
					if p = cto_nom then
						response.write "<option value="&cto_id&"&cto_nom="&cto_nom&" selected>"&cto_nom&"</option>"
					elseif p <>cto_nom then
						response.write "<option value="&cto_id&"&cto_nom="&cto_nom&">"&cto_nom&"</option>"
					end if
				else
					
				end if
				RS_cli_cto_vi.movenext
				loop
				RS_cli_cto_vi.close

	end function

	'funcion para cargar el estado en el modificar visitas.'
	function select_est_vi()
		SQL_estado="select * from GES_COM_EST"
		set RS_estado=createobject("ADODB.Recordset")
		RS_estado.open SQL_estado,Conexion

		do while not RS_estado.eof
			est_id=RS_estado("gce_id")
			est_nom	= RS_estado("gce_nom")
			est_nom_esp=Server.URLEncode(est_nom)
			cadena = request.querystring("est_nom")

			if gce_nom_vi <> est_nom then
						if cadena = est_nom then
							response.write "<option value="&est_id&"&est_nom="&est_nom_esp&" selected>"&est_nom&"</option>"
				   			elseif cadena <> est_nom then
				        		response.write "<option value="&est_id&"&est_nom="&est_nom_esp&" >"&est_nom&"</option>"
				   		 	end if
						else
							
						end if

		RS_estado.movenext
		loop
		RS_estado.close
	end function

	'funcion para cargar el presupuesto en el modificar visitas'
	function select_pre_vi()

		SQL_pre="select distinct pre_id from PRE where pre_cli="&cli_id_vi
		set RS_pre= createobject("ADODB.Recordset")
		RS_pre.open SQL_pre,Conexion
				
		do while not RS_pre.eof
			pre_id=RS_pre("pre_id")
			cadena = request.querystring("presupuesto")
			id_cstr=cstr(pre_id)

			if gc_pre_vi <> pre_id then
				if cadena = id_cstr then
					response.write "<option value="&pre_id&" selected>"&id_cstr&"</option>"
		   			elseif cadena <> id_cstr then
		        		response.write "<option value="&pre_id&" >"&id_cstr&"</option>"
		   	 	end if
			
			end if
					
					

				RS_pre.movenext
				loop
				RS_pre.close

	end function

	'funcion para modificar la visita'
	function mod_visita(gc_id,gc_hora,gc_fec,gc_est,gc_com,gc_pre,gc_cli,gc_cli_cto,gc_des,gc_usu)
	
	if gc_id = "" or gc_fec = "" or gc_est = "" or gc_com = "" or gc_cli = "" or gc_cli_cto = "" then
			alert_formularios "FALTAN DATOS POR INTRODUCIR","warning"
		else
		
			' Presupuesto Vacío
			if gc_pre = "" then
				gc_pre = "NULL"
				
			end if
			
			SQL_update_visita="update GES_COM set gc_fec='"&gc_fec&" "&gc_hora&"', gc_est="&gc_est&", gc_com="&gc_com&", gc_pre="&gc_pre&", gc_cli="&gc_cli&", gc_cli_con="&gc_cli_cto&", gc_des='"&gc_des&"', gc_usu="&gc_usu&" where gc_id="&gc_id

			'Si hay un error en la base de datos permite continuar con la ejecucion del script
			on error resume next
			Conexion.Execute(SQL_update_visita)
			'Si error es nivel distinto de cero nos mostrara mensaje de error, si el nivel es cero continua con introducir los datos del contacto
			if err <> 0 then
				alert_formularios "ERROR! No se pueden modificar los datos en la base de datos","danger"
			else
				on error resume next
				Conexion.Execute(SQL_update_visita)
				'Si nivel de error distinto de cero mostrar mensaje de error, si nivel indicara que se han introducido los datos correctamente
				if err <> 0 then
					alert_formularios "ERROR! No se pueden modificar los datos de la visita en la base de datos","danger"		
				else

					alert_formularios "DATOS MODIFICADOS CORRECTAMENTE","success"
					
				end if 
			end if		
		end if
		%>
			<script language="JavaScript">
  				function redireccionar() {
    				setTimeout('history.back()', 2500);

  				}
  					redireccionar();
  			</script>
		<%



	end function


	'función para buscar el presupuesto'
	function bus_pre()
	cliente_id=request.querystring("cliente")
	cad_busq=request.querystring("bus_pres")

	if cad_busq = "" then
		SQL_pre="select * from PRE where pre_cli="&cliente_id
		set RS_pre= createobject("ADODB.Recordset")
		RS_pre.open SQL_pre,Conexion
	%>
	
	
		<table border=0 class="table">
			<thead>
  				
  			</thead>
  	<%
				
				do while not RS_pre.eof
					pre_id=RS_pre("pre_id")
					pre_cli=RS_pre("pre_cli")
					pre_des=RS_pre("pre_des")
					cadena = request.querystring("presupuesto")
					pre_id=cstr(pre_id)
  				RS_pre.movenext
  	%>
  		<tbody>
  			
  			<%

  			if num = "1" then
  			%>
  				<tr class="active" onclick="window.location.href='gest_comercial.asp?bus_nomcli=' + form_busq_pre.bus_nomcli1.value + '&cliente=' + form_busq_pre.id1.value + '&cliente_nom=' + form_busq_pre.cliente1.value + '&tlf=' + form_busq_pre.tlf1.value + '&contacto=' + form_busq_pre.contacto1.value + '&cto_nom=' + form_busq_pre.cto_nom1.value + '&com_asignado=' + form_busq_pre.com_asignado1.value + '&estado=' + form_busq_pre.estado1.value + '&est_nom=' + form_busq_pre.est_nom1.value + '&fecha=' + form_busq_pre.fecha1.value + '&hora=' + form_busq_pre.hora1.value + '&presupuesto=' + document.getElementById('pre<%=pre_id%>').value + '&des=' + form_busq_pre.desc.value">

  					<input type="hidden" id="pre<%=pre_id%>" name="pre<%=pre_id%>" value="<%=pre_id%>">
  				<td width=100%> 
  					<div class="col-xs-6 col-sm-6 col-md-6 ">
			
						<p class="pull-left"><%=pre_id%></p>

					</div>
					<div class="col-xs-6 col-sm-6 col-md-6">
						
						<p class="pull-right"><%=pre_cli%></p>

					</div>
					<div class="col-xs-12 col-sm-12 col-md-12">
					</div>
					<div class="col-xs-12 col-sm-4 col-md-4">
						<p class=""><%=pre_des%></p>
					</div>
				</td>
  			</tr>
  	
  			<%
  			else 
  			%>
  				<tr class="active" onclick="window.location.href='mod_visita.asp?id=' + form_busq_pre.id_visita.value + '&cliente=' + form_busq_pre.id1.value + '&cliente_nom=' + form_busq_pre.cliente1.value + '&tlf=' + form_busq_pre.tlf1.value + '&contacto=' + form_busq_pre.contacto1.value + '&cto_nom=' + form_busq_pre.cto_nom1.value + '&com_asignado=' + form_busq_pre.com_asignado1.value + '&estado=' + form_busq_pre.estado1.value + '&est_nom=' + form_busq_pre.est_nom1.value + '&fecha=' + form_busq_pre.fecha1.value + '&hora=' + form_busq_pre.hora1.value + '&presupuesto=' + document.getElementById('pre<%=pre_id%>').value + '&des=' + form_busq_pre.desc.value">

  				<input type="hidden" id="pre<%=pre_id%>" name="pre<%=pre_id%>" value="<%=pre_id%>">
  				<td width=100%> 
  					<div class="col-xs-6 col-sm-6 col-md-6 ">
			
						<p class="pull-left"><%=pre_id%></p>

					</div>
					<div class="col-xs-6 col-sm-6 col-md-6">
						
						<p class="pull-right"><%=pre_cli%></p>

					</div>
					<div class="col-xs-12 col-sm-12 col-md-12">
					</div>
					<div class="col-xs-12 col-sm-4 col-md-4">
						<p class=""><%=pre_des%></p>
					</div>
				</td>
  			</tr>

  			<%
  			end if	
  	
				loop
	%>
  		</tbody>
  		</table>
  	<%		
				RS_pre.close
	else
				SQL_pre="select * from PRE where pre_cli= '"&cliente_id&"' and pre_id like '%"&cad_busq&"%'"
				set RS_pre= createobject("ADODB.Recordset")
				RS_pre.open SQL_pre,Conexion
	%>
	
	
		<table border=0 class="table">
			<thead>
  				<tr>
          			
  				</tr>
  			</thead>
  	<%
				
				do while not RS_pre.eof
					pre_id=RS_pre("pre_id")
					pre_cli=RS_pre("pre_cli")
					pre_des=RS_pre("pre_des")
					cadena = request.querystring("presupuesto")
					pre_id=cstr(pre_id)
  				RS_pre.movenext
  	%>
  		<tbody>
  			

  			<%

  			if num = "1" then
  			%>
  				<tr class="active" onclick="window.location.href='gest_comercial.asp?bus_nomcli=' + form_busq_pre.bus_nomcli1.value + '&cliente=' + form_busq_pre.id1.value + '&cliente_nom=' + form_busq_pre.cliente1.value + '&tlf=' + form_busq_pre.tlf1.value + '&contacto=' + form_busq_pre.contacto1.value + '&cto_nom=' + form_busq_pre.cto_nom1.value + '&com_asignado=' + form_busq_pre.com_asignado1.value + '&estado=' + form_busq_pre.estado1.value + '&est_nom=' + form_busq_pre.est_nom1.value + '&fecha=' + form_busq_pre.fecha1.value + '&hora=' + form_busq_pre.hora1.value + '&presupuesto=' + document.getElementById('pre<%=pre_id%>').value + '&des=' + form_busq_pre.desc.value">

  					<input type="hidden" id="pre<%=pre_id%>" name="pre<%=pre_id%>" value="<%=pre_id%>">
  				<td width=100%> 
  					<div class="col-xs-6 col-sm-6 col-md-6 ">
			
						<p class="pull-left"><%=pre_id%></p>

					</div>
					<div class="col-xs-6 col-sm-6 col-md-6">
						
						<p class="pull-right"><%=pre_cli%></p>

					</div>
					<div class="col-xs-12 col-sm-12 col-md-12">
					</div>
					<div class="col-xs-12 col-sm-4 col-md-4">
						<p class=""><%=pre_des%></p>
					</div>
				</td>
  			</tr>
  		
  			<%
  			else 
  			%>
  				<tr class="active" onclick="window.location.href='mod_visita.asp?id=' + form_busq_pre.id_visita.value + '&cliente=' + form_busq_pre.id1.value + '&cliente_nom=' + form_busq_pre.cliente1.value + '&tlf=' + form_busq_pre.tlf1.value + '&contacto=' + form_busq_pre.contacto1.value + '&cto_nom=' + form_busq_pre.cto_nom1.value + '&com_asignado=' + form_busq_pre.com_asignado1.value + '&estado=' + form_busq_pre.estado1.value + '&est_nom=' + form_busq_pre.est_nom1.value + '&fecha=' + form_busq_pre.fecha1.value + '&hora=' + form_busq_pre.hora1.value + '&presupuesto=' + document.getElementById('pre<%=pre_id%>').value + '&des=' + form_busq_pre.desc.value">

  				<input type="hidden" id="pre<%=pre_id%>" name="pre<%=pre_id%>" value="<%=pre_id%>">
  				<td width=100%> 
  					<div class="col-xs-6 col-sm-6 col-md-6 ">
			
						<p class="pull-left"><%=pre_id%></p>

					</div>
					<div class="col-xs-6 col-sm-6 col-md-6">
						
						<p class="pull-right"><%=pre_cli%></p>

					</div>
					<div class="col-xs-12 col-sm-12 col-md-12">
					</div>
					<div class="col-xs-12 col-sm-4 col-md-4">
						<p class=""><%=pre_des%></p>
					</div>
				</td>
  			</tr>
  		
  			<%
  			end if	
  					
				loop
	%>
  		</tbody>
  		</table>
  	<%
				RS_pre.close
	end if
	end function

%>
</body>
</html>
