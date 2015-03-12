<%

	'funcion para generar codigo automático para una tabla
	function generar_cod(tabla,num)
		'table --> nombre tabla, num --> num que inicializa el id
		dim count,objRS
		count = "select count(*) from " & tabla
		set objRS = conexion.Execute(count)
		if objRS(0) = 0 then
			'Si la tabla esta vacia aquí genera el codigo de la tabla automaticamente con el numero que le hemos pasado a traves de la funcion
	    	num = num
	    else
	   		'Generar codigo si ya hay algun dato introducido en la tabla
	    	num = num + objRS(0)
	    end if
	    set objRS = nothing
	    generar_cod = num
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