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
        <script src="js/jquery-2.1.3.js"></script>
        <script type="text/javascript" src="js/funciones.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Gestion Comercial</title>
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
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
	<% pag=5
	 %>
	<!--#include file="menu.asp"-->
	<!--#include file="funciones.asp"-->


	
	
<div class="container" id="div_container">
<form action="gest_comercial.asp" method="get" name="form_gest_com_buscli" id="form_gest_com_buscli" class="form-horizontal" role="form" >

<div class="form-group col-xs-12 col-sm-12 col-md-6 ">
		<label for="nombre_cli">Cliente a buscar</label>
		<div class="form-inline ">
		<input type="text" class="form-control col-xs-6 col-sm-8 col-md-8" id="bus_nomcli" maxlength="50" name="bus_nomcli">

		<button type="submit" class="btn btn-info col-xs-2 col-sm-1 col-md-1">
    			<span class="glyphicon glyphicon-search"></span>
			</button>
		<button type="button" class="btn btn-success col-xs-2 col-sm-1 col-md-1" onclick='window.location.href="nue_cli.asp"'>
    		<span class="glyphicon glyphicon-plus-sign"></span>
		</button>
		</div>
</div>
</form>
<form name="form_nombre" id="form_nombre" class="form-horizontal" role="form">
	<div class="form-group col-xs-12 col-sm-8 col-md-6" id="div_cliente">
		<label>Cliente</label>
			<select class="form-control" id="select_nom" name="select_nom" onchange= "location.href='gest_comercial.asp?bus_nomcli=' + form_gest_com.bus_nomcli2.value + '&cliente=' + form_nombre.select_nom.options[form_nombre.select_nom.selectedIndex].value + '&contacto=' + form_gest_com.addv_nomcto.options[form_gest_com.addv_nomcto.selectedIndex].value + '&com_asignado=' + form_gest_com.addv_com.options[form_gest_com.addv_com.selectedIndex].value + '&estado=' + form_gest_com.addv_estado.options[form_gest_com.addv_estado.selectedIndex].value + '&fecha=' + form_gest_com.addv_fecha.value + '&hora=' + form_gest_com.addv_hora.value + '&presupuesto=' + form_gest_com.addv_pre.value + '&des=' + form_gest_com.addv_desc.value">
					
					<%call bus_cliente()%>
			</select>

	</div>
</form>

<form action="add_visita.asp" method="post" name="form_gest_com" id="form_gest_com" class="form-horizontal" role="form" onsubmit="return validacionvisita()">
	<input type="hidden" class="form-control" id="bus_nomcli2" maxlength="50" name="bus_nomcli2" value="<%=nombre_cliente%>">
	<input type="hidden" class="form-control" id="bus_idcli2" maxlength="50" name="bus_idcli2" value="<%=request.querystring("cliente")%>">
	<input type="hidden" class="form-control" id="addv_gcid" maxlength="50" name="addv_gcid" value="<%=generar_cod("GES_COM","gc_id")%>">
	<input type="hidden" class="form-control" id="addv_pre" maxlength="50" name="addv_pre" value="<%=request.querystring("presupuesto")%>">
	
	<div class="from-group col-xs-12 col-sm-6 col-md-6" id="div_comercial">
		<label>Comercial Asignado</label>
		<select class="form-control" id="addv_com" name="addv_com" onchange= "location.href='gest_comercial.asp?bus_nomcli=' + form_gest_com.bus_nomcli2.value + '&cliente=' + form_nombre.select_nom.options[form_nombre.select_nom.selectedIndex].value + '&contacto=' + form_gest_com.addv_nomcto.options[form_gest_com.addv_nomcto.selectedIndex].value + '&com_asignado=' + form_gest_com.addv_com.options[form_gest_com.addv_com.selectedIndex].value + '&estado=' + form_gest_com.addv_estado.options[form_gest_com.addv_estado.selectedIndex].value + '&fecha=' + form_gest_com.addv_fecha.value + '&hora=' + form_gest_com.addv_hora.value + '&presupuesto=' + form_gest_com.addv_pre.value + '&des=' + form_gest_com.addv_desc.value">

				<optgroup label="Sesion iniciada por el comercial ">
  					<option value="<%=session("emp_id")%>"><%=session("nombre_comercial")%></option>
  				</optgroup>
  				<optgroup label="Otros Comerciales">
  				<% call select_com() %>
  				</optgroup>
			</select>
	</div>
	
