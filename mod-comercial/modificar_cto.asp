<!--#include file="connectionbd.asp"-->
<!--#include file="funciones.asp"-->

<html> 
<head> 
   <title></title>
   <link href="css/bootstrap-notify.css" rel="stylesheet" type="txt/css">
  <script src="jquery-2.1.3.min.js" type="text/javascript"></script>
   <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
   <script language="JavaScript">
  function redireccionar() {
    setTimeout("location.reload='mod_cli.asp?id=' + form_modificar_cli.codigo_cliente.value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + 'mostrar=' + 0", 3000);
  }
  </script>
</head> 
<body>
  <!--#include file="menu.asp"-->
  <%
    id_cli=request.querystring("id")
    id_prov=request.querystring("provincia")
     call datos_cli_cto(id_cli, "CLI")
    idprov = CStr(idprov)
     
    
  %>
  
  <div class="progress progress-striped active">
  <div class="progress-bar" role="progressbar"
       aria-valuenow="45" aria-valuemin="20" aria-valuemax="100"
       style="width: 100%">
    <span class="sr-only">100% completado</span>
  </div>
</div>
<% 
  Dim cto_id,cto_nom,cto_tlf,cto_mail
  cto_id = request.form("idcontacto")
  cto_nom = request.form("nombrecto")
  cto_tlf = request.form("tlf_cto")
  cto_mail = request.form("email_cto")
  
  call modificar_cto(cto_id,cto_nom,cto_tlf,cto_mail)
%>


</table> 
</body> 
</html> 