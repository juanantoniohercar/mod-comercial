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
   <script language="JavaScript">
  function redireccionar() {
    setTimeout("location.href='mod_cli.asp?id=' + form_modificar_cli.codigo_cliente.value + '&provincia=' + form_modificar_cli.provincia.options[form_modificar_cli.provincia.selectedIndex].value + '&poblacion=' + form_modificar_cli.poblacion.options[form_modificar_cli.poblacion.selectedIndex].value + 'mostrar=' + 0", 3000);
  }
  </script>
</head> 
<body>
  <% pag=9 %>
  <!--#include file="menu.asp"-->
  <!--#include file="funciones.asp"-->
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
  Dim cod_cli,cif_cli,nom_cli,dir_cli,prov_cli,pob_cli,tlf_cli,cad_prov,cad_pob
  cod_cli = request.form("codigo_cliente")
  cif_cli = request.form("cif")
  nom_cli = request.form("nombre")
  dir_cli = request.form("direccion")
  cad_prov = cstr(request.form("provincia"))
  cad_prov = split(cad_prov,"&")
  on error resume next
  prov_cli = cad_prov(0)
  prov_cli = cstr(prov_cli)
  cad_pob = cstr(request.form("poblacion"))
  cad_pob = split(cad_pob,"&")
  on error resume next
  pob_cli = cad_pob(0)
  pob_cli = cstr(pob_cli)
  tlf_cli = request.form("tlf_cli")

  call modificar_cli(cod_cli,cif_cli,nom_cli,prov_cli,pob_cli,dir_cli,tlf_cli)
%>


</table> 
</body> 
</html> 