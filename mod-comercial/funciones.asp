<html>
<head></head>
</body>
<%

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
		if id_cli = " " or cli_cif = " " or cli_nom = " " or cli_prov = "Seleccione una población" or cli_pob = "Seleccione una población" or cli_dir = " " or cli_tlf = " " or cto_nom = " " or cto_tlf = " " or cto_mail = " " then
			response.write("<script language='javascript'>alert('ATENCION! Rellenar todos los campos');</script>")
		else
			ins_cli = "insert into CLI values ("&id_cli&",'"&cli_cif&"','"&cli_nom&"',"&cli_prov&","&cli_pob&",'"&cli_dir&"','"&cli_tlf&"')"
			ins_cto = "insert into CLI_CTO values ("&cto_id&","&id_cli&",'"&cto_nom&"','"&cto_tlf&"','"&cto_mail&"')"
			response.write(ins_cli)
			response.write("--")
			response.write(ins_cto)
			'Si hay un error en la base de datos permite continuar con la ejecucion del script
			on error resume next
			conexion.Execute(ins_cli)
			'Si error es nivel distinto de cero nos mostrara mensaje de error, si el nivel es cero continua con introducir los datos del contacto
			if err <> 0 then
				response.write("<script language='javascript'>alert('ERROR! No se pudo introducir los datos en la base de datos');</script>")
			else
				on error resume next
				conexion.Execute(ins_cto)
				'Si nivel de error distinto de cero mostrar mensaje de error, si nivel indicara que se han introducido los datos correctamente
				if err <> 0 then
					response.write("<script language='javascript'>alert('ATENCION! No se pudo introducir los datos de los contactos');</script>")		
				else
					response.write("<script language='javascript'>alert('Datos introducidos satisfactoriamente en la base de datos');</script>")		
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
					
					<form name="form_listar" class="form-horizontal" action ="abrir_cli.asp" method="get">
						<button type="submit" class="btn btn-success btn-xs">
							<span class="glyphicon glyphicon-open"></span>
						</button>
					</form>

					<button type="button" class="btn btn-danger btn-xs">
 					<span class="glyphicon glyphicon-remove-circle"></span>
					</button>
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
	public SQL_cli, cod, dnicif, nombre, direccion, provincia, pobalcion, cp, tlf, nombre_cto, tlf_cto, email_cto
	function datos_cli(id, tabla)
	
	SQL_cli="select * from "&tabla&" where cli_id='"&id&"'"
	set RS_cli = createobject("ADODB.Recordset")
	RS_cli.open SQL_cli, Conexion

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
	public SQL_prov, prov, SQL_pob, pob, idpob, cpostal, idprov
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

	end function 
%>
</body>
</html>