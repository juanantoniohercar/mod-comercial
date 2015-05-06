<!--#include file ="funciones.asp"-->
<%
if session("autorizacion") <> 1 then response.redirect("Default.asp") end if

function busqueda()
dim dnicif, nombre, domicilio, localidad, SQL_busclis, conversion
dnicif=request.querystring("bus_dnicif")
nombre=trim(request.querystring("bus_nombre"))
domicilio=trim(request.querystring("bus_dom"))
localidad=trim(request.querystring("bus_localidad"))

if dnicif <> "" then
	SQL_buscli="select * from CLI where cli_cif='"&dnicif&"'"
	set RS_buscli = createobject("ADODB.Recordset")
	RS_buscli.open SQL_buscli, Conexion
	
	'Funcion para crear trabla de busqueda'
	call creartabla_bus(RS_buscli,dnicif,nombre,domicilio,localidad)

	elseif nombre <> "" then
	SQL_buscli="select * from CLI where cli_nom like '%"&nombre&"%'"
	set RS_buscli = createobject("ADODB.Recordset")
	RS_buscli.open SQL_buscli, Conexion
	
	'Función para crear trbala de busqueda'
	call creartabla_bus(RS_buscli,dnicif,nombre,domicilio,localidad)

	elseif domicilio <> "" then
	SQL_buscli="select * from CLI where cli_dir like '%"&domicilio&"%'"
	set RS_buscli = createobject("ADODB.Recordset")
	RS_buscli.open SQL_buscli, Conexion
	
	'Función para crear trbala de busqueda'
	call creartabla_bus(RS_buscli,dnicif,nombre,domicilio,localidad)

	elseif localidad <> "" then
	SQL_buscli="select * from POB, CLI where CLI.cli_pob=POB.pob_id AND POB.pob_nom like '%"&localidad&"%'"
	set RS_buscli = createobject("ADODB.Recordset")
	RS_buscli.open SQL_buscli, Conexion

	'Función para crear trbala de busqueda'
	call creartabla_bus(RS_buscli,dnicif,nombre,domicilio,localidad)
end if
end function
%>

