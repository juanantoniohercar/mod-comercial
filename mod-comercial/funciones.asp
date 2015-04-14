<!--#include file="connectionbd.asp"-->
<html>
<head>
	<link href="css/bootstrap-notify.css" rel="stylesheet" type="txt/css">
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
</body>
<%

	'***************declaracion de variables***********************'
	Dim consulta,objRS,nombre_usuario,password, SQL_idcomercial, SQL_comerciales, com_nom, com_id, SQL_bus_cli




	'****************Fin declaracion de variables********************'

	'funcion para autorizar el inicio de sesion'
	
	function iniciosesion ()
  		nombre_usuario=request.form("username")
  		password=request.form("password")

		consulta = "select * from EMP"
		set objRS = conexion.Execute(consulta)

   		while (not objRS.Eof) 
       		if objRS("emp_nom") = trim(nombre_usuario) and objRS("emp_pw") = trim(password) then
       		'si todo es ok nos envia a otra pagina'
       		SQL_idcomercial="select emp_id from EMP where emp_nom='"&nombre_usuario&"'"
       		set RS_idcomercial=createobject("ADODB.Recordset")
       		RS_idcomercial.open SQL_idcomercial,Conexion
       		do while not RS_idcomercial.eof
       			session("emp_id")=RS_idcomercial("emp_id")

       		RS_idcomercial.movenext
       		loop
       		RS_idcomercial.close

       		session	("nombre_comercial")=trim(request.form("username"))
       		session("autorizacion")=1
       		response.redirect("inicio.asp")
       		response.end
       		else
       			'si no coincide los datos o no existen error'
       			session("autorizacion")=-1
       			alert_formularios "USUARIO O CONTRASEÑA NO VÁLIDOS","warning"

       		end if
      	objRS.MoveNext 
   		wend

   		set objRS = nothing 
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
		cli_nombre = rs("cli_nom")
		cli_dir = rs("cli_dir")
		cli_tlf = rs("cli_tlf")
		cli_prov = rs("cli_prov")
		cli_pob = rs("cli_pob")
		
		rs.movenext
	%>
		<tbody>

			<tr>

				<td>
					<form name="form_list" action="abrir_cli.asp" method="get">
						<input type="hidden" name="id" value="<%=cli_id%>">
						<input type="hidden" name="provincia" value="<%=cli_prov%>">
						<input type="hidden" name="poblacion" value="<%=cli_pob%>">
	 					<input type="hidden" name="mostrar" value="0">
						<input class="enlace" type="submit" name="enlace_abrir" value="<%=cli_nombre%>">
					</form>
				</td>
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

	'funcion rellenar select asignacion de empleados'
	function select_com()
		SQL_comerciales="select * from EMP where emp_nom not like '"&session("nombre_comercial")&"'"
		set RS_comerciales=createobject("ADODB.Recordset")
		RS_comerciales.open SQL_comerciales,Conexion

		do while not RS_comerciales.eof
		com_id=RS_comerciales("emp_id")
		com_nom=RS_comerciales("emp_nom")
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
	public cli_id, cli_nom, cli_tlf, cto_id, cto_cli, cto_nom, cto_tlf, cto_mail, nombre_cliente
	function bus_cliente()
		nombre_cliente=request.querystring("bus_nomcli")
		SQL_bus_cli="select * from CLI where cli_nom='"&nombre_cliente&"'"
		set RS_bus_cli=createobject("ADODB.Recordset")
		RS_bus_cli.open SQL_bus_cli,Conexion
		
		do while not RS_bus_cli.eof
			cli_id=RS_bus_cli("cli_id")
			cli_nom=RS_bus_cli("cli_nom")
			cli_tlf=RS_bus_cli("cli_tlf")

		RS_bus_cli.movenext
		loop
		RS_bus_cli.close
	end function

	'funcion para la busqueda del contacto para el cliente que vamos a realizar la visita'
	function bus_cli_cto()
				SQL_bus_cli_cto="select * from CLI_CTO where cto_cli='"&cli_id&"'"
				set RS_bus_cli_cto= createobject("ADODB.Recordset")
				RS_bus_cli_cto.open SQL_bus_cli_cto,Conexion
				
				do while not RS_bus_cli_cto.eof
					cto_id=RS_bus_cli_cto("cto_id")
					cto_cli=RS_bus_cli_cto("cto_cli")
					cto_nom=RS_bus_cli_cto("cto_nom")
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
	end function

	'funcion para obtener los datos del contacto seleccionado'
	function datos_cto_cli()
				if request.querystring("contacto") <> "" then

				SQL_datos_cli_cto= "select cto_tlf, cto_mail from CLI_CTO where cto_id="&request.querystring("contacto")
				set RS_datos_cli_cto=createobject("ADODB.Recordset")
				RS_datos_cli_cto.open SQL_datos_cli_cto,Conexion

				do while not RS_datos_cli_cto.eof
				cto_tlf=RS_datos_cli_cto("cto_tlf")
				cto_mail=RS_datos_cli_cto("cto_mail")
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

			if est_id <> "" then
						if cadena = est_nom then
							response.write "<option value="&est_id&"&est_nom="&est_nom_esp&" selected>"&est_nom&"</option>"
				   			elseif cadena <> est_nom then
				        		response.write "<option value="&est_id&"&est_nom="&est_nom_esp&" >"&est_nom&"</option>"
				   		 	end if
						else
							response.write "<option value="&est_id&"&est_nom="&est_nom_esp&">"&est_nom&"</option>"
						end if

		RS_estado.movenext
		loop
		RS_estado.close



	end function	

	'funcion para buscar los presupuestos
	function select_pre()

		SQL_pre="select * from PRE where pre_cli='"&cli_id&"'"
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

	function insert_gescom(gc_id,gc_hora,gc_fec,gc_est,gc_emp,gc_pre,gc_cli,gc_cli_cto,gc_des)


		SQL_insert_gescom="insert into GES_COM values ("&gc_id&",'"&gc_hora&"','"&gc_fec&"',"&gc_est&","&gc_emp&","&gc_pre&","&gc_cli&","&gc_cli_cto&",'"&gc_des&"')"
	
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


		if visita_estado = 3 then
			SQL_visitas="select CLI.cli_id, CLI_CTO.cto_id, GES_COM.gc_id, GES_COM_EST.gce_nom, GES_COM.gc_fec,GES_COM.gc_hora, CLI.cli_nom, CLI.cli_dir, CLI_CTO.cto_nom, CLI_CTO.cto_tlf, CLI_CTO.cto_mail, GES_COM.gc_des from GES_COM_EST, GES_COM, CLI, CLI_CTO, EMP where GES_COM.gc_emp=EMP.emp_id and GES_COM_EST.gce_id=GES_COM.gc_est and EMP.emp_id="&comercial&" and GES_COM.gc_cli=CLI.cli_id and GES_COM.gc_cli_cto=CLI_CTO.cto_id and GES_COM.gc_fec between '"&visita_fecha1&"' and '"&visita_fecha2&"'"
				set RS_visitas=createobject("ADODB.Recordset")
				RS_visitas.open SQL_visitas,Conexion

			tabla_visitas(RS_visitas)

			
		else

			SQL_visitas="select CLI.cli_id, CLI_CTO.cto_id, GES_COM.gc_id, GES_COM_EST.gce_nom, GES_COM.gc_fec,GES_COM.gc_hora, CLI.cli_nom, CLI.cli_dir, CLI_CTO.cto_nom, CLI_CTO.cto_tlf, CLI_CTO.cto_mail, GES_COM.gc_des from GES_COM_EST, GES_COM, CLI, CLI_CTO, EMP where GES_COM.gc_emp=EMP.emp_id and GES_COM_EST.gce_id=GES_COM.gc_est and EMP.emp_id="&comercial&" and GES_COM_EST.gce_id="&visita_estado&" and GES_COM.gc_cli=CLI.cli_id and GES_COM.gc_cli_cto=CLI_CTO.cto_id and GES_COM.gc_fec between '"&visita_fecha1&"' and '"&visita_fecha2&"'"
				set RS_visitas=createobject("ADODB.Recordset")
				RS_visitas.open SQL_visitas,Conexion

			tabla_visitas(RS_visitas)
			
		end if
		
	end function

	'funcion que nos crea la tabla on los resultado de busqueda de las visitas'
	function tabla_visitas(rs)
	
	%>
	
	
		<table border=3 class="table table-striped">
			<thead>
  				<tr>
          			<th>Estado</th>
          			<th>Fecha Visita</th>
          			<th>Hora Visita</th>
  					<th>Cliente</th>
          			<th>Dirección</th>
  					<th>Nombre contacto</th>
  					<th>Telefono</th>
  					<th>E-mail</th>
  					<th>Descripci&oacuten</th>
  				</tr>
  			</thead>
  	<%
  			

  		do while not rs.eof
  			cli_id=rs("cli_id")
  			cto_id=rs("cto_id")
  			gc_id=rs("gc_id")
  			gce_nom=rs("gce_nom")
  			gc_fec=rs("gc_fec")
  			gc_hora=rs("gc_hora")
  			cli_nom=rs("cli_nom")
  			cli_dir=rs("cli_dir")
  			cto_nom=rs("cto_nom")
  			cto_tlf=rs("cto_tlf")
  			cto_mail=rs("cto_mail")
  			gc_des=rs("gc_des")

  			rs.movenext
  			
  		
  	%>
  		<tbody>
  			<%
  				if gce_nom= "Pendiente" then
  			%>

  			<tr class="danger" onclick="window.location.href='mod_visita.asp?id=' + document.getElementById('<%=gc_id%>').value + '&contacto=' + document.getElementById('<%=cto_id%>').value + '&cliente=' + document.getElementById('<%=cli_id%>').value + '&des=' + document.getElementById('modv_desc<%=gc_id%>').value + '&fecha=' + document.getElementById('modv_fecha<%=gc_fec%>').value + '&hora=' + document.getElementById('modv_hora<%=gc_hora%>').value">
  				<td><%=gce_nom%><input type="hidden" id="<%=gc_id%>" name="<%=gc_id%>" value="<%=gc_id%>"> </td>
  				<td><%=gc_fec%> <input type="hidden" class="form-control" id="modv_fecha<%=gc_fec%>" name="modv_fecha<%=gc_fec%>" value="<%=gc_fec%>"></td>
  				<td><%=gc_hora%> <input type="hidden" class="form-control" id="modv_hora<%=gc_hora%>" name="modv_hora<%=gc_hora%>" value="<%=gc_hora%>"></td>
  				<td><%=cli_nom%> <input type="hidden" id="<%=cli_id%>" name="<%=cli_id%>" value="<%=cli_id%>"></td>
  				<td><%=cli_dir%></td>
  				<td><%=cto_nom%><input type="hidden" id="<%=cto_id%>" name="<%=cto_id%>" value="<%=cto_id%>"></td>
  				<td><%=cto_tlf%></td>
  				<td><%=cto_mail%></td>
  				<td><%=gc_des%><textarea style="display:none;" class="form-control" rows="4" id="modv_desc<%=gc_id%>" name="modv_desc<%=gc_id%>"><%=gc_des%></textarea></td>

  			</tr>
  			<%
  			end if
  			if gce_nom= "Finalizada" then
			%>
			<tr class="success" onclick="window.location.href='mod_visita.asp?id=' + document.getElementById('<%=gc_id%>').value + '&contacto=' + document.getElementById('<%=cto_id%>').value + '&cliente=' + document.getElementById('<%=cli_id%>').value + '&des=' + document.getElementById('modv_desc<%=gc_id%>').value + '&fecha=' + document.getElementById('modv_fecha<%=gc_fec%>').value + '&hora=' + document.getElementById('modv_hora<%=gc_hora%>').value">
  				<td><%=gce_nom%><input type="hidden" id="<%=gc_id%>" name="<%=gc_id%>" value="<%=gc_id%>"> </td>
  				<td><%=gc_fec%> <input type="hidden" class="form-control" id="modv_fecha<%=gc_fec%>" name="modv_fecha<%=gc_fec%>" value="<%=gc_fec%>"></td>
  				<td><%=gc_hora%> <input type="hidden" class="form-control" id="modv_hora<%=gc_hora%>" name="modv_hora<%=gc_hora%>" value="<%=gc_hora%>"></td>
  				<td><%=cli_nom%> <input type="hidden" id="<%=cli_id%>" name="<%=cli_id%>" value="<%=cli_id%>"></td>
  				<td><%=cli_dir%></td>
  				<td><%=cto_nom%><input type="hidden" id="<%=cto_id%>" name="<%=cto_id%>" value="<%=cto_id%>"></td>
  				<td><%=cto_tlf%></td>
  				<td><%=cto_mail%></td>
  				<td><%=gc_des%><textarea style="display:none;" class="form-control" rows="4" id="modv_desc<%=gc_id%>" name="modv_desc<%=gc_id%>"><%=gc_des%></textarea></td>
  			</tr>
  			<%
  			end if
  			%>



  	<%
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

		SQL_datos_visita="select CLI.cli_id, CLI_CTO.cto_id, CLI.cli_tlf, GES_COM.gc_pre, GES_COM.gc_id, GES_COM_EST.gce_id, GES_COM_EST.gce_nom, GES_COM.gc_fec,GES_COM.gc_hora, CLI.cli_nom, CLI.cli_dir, CLI_CTO.cto_nom, CLI_CTO.cto_tlf, CLI_CTO.cto_mail, GES_COM.gc_des, PRE.pre_id from GES_COM_EST, GES_COM, CLI, CLI_CTO, EMP, PRE where GES_COM.gc_emp=EMP.emp_id and GES_COM_EST.gce_id=GES_COM.gc_est and EMP.emp_id='"&session("emp_id")&"' and GES_COM.gc_cli=CLI.cli_id and GES_COM.gc_cli_cto=CLI_CTO.cto_id and PRE.pre_id=GES_COM.gc_pre and gc_id='"&id&"'"
		set RS_datos_visita=createobject("ADODB.Recordset")
		RS_datos_visita.open SQL_datos_visita,Conexion

		do while not RS_datos_visita.eof
			cli_id_vi=RS_datos_visita("cli_id")
			cto_id_vi=RS_datos_visita("cto_id")
			gce_id_vi=RS_datos_visita("gce_id")
			gce_nom_vi=RS_datos_visita("gce_nom")
  			gc_fec_vi=RS_datos_visita("gc_fec")
  			gc_hora_vi=RS_datos_visita("gc_hora")
  			cli_nom_vi=RS_datos_visita("cli_nom")
  			cli_tlf_vi=RS_datos_visita("cli_tlf")
  			cto_nom_vi=RS_datos_visita("cto_nom")
  			cto_tlf_vi=RS_datos_visita("cto_tlf")
  			cto_mail_vi=RS_datos_visita("cto_mail")
  			gc_des_vi=RS_datos_visita("gc_des")
  			gc_pre_vi=RS_datos_visita("gc_pre")

		RS_datos_visita.movenext
		loop
		RS_datos_visita.close


	end function
	'funcions para cargar los datos del contacto en el modificar visitas'

	function select_cli_cto_vi()
				
				SQL_cli_cto_vi="select * from CLI_CTO where cto_cli="&cli_id_vi
				set RS_cli_cto_vi=createobject("ADODB.Recordset")
				RS_cli_cto_vi.open SQL_cli_cto_vi,Conexion
				
				do while not RS_cli_cto_vi.eof
				cto_nom = RS_cli_cto_vi("cto_nom")
				cto_id = RS_cli_cto_vi("cto_id")
				p = request.querystring("cto_nom")
				response.write p
				
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
	function mod_visita(gc_id,gc_hora,gc_fec,gc_est,gc_emp,gc_pre,gc_cli,gc_cli_cto,gc_des)
	if gc_id = "" or gc_fec = "" or gc_est = "" or gc_emp = "" or gc_cli = "" or gc_cli_cto = "" then
			alert_formularios "FALTAN DATOS POR INTRODUCIR","warning"
		else
			SQL_update_visita="update GES_COM set gc_hora='"&gc_hora&"', gc_fec='"&gc_fec&"', gc_est="&gc_est&", gc_emp="&gc_emp&", gc_pre="&gc_pre&", gc_cli="&gc_cli&", gc_cli_cto="&gc_cli_cto&", gc_des='"&gc_des&"' where gc_id="&gc_id
			response.write SQL_update_visita
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


%>
</body>
</html>
