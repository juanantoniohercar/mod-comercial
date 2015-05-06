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

    'id_cli=request.querystring("id")
    'id_prov=request.querystring("provincia")
    '' call datos_cli_cto(id_cli, "CLI")
    'idprov = CStr(idprov)
     
    
  %>
  
  <div class="progress progress-striped active">
  <div class="progress-bar" role="progressbar"
       aria-valuenow="45" aria-valuemin="20" aria-valuemax="100"
       style="width: 100%">
    <span class="sr-only">100% completado</span>
  </div>
</div>
<% 
  Dim add_cto_id,add_cto_cli,add_cto_nom,add_cto_tlf,add_cto_mail
  add_cto_id = request.form("idcontacto")
  add_cto_cli = request.form("idcontacto_cli")
  add_cto_nom = request.form("nombcto")
  add_cto_tlf = request.form("telcto")
  add_cto_mail = request.form("mailcto")
  id_cli = request.form("valor_idcli2")
  idprov = request.form("valor_idprov2")
  idpob = request.form("valor_idpob2")
  call add_cto(add_cto_id,add_cto_cli,add_cto_nom,add_cto_tlf,add_cto_mail,id_cli,idprov,idpob)
%>


</table> 
</body> 
</html> 