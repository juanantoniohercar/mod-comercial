
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
%>