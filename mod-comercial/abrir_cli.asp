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
	<title>Gesti&oacuten Comercia - Abrir cliente</title>
</head>
<body>
	<% pag=4 %>
	<!--#include file="menu.asp"-->
	
	<% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
	<!--#include file="funciones.asp"-->
	
	<%
		id_cli=request.querystring("id")
		id_prov=request.querystring("provincia")
		 call datos_cli_cto(id_cli, "CLI")
		idprov = CStr(idprov)

		
		
	%>
<div class="container">
	<div class="form-group col-lg-12"><br>
		<!--<button type="submit" class="btn btn-default btn-sm pull-right">
    			<span class="glyphicon glyphicon-print"></span>
		</button>
		<button type="submit" class="btn btn-default btn-sm pull-right">
    			<span class="glyphicon glyphicon-floppy-save"></span>
		</button>-->
 		<h3>Datos cliente</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group col-xs-6 col-sm-6 col-md-2">
		<label>Código Cliente</label>
		<p class="form-control-static"><%=cod%></p>
	</div>
	<div class="form-group col-xs-6 col-sm-6 col-md-2">
		<label>C. I. F.</label>
		<p class="form-control-static"><%=dnicif%></p>
	</div> 
	<div class="form-group col-xs-6 col-sm-6 col-md-5">
		<label>Nombre</label>
		<p class="form-control-static"><%=nombre%></p>
	</div>
	<div class="form-group col-xs-6 col-sm-6 col-md-6">
		<label>Direcci&oacuten</label>
	<p class="form-control-static"><%=direccion%></p>
	</div>
	<div class="form-group col-xs-6 col-sm-6 col-md-3">
		<label>Provincia</label>
		<p class="form-control-static"><%=prov%></p>
 	</div>
	<div class="form-group col-xs-6 col-sm-6 col-md-4">
		<label>Poblaci&oacuten</label>
		<p class="form-control-static"><%=pob%></p>	
	</div>
	<div class="form-group col-xs-6 col-sm-6 col-md-2">
		<label>C&oacutedigo Postal</label>
		<p class="form-control-static"><%=cpostal%></p>	
	</div>
	
 	<div class="form-group col-xs-6 col-sm-6 col-md-3">
 		<label>Tel&eacutefono</label>
		<p class="form-control-static"><%=tlf%></p> 	
	</div>
	<div class="form-group col-xs-12 col-sm-12 col-md-12">
 		<h3>Datos contacto</h3>
		<hr class="" color="DFDCDC">
	</div>
	<%call creartabla_mostarcto()%>
	<div class="form-group">
    <div class="pull-right col-xs-6 col-sm-6 col-md-6">
      <button type="button" class="btn btn-warning pull-right btn-lg" onclick="javascript:history.go(-1);">
          <span class="">Atras</span>
      </button>
    </div>
  </div>
</div>
</body>
</html>