<div id="div_datovisita">
	<div class="form-group col-xs-12 col-sm-12 col-md-12">
 		<h3>Datos Del Cliente</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group col-xs-12 col-sm-6 col-md-6">
		<label>Nombre de Cliente</label>
		<p class="form-control-static"><%=request.querystring("cliente_nom")%></p>
	</div>
	<div class="form-group col-xs-12 col-sm-6 col-md-6">
		<label>Telefono</label>
		<p class="form-control-static"><%=request.querystring("tlf")%></p>
	</div>
	<div class="form-group col-xs-12 col-sm-6 col-md-6">
		<label for="addv_nomcto">Nombre Contacto</label>
		<select class="form-control" id="addv_nomcto" name="addv_nomcto" onchange= "location.href='gest_comercial.asp?bus_nomcli=' + form_gest_com.bus_nomcli2.value + '&cliente=' + form_nombre.select_nom.options[form_nombre.select_nom.selectedIndex].value + '&contacto=' + form_gest_com.addv_nomcto.options[form_gest_com.addv_nomcto.selectedIndex].value + '&com_asignado=' + form_gest_com.addv_com.options[form_gest_com.addv_com.selectedIndex].value + '&estado=' + form_gest_com.addv_estado.options[form_gest_com.addv_estado.selectedIndex].value + '&fecha=' + form_gest_com.addv_fecha.value + '&hora=' + form_gest_com.addv_hora.value + '&presupuesto=' + form_gest_com.addv_pre.value + '&des=' + form_gest_com.addv_desc.value">
  				
  				<%call bus_cli_cto()%>
			</select>
	</div>
	<%call datos_cto_cli() %>
	<div class="form-group col-xs-12 col-sm-3 col-md-3">
		<label>Telefono</label>
		<p class="form-control-static"><%=cto_tlf%></p>
	</div>
	<div class="form-group col-xs-12 col-sm-3 col-md-3">
		<label>E-mail</label>
		<p class="form-control-static"><%=cto_mail%></p>
	</div>
</div>
	<div class="form-group col-xs-12 col-sm-12 col-md-12">
 		<h3>Datos De La Visita</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group col-xs-12 col-sm-4 col-md-4">
		<label for="addv_fecha">Fecha Visita</label>
		<input type="date" class="form-control input-g" id="addv_fecha" name="addv_fecha" value="<%=request.querystring("fecha")%>" required>
	</div>
	<div class="form-group col-xs-12 col-sm-4 col-md-4">
		<label for="addv_hora">Hora Visita</label>
		<input type="time" class="form-control input-g" id="addv_hora" name="addv_hora" value="<%=request.querystring("hora")%>">
	</div>
	

	<div class="form-group col-xs-12 col-sm-4 col-md-4">
		<label for="addv_estado">Estado</label>
		<select class="form-control" id="addv_estado" name="addv_estado" onchange= "location.href='gest_comercial.asp?bus_nomcli=' + form_gest_com.bus_nomcli2.value + '&cliente=' + form_nombre.select_nom.options[form_nombre.select_nom.selectedIndex].value + '&contacto=' + form_gest_com.addv_nomcto.options[form_gest_com.addv_nomcto.selectedIndex].value + '&com_asignado=' + form_gest_com.addv_com.options[form_gest_com.addv_com.selectedIndex].value + '&estado=' + form_gest_com.addv_estado.options[form_gest_com.addv_estado.selectedIndex].value + '&fecha=' + form_gest_com.addv_fecha.value + '&hora=' + form_gest_com.addv_hora.value + '&presupuesto=' + form_gest_com.addv_pre.value + '&des=' + form_gest_com.addv_desc.value">
  				<option value=0>Selecciona un estado</option>
  				<%call select_est()%>
		</select>
	</div>
	<div class="form-group col-xs-12 col-sm-6 col-md-6">
		<label for="addv_pre">Presupuesto</label>
		<input type="hidden" class="form-control" id="num" maxlength="50" name="num" value="1">
		<button type="button" class="btn btn-info" onclick="validar()">
    		<span class="glyphicon glyphicon-search"></span>
		</button>
		<p class="form-control-static"><%=request.querystring("presupuesto")%></p>
	</div>
		
	
	<div class="form-group col-xs-12 col-sm-12 col-md-12">
		<label for="addv_desc">Descripci&oacuten</label>
		<textarea class="form-control" rows="4" id="addv_desc" name="addv_desc"><%=request.querystring("des")%></textarea>
	</div>
	<div class="form-group" id="div_submit">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<button type="submit" class="btn btn-success btn-lg" name="addv_visita">
    			<span class="glyphicon">Guardar</span>
			</button>
		</div>
		<div class="pull-right col-xs-6 col-sm-6 col-md-6">
			<button type="button" class="btn btn-warning pull-right btn-lg" onclick='window.location.href="inicio.asp"'>
    			<span class="">Volver</span>
			</button>
		</div>
	</div>
		

</form>
</div>
</body>
</html>
