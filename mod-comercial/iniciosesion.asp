<!--#include file="connectionbd.asp"-->

<html> 
<head> 
   <title></title> 
</head> 
<body> 
<% 
  Dim consulta,objRS,nombre,password
  nombre=request.form("username")
  password=request.form("password")

consulta = "select emp_nom, emp_pw from EMP"
set objRS = conexion.Execute(consulta)

   while (not objRS.Eof) 
       if objRS("emp_nom") = nombre and objRS("emp_pw") = password then
       'si todo es ok nos envia a otra pagina'
       response.redirect("inicio.asp")
       response.end
       else
       'si no coincide los datos o no existen error'
       response.write("usuario o contrasea erroneos")

       end if
      objRS.MoveNext 
   wend

   set objRS = nothing 
%>
</table> 
</body> 
</html> 