<html> 
<head> 
   <title></title>
   <link href="css/bootstrap-notify.css" rel="stylesheet" type="txt/css">
  <script src="jquery-2.1.3.min.js" type="text/javascript"></script>
   <meta http-equiv="refresh" content="2;URL=gest_comercial.asp">
   <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
</head> 
<body>
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
  Dim gc_id,gc_hora,gc_fec,gc_est,gc_emp,gc_pre,gc_cli,gc_cli_cto,gc_des

    gc_id=request.form("addv_gcid")
    gc_hora=request.form("addv_hora")
    gc_fec=request.form("addv_fecha")
    cad_est=request.form("addv_estado")
    cad_est=split(cad_est,"&")
    on error resume next
    gc_est=cad_est(0)
    gc_est=cstr(gc_est)
    cad_emp=request.form("addv_com")
    cad_emp=split(cad_emp,"&")
    on error resume next
    gc_emp=cad_emp(0)
    gc_emp=cstr(gc_emp)
    gc_pre=request.form("addv_pre")
    gc_cli=request.form("bus_idcli2")
    cad_cli_cto=request.form("addv_nomcto")
    cad_cli_cto=split(cad_cli_cto,"&")
    on error resume next
    gc_cli_cto=cad_cli_cto(0)
    gc_cli_cto=cstr(gc_cli_cto)
    gc_des=request.form("addv_desc")
    

  call insert_gescom(gc_id,gc_hora,gc_fec,gc_est,gc_emp,gc_pre,gc_cli,gc_cli_cto,gc_des)
%>


</table> 
</body> 
</html> 