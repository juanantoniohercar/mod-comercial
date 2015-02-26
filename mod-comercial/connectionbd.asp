<%
Dim Conexion, Cadena, ADOpersonas, MiId, MiNombre

'Creamos los objetos, una conexión y un Recordset'

Set Conexion = CreateObject("ADODB.Connection")

'Se establece la cadena de conexión'
Cadena="driver={SQL Server}; server=JANTONIO-PC\SQLEXPRESS; database=bdMod_comercial; uid=Moneleg; pwd=Moneleg"
	
'Abrimos la conexión'
Conexion.Open Cadena
response.write Conexion
%>

