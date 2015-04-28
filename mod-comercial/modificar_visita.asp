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
   
  </script>
</head> 
<body>
  <% pag=9 %>
  <!--#include file="menu.asp"-->
  <!--#include file="funciones.asp"-->
  <div class="progress progress-striped active">
  <div class="progress-bar" role="progressbar"
       aria-valuenow="45" aria-valuemin="20" aria-valuemax="100"
       style="width: 100%">
    <span class="sr-only">100% completado</span>
  </div>
</div>
<%
  Dim gc_id, gc_hora, gc_fec, gc_est, gc_emp, gc_pre, gc_cli, gc_cli_cto, gc_des
    
    gc_id=request.form("modv_ges_com_id")
    gc_hora=request.form("modv_hora")
    gc_fec=request.form("modv_fecha")
    cad_est=request.form("modv_estado")
    cad_est=split(cad_est, "&")
    on error resume next
    gc_est=cad_est(0)
    gc_est=cstr(gc_est)
    cad_emp=request.form("modv_com")
    cad_emp=split(cad_emp, "&")
    on error resume next
    gc_emp=cad_emp(0)
    gc_emp=cstr(gc_emp)
    gc_pre=request.form("modv_pre")
    gc_cli=request.form("modv_idcli")
    cad_cli_cto=request.form("modv_nomcto")
    cad_cli_cto=split(cad_cli_cto, "&")
    on error resume next
    gc_cli_cto=cad_cli_cto(0)
    gc_cli_cto=cstr(gc_cli_cto)
    gc_des=request.form("modv_desc")


  call mod_visita(gc_id,gc_hora,gc_fec, gc_est,gc_emp,gc_pre,gc_cli,gc_cli_cto,gc_des)
%>


</table> 
</body> 
</html> 