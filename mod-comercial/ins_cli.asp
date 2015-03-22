<!--#include file="connectionbd.asp"-->
<!--#include file="funciones.asp"-->

<html> 
<head> 
   <title></title> 
   <meta http-equiv="refresh" content="2;URL=nue_cli.asp">
</head> 
<body> 
  <progress id="barra_progreso">
<% 
  Dim cod_cli,cif_cli,nom_cli,dir_cli,prov_cli,pob_cli,tlf_cli,id_cto,nom_cto,telf_cto,correo_cto,cad_prov,cad_pob
  cod_cli = request.form("codigo_cliente")
  cif_cli = request.form("cif")
  nom_cli = request.form("nombre")
  dir_cli = request.form("direccion")
  cad_prov = cstr(request.form("provincia"))
  cad_prov = split(cad_prov,"&")
  prov_cli = cad_prov(0)
  prov_cli = cstr(prov_cli)
  cad_pob = cstr(request.form("poblacion"))
  cad_pob = split(cad_pob,"&")
  pob_cli = cad_pob(0)
  pob_cli = cstr(pob_cli)
  tlf_cli = request.form("tlf_cli")
  id_cto = request.form("id_cto")
  nom_cto = request.form("nombre_cto")
  tlf_cto = request.form("tlf_cto")
  correo_cto = request.form("email_cto")
  'comprobaciones
  response.write(cod_cli)
  response.write("--")
  response.write(prov_cli)
  response.write("--")
  response.write(pob_cli)
  response.write("--")
  response.write(id_cto)

  call insertar_cliente(cod_cli,cif_cli,nom_cli,prov_cli,pob_cli,dir_cli,tlf_cli,id_cto,nom_cto,tlf_cto,correo_cto)
%>

  </progress>
</table> 
</body> 
</html> 