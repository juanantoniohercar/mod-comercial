
<%Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"%><!DOCTYPE html>
<html lang="es">
<head>
	 <meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
        <link href="css/login.css" rel="stylesheet" type="txt/css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gesti&oacuten Comercia - Gestion Visitas</title>
</head>
<body>
   <% call validar() 
   pag=8
   bus_nomcli=Server.URLEncode(request.querystring("bus_nomcli"))
   id=request.querystring("id")
   cliente=Server.URLEncode(request.querystring("cliente"))
   tlf=request.querystring("tlf")
   contacto=request.querystring("contacto")
   cto_nom=request.querystring("cto_nom")
   com_asignado=request.querystring("com_asignado")
   estado=request.querystring("estado")
   est_nom=request.querystring("est_nom")
   fecha=request.querystring("fecha")
   hora=request.querystring("hora")
   des=request.querystring("des")
   num=request.querystring("num")
   'response.write "-->"&bus_nomcli&"-->"&id&"-->"&cliente&"-->"&tlf&"-->"&contacto&"-->"&com_asignado&"-->"&estado&"-->"&fecha&"-->"&hora
   %>
  <% if session("autorizacion") <> 1 then response.redirect("Default.asp") end if %>
	<!--#include file="menu.asp"-->
  <!--#include file="funciones.asp"-->
 
<div class="container">
<form action="presupuesto.asp" method="POST" name="form_busq_pre" id="form_busq_pre" class="form-horizontal" role="form">
  <input type="hidden" class="form-control" id="bus_nomcli1" maxlength="50" name="bus_nomcli1" value="<%=bus_nomcli%>">
  <input type="hidden" class="form-control" id="id1" maxlength="50" name="id1" value="<%=id%>">
  <input type="hidden" class="form-control" id="cliente1" maxlength="50" name="cliente1" value="<%=cliente%>">
  <input type="hidden" class="form-control" id="tlf1" maxlength="50" name="tlf1" value="<%=tlf%>">
  <input type="hidden" class="form-control" id="contacto1" maxlength="50" name="contacto1" value="<%=contacto%>">
  <input type="hidden" class="form-control" id="cto_nom1" maxlength="50" name="cto_nom1" value="<%=cto_nom%>">
  <input type="hidden" class="form-control" id="com_asignado1" maxlength="50" name="com_asignado1" value="<%=com_asignado%>">
  <input type="hidden" class="form-control" id="estado1" maxlength="50" name="estado1" value="<%=estado%>">
  <input type="hidden" class="form-control" id="est_nom1" maxlength="50" name="est_nom1" value="<%=est_nom%>">
  <input type="hidden" class="form-control" id="fecha1" maxlength="50" name="fecha1" value="<%=fecha%>">
  <input type="hidden" class="form-control" id="hora1" maxlength="50" name="hora1" value="<%=hora%>">
   <input type="hidden" class="form-control" id="desc" maxlength="50" name="desc" value="<%=des%>">
    <input type="hidden" class="form-control" id="numero" maxlength="50" name="numero" value="<%=num%>">
	<div class="form-group col-xs-12 col-sm-12 col-md-12">
 		<h3>Buscar Presupuesto</h3>
		<hr class="" color="DFDCDC">
	</div>
	<div class="form-group col-xs-12 col-sm-12 col-md-6 ">
    <label for="nombre_cli">Presupuesto a buscar</label>
    <div class="form-inline">
    <input type="text" class="form-control col-xs-6 col-sm-8 col-md-8" id="bus_pre" maxlength="50" name="bus_pre">

    <button type="button" class="btn btn-info col-xs-2 col-sm-1 col-md-1" onclick="location.href='presupuesto.asp?bus_nomcli=' + form_busq_pre.bus_nomcli1.value + '&id=' + form_busq_pre.id1.value + '&cliente=' + form_busq_pre.cliente1.value + '&tlf=' + form_busq_pre.tlf1.value + '&contacto=' + form_busq_pre.contacto1.value + '&cto_nom=' + form_busq_pre.cto_nom1.value + '&com_asignado=' + form_busq_pre.com_asignado1.value + '&estado=' + form_busq_pre.estado1.value + '&est_nom=' + form_busq_pre.est_nom1.value + '&fecha=' + form_busq_pre.fecha1.value + '&hora=' + form_busq_pre.hora1.value + '&bus_pres=' + form_busq_pre.bus_pre.value + '&des=' + form_busq_pre.desc.value + '&num=' + form_busq_pre.numero.value">
          <span class="glyphicon glyphicon-search"></span>
      </button>
    </div>
</div>
  <div class="form-group col-xs-12 col-sm-12 col-md-12">
    <h3 class="">Presupuestos</h3>
    <hr class="" color="DFDCDC">
  </div>
</form>
  <div class="form-group">
    <%call bus_pre()%>
  </div>
  <div class="form-group">
    <div class="pull-right col-xs-6 col-sm-6 col-md-6">
      <button type="button" class="btn btn-warning pull-right btn-lg" onclick="javascript:history.go(-1);">
          <span class="">Astras</span>
      </button>
      </div>
    </div>

</div>
</body>
</html>
