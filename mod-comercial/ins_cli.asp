<html> 
<head> 
   <title></title>
   <link href="css/bootstrap-notify.css" rel="stylesheet" type="txt/css">
  <script src="jquery-2.1.3.min.js" type="text/javascript"></script>
   <meta http-equiv="refresh" content="2;URL=nue_cli.asp">
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
  Dim cod_cli,cif_cli,nom_cli,dir_cli,prov_cli,pob_cli,tlf_cli,id_cto,nom_cto,telf_cto,correo_cto,cad_prov,cad_pob,contador
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
  call insertar_cliente(cod_cli,cif_cli,nom_cli,prov_cli,pob_cli,dir_cli,tlf_cli)
  
  contador = cint(request.form("contador"))
  for i=0 to contador step 1
    id_cto = request.form("id_cto"&i)
    nom_cto = request.form("nombre_cto"&i)
    tlf_cto = request.form("tlf_cto"&i)
    correo_cto = request.form("email_cto"&i)  
    call insertar_contactos(id_cto,cod_cli,nom_cto,tlf_cto,correo_cto)
  next
  
%>


</table> 
</body> 
</html> 