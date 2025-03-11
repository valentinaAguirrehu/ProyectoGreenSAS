<%-- 
    Document   : persona
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="java.util.List"%> 
<%@page import="clases.Persona"%>

<%
    String lista = ""; 
    List<Persona> datos = Persona.getListaEnObjetos(null, null); 

 
    for (int i = 0; i < datos.size(); i++) {
        Persona persona = datos.get(i);
        lista += "<tr>";
        lista += "<td align='right'>" + persona.getIdentificacion() + "</td>"; 
        lista += "<td>" + persona.getNombres() + "</td>"; 
        lista += "<td>" + persona.getApellidos() + "</td>"; 
        lista += "<td>" + persona.getIdCargo()+ "</td>"; 
        lista += "<td>";
        lista += "<a href='principal.jsp?CONTENIDO=personaFormulario.jsp&accion=Modificar&id=" + persona.getIdentificacion() + "' title='Modificar'><img src='iconos/editar.png'/></a>"; 
        lista+="<img src='iconos/borrar.png'  title='Eliminar' onClick='eliminar("+ persona.getIdentificacion()+")'> ";
        lista+="</td>";
        lista += "</tr>";
    }
%>

<h3>LISTA DE COLABORADORES</h3>
<table border="1">
    <tr>
        <th>Identificación</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Cargo</th>
        <th>Acciones</th>
        
    <div class="add-button">
    <a href="principal.jsp?CONTENIDO=personaFormulario.jsp&accion=Adicionar" title="Agregar">
        <img src="iconos/agregar.png" alt="Agregar" style="width: 20px; vertical-align: middle;"> Agregar Categorias
    </a>
    </div>
    </tr>
    <%= lista %> 
</table>

<script type="text/javascript">
    function eliminar(id) {
        respuesta = confirm("Realmente desea eliminar el registro de él colaborador?");
        if (respuesta) {
            document.location = "principal.jsp?CONTENIDO=personaActualizar.jsp&accion=Eliminar&id="+id; 
        }
    }
</script>
<input type="button" value="Cancelar" onClick="window.history.back()">
