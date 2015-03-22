<!--#include file="connectionbd.asp"-->
<!--#include file="funciones.asp"-->
<html> 
<head> 
   <title></title> 
</head> 
<body> 
<% 
  Dim consulta,objRS,nombre_usuario,password
  nombre_usuario=request.form("username")
  password=request.form("password")

consulta = "select emp_nom, emp_pw from EMP"
set objRS = conexion.Execute(consulta)

   while (not objRS.Eof) 
       if objRS("emp_nom") = trim(nombre_usuario) and objRS("emp_pw") = trim(password) then
       'si todo es ok nos envia a otra pagina'
       session("autorizacion")=1
       response.redirect("inicio.asp")
       response.end
       else
       'si no coincide los datos o no existen error'
       session("autorizacion")=-1
       alert_formularios "USUARIO O CONTRASEÑA NO VÁLIDOS","warning"

       end if
      objRS.MoveNext 
   wend

   set objRS = nothing 
%>
</table> 
</body> 
</html> 