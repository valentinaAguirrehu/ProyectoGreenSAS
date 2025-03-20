<%-- 
    Document   : hijo
    Created on : 9/03/2025, 03:53:09 PM
    Author     : Mary
--%>
<%@page import="java.util.List"%>
<%@page import="clases.Hijo"%>

<%
    String lista = "";
    List<Hijo> datos = Hijo.getListaEnObjetos(null, null);

    for (Hijo hijo : datos) {
        lista += "<tr>";
        lista += "<td>" + hijo.getIdentificacion() + "</td>";
        lista += "<td>" + hijo.getNombres() + "</td>";
        lista += "<td>" + hijo.getFechaNacimiento() + "</td>";
        lista += "<td>";
        lista += "<a href='hijoFormulario.jsp?accion=Modificar&identificacion=" + hijo.getIdentificacion() + "' title='Modificar'><img src='presentacion/iconos/modificar.png'></a> ";
        lista += "<img src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(\"" + hijo.getIdentificacion() + "\")'> ";
        lista += "</td>";
        lista += "</tr>";
    }
%>

<h3>LISTA DE HIJOS</h3>
<table border="1">
    <tr>
        <th>Identificación</th>
        <th>Nombres</th>
        <th>Apellidos</th>
        <th>Fecha de Nacimiento</th>
        <th>Acciones</th>
    </tr>
    <%= lista %>
</table>

<div class="add-button">
    <a href="hijoFormulario.jsp?accion=Adicionar" title="Agregar">
        <img src='presentacion/iconos/agregar.png' alt="Agregar" style="width: 20px; vertical-align: middle;"> Agregar Hijo
    </a>
</div>

<script type="text/javascript">
    function eliminar(identificacion) {
        let respuesta = confirm("¿Realmente desea eliminar este hijo?");
        if (respuesta) {
            document.location = "hijoActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
</script>

<p>
    <input type="button" value="Cancelar" onClick="window.history.back()">
</p>
