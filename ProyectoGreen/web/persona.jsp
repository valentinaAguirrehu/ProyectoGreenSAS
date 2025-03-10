<%-- 
    Document   : persona
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
   

    List<Persona> datos = Persona.getListaEnObjetos(null, null);
  
    String lista = "";
    for (int i = 0; i < datos.size(); i++) {
        Persona persona = datos.get(i);
        lista += "<tr>";
        lista += "<td>" + persona.getIdentificacion() + "</td>";
        lista += "<td>" + persona.getNombres() + "</td>";
        lista += "<td>" + persona.getApellidos() + "</td>";
        lista += "<td>" + persona.getIdCargo() + "</td>";
        lista += "<td>";
        lista += "<a href='principal.jsp?CONTENIDO=personaFormulario.jsp&accion=Modificar&identificacion=" + persona.getIdentificacion() +
                 "' title='Modificar'><img src='iconos/editar.png'></a> ";
        lista += "<img src='iconos/borrar.png' title='Eliminar' onClick='eliminar(" + persona.getIdentificacion() + ")'> ";
        lista += "<img src='iconos/verDetalles.png' title='Ver Detalles' onClick='verDetalles(" + persona.getIdentificacion() + ")'> ";
        lista += "</td>";
        lista += "</tr>";
    }
%>

<h3>LISTA DE COLABORADORES</h3>
<table id="ejemplo02" border="1">
    <tr>
        <th>Identificación</th><th>Nombres</th><th>Apellidos</th><th>Cargo</th><th>Acciones</th>
    </tr>
    <%= lista %> <!-- Aquí se genera la lista dinámica -->
</table>
    
</div>

<script type="text/javascript">
    function eliminar(identificacion) {
        var respuesta = confirm("¿Realmente desea eliminar el registro con la identificación " + identificacion + "?");
        if (respuesta) {
            document.location = "principal.jsp?CONTENIDO=personaActualizar.jsp&accion=Eliminar&identificacion=" + identificacion;
        }
    }

    function verDetalles(identificacion) {
        document.location = "principal.jsp?CONTENIDO=personaDetalles.jsp&identificacion=" + identificacion;
    }
</script>

<p>
    <input type="button" value="Cancelar" onClick="window.history.back()">
</p>
