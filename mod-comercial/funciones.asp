<html>
<head>
	<link href="css/bootstrap-notify.css" rel="stylesheet" type="txt/css">
	<script src="jquery-2.1.3.min.js" type="text/javascript"></script>
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
	</script>
</head>
</body>
<%

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
	function insertar_cliente(id_cli,cli_cif,cli_nom,cli_prov,cli_pob,cli_dir,cli_tlf,cto_id,cto_nom,cto_tlf,cto_mail)

		
		dim ins_cli,ins_cto
		if id_cli = "" or cli_cif = "" or cli_nom = "" or cli_prov = "" or cli_pob = "" or cli_dir = "" or cli_tlf = "" then
			alert_formularios "FALTAN DATOS POR INTRODUCIR","warning"
		else
			ins_cli = "insert into CLI values ("&id_cli&",'"&cli_cif&"','"&cli_nom&"',"&cli_prov&","&cli_pob&",'"&cli_dir&"','"&cli_tlf&"')"
			ins_cto = "insert into CLI_CTO values ("&cto_id&","&id_cli&",'"&cto_nom&"','"&cto_tlf&"','"&cto_mail&"')"
			
			'Si hay un error en la base de datos permite continuar con la ejecucion del script
			on error resume next
			Conexion.Execute(ins_cli)
			'Si error es nivel distinto de cero nos mostrara mensaje de error, si el nivel es cero continua con introducir los datos del contacto
			if err <> 0 then
				alert_formularios "ERROR! No se pueden introducir los datos en la base de datos","danger"
			else
				if cto_nom = "" and cto_tlf = "" and cto_mail = ""  then
				'alert_formularios "FALTAN DATOS POR INTRODUCIR","warning"
				else
				on error resume next
				Conexion.Execute(ins_cto)
				end if
				'Si nivel de error distinto de cero mostrar mensaje de error, si nivel indicara que se han introducido los datos correctamente
				if err <> 0 then
						alert_formularios "ERROR! No se pueden introducir los datos de los contactos en la base de datos","danger"		
				else
					alert_formularios "DATOS INTRODUCIDOS CORRECTAMENTE","success"
					 
				end if
			end if		
		end if
		
	end function

	'Crea la tabla con los resultado de busqueda cliente'
	function creartabla_bus(rs)
	%>
	
		<table border=3 class="table table-striped">
		<thead>
			<tr>
				<th>Nombre</th>
				<th>Telefono</th>
				<th>Domicilio</th>
				<th>OPCIONES</th>
			</tr>
		</thead>
 	
	<%
	do while not rs.eof
		
		cli_id = rs("cli_id")
		cli_nombre = rs("cli_nombre")
		cli_dir = rs("cli_dir")
		cli_tlf = rs("cli_tlf")
		cli_prov = rs("cli_prov")
		cli_pob = rs("cli_pob")
		
		rs.movenext
	%>
		<tbody>

			<tr>
				<td><%=cli_nombre%></td>
				<td><%=cli_tlf%></td>
				<td><%=cli_dir%></td>
				<td>
					<div class="pull-left">
					<form name="form_modificar" action="mod_cli.asp" method="get">
						<input type="hidden" name="id" value="<%=cli_id%>">
						<input type="hidden" name="provincia" value="<%=cli_prov%>">
						<input type="hidden" name="poblacion" value="<%=cli_pob%>">
	 					<input type="hidden" name="mostrar" value="0">
						<button type="submit" class="btn btn-primary btn-xs">
	 						<span class="glyphicon glyphicon-pencil"></span>
						</button>
					</form>
					</div>
					<div class="pull-left">
					<form name="form_listar" class="form-horizontal" action ="abrir_cli.asp" method="get">
						<input type="hidden" name="id" value="<%=cli_id%>">
						<input type="hidden" name="provincia" value="<%=cli_prov%>">
						<input type="hidden" name="poblacion" value="<%=cli_pob%>">
	 					<input type="hidden" name="mostrar" value="0">
						<button type="submit" class="btn btn-success btn-xs">
							<span class="glyphicon glyphicon-open"></span>
						</button>
					</form>
					</div>
					<form name="form_borrar" class="form-horizontal" action ="borrar_cli.asp" method="post" onsubmit="return comprobarbtn();">
					<input type="hidden" name="id" value="<%=cli_id%>">
					<button type="submit" class="btn btn-danger btn-xs">
 					<span class="glyphicon glyphicon-remove-circle"></span>
					</button>
					</form>
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
	SQL_cto="select CLI_CTO.cto_id, CLI_CTO.cto_nom, CLI_CTO.cto_tlf, CLI_CTO.cto_mail from CLI, CLI_CTO where CLI.cli_id=CLI_CTO.cto_cli and CLI.cli_id='"&id&"'"
	set RS_cli = createobject("ADODB.Recordset")
	set RS_cto = createobject("ADODB.Recordset")
	RS_cli.open SQL_cli, Conexion
	RS_cto.open SQL_cto, Conexion

	'Recorremos en la base de datos para recuperar los datos del cliente'
	do while not RS_cli.eof
		cod=RS_cli("cli_id")
		dnicif=RS_cli("cli_cif")
		nombre=RS_cli("cli_nombre")
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
	SQL_prov= "select PROV.prov_nom, PROV.prov_id from CLI, PROV where CLI.cli_prov=PROV.prov_id and cli_id='"&id&"'"
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
	pob= RS_pob("pob_nombre")
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
	
		<table border=3 class="table table-striped">
		<thead>
			<tr>
				<th>Nombre</th>
				<th>Telefono</th>
				<th>Domicilio</th>
			</tr>
		</thead>
 	
	<%
	'Recorremos en la base de datos para recuperar los datos de los contactos de ese cliente'
	do while not RS_cto.eof
		nombre_cto=RS_cto("cto_nom")
		tlf_cto=RS_cto("cto_tlf")
		email_cto=RS_cto("cto_mail")

		RS_cto.movenext
	%>
		<tbody>

			<tr>
				<td><%=nombre_cto%></td>
				<td><%=tlf_cto%></td>
				<td><%=email_cto%></td>
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
		id_contacto= RS_cto("cto_id")
		nombre_cto=RS_cto("cto_nom")
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

				SQL_datos_cto= "select cto_id, cto_nom, cto_tlf, cto_mail from CLI_CTO where cto_id="&request.querystring("contacto")
				set RS_datos_cto=createobject("ADODB.Recordset")
				RS_datos_cto.open SQL_datos_cto,Conexion

				do while not RS_datos_cto.eof
				id_cont=RS_datos_cto("cto_id")
				nombrecto=RS_datos_cto("cto_nom")
				tlf_cto=RS_datos_cto("cto_tlf")
				email_cto=RS_datos_cto("cto_mail")
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
			SQL_update_cli="update CLI set cli_cif='"&cli_cif&"', cli_nombre='"&cli_nom&"', cli_prov='"&cli_prov&"', cli_pob='"&cli_pob&"', cli_dir='"&cli_dir&"', cli_tlf='"&cli_tlf&"' where cli_id='"&id_cli&"'"
			
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
  				function redireccionar() {
    				setTimeout('history.back()', 2500);

  				}
  					redireccionar();
  			</script>
		<%

	end function

	'funcion modifica contacto '
	function modificar_cto(cto_id,cto_nom,cto_tlf,cto_mail)

	if cto_nom = "" or cto_tlf = "" or cto_mail = "" then
			alert_formularios "FALTAN DATOS POR INTRODUCIR","warning"
		else
			SQL_update_cto="update CLI_CTO set cto_nom='"&cto_nom&"', cto_tlf='"&cto_tlf&"', cto_mail='"&cto_mail&"' where cto_id='"&cto_id&"'"
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
  			function redireccionar() {
    			setTimeout('history.back()', 2500);

  			}
  						
  			redireccionar();
  		</script>
		<%

	end function

	'funcion que añade un contacto a un cliente ya creado'
	function add_cto(cto_id,id_cli,cto_nom,cto_tlf,cto_mail)

		SQL_insert_cto="insert into CLI_CTO values ("&cto_id&","&id_cli&",'"&cto_nom&"','"&cto_tlf&"','"&cto_mail&"')"
		
		if cto_nom = "" and cto_tlf = "" and cto_mail = ""  then
			
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
  			function redireccionar() {
    			setTimeout('history.back()', 2500);

  			}
  						
  			redireccionar();
  		</script>
		<%

	end function

	'funcion eliminar clientes'
	function eliminar_cli(id)

	SQL_delete_cto_cli="delete from CLI_CTO where cto_cli='"&id&"'" 
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
%>
</body>
</html>