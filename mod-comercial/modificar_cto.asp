<%Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head> 
   <title></title>
   <link href="css/bootstrap-notify.css" rel="stylesheet" type="txt/css">
  <script src="jquery-2.1.3.min.js" type="text/javascript"></script>
   <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
   
</head> 
<body>
  <% pag=9 %>
  <!--#include file="menu.asp"-->
  <!--#include file="funciones.asp"-->
  <%
    
    
  %>
  
  <div class="progress progress-striped active">
  <div class="progress-bar" role="progressbar"
       aria-valuenow="45" aria-valuemin="20" aria-valuemax="100"
       style="width: 100%">
    <span class="sr-only">100% completado</span>
  </div>
</div>
<% 
  Dim mod_cto_id,mod_cto_nom,mod_cto_tlf,mod_cto_mail
  mod_cto_id = request.form("idcontacto")
  mod_cto_nom = request.form("nombrecto")
  mod_cto_tlf = request.form("tlf_cto")
  mod_cto_mail = request.form("email_cto")
  id_cli = request.form("valor_idcli")
  idprov = request.form("valor_idprov")
  idpob = request.form("valor_idpob")
  
  call modificar_cto(mod_cto_id,mod_cto_nom,mod_cto_tlf,mod_cto_mail,id_cli,idprov,idpob)
%>


</table> 
</body> 
</html> 