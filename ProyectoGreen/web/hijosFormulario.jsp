<%-- 
    Document   : hijosFormulario
    Created on : 7/03/2025, 09:16:00 AM
    Author     : Mary
--%>
<%@ page import="clases.Hijos" %>
<%
    // Obtener parámetros y datos de Hijos
    String accion = request.getParameter("accion");
    String id = "Sin generar";  // valor por defecto
    Hijos hijos = new Hijos();  // Crear un nuevo objeto Hijos

    // Si la acción es "Modificar", obtener el ID y cargar los datos del hijo
    if (accion != null && accion.equals("Modificar")) {
        id = request.getParameter("id"); // Obtener el ID desde la URL
        hijos = new Hijos(id);  // Asumiendo que la clase Hijos tiene un constructor que acepta el ID
        // Aquí puedes obtener los datos del hijo usando getters, por ejemplo:
        // hijos.setId(id);
        // hijos.setNombre("Juan");
        // hijos.setFechaNacimiento("01/01/2010");
    }
%>

<h3><%= accion != null ? accion.toUpperCase() : "AGREGAR" %> CATEGORIA</h3>

<form name="formulario" method="post" action="principal.jsp?CONTENIDO=hijosActualizar.jsp">
    <table border="0">
        <tr>
            <th>Id</th>
            <td><%= hijos.getId() %></td> <!-- Muestra el ID del hijo -->
        </tr>
        <tr>
            <th>Nombre</th>
            <td><input type="text" name="nombre" value="<%= hijos.getNombre() %>"> </td> <!-- Muestra el nombre -->
        </tr>   
        <tr>
            <th>Fecha de nacimiento</th>
            <td><input type="text" name="fechaNacimiento" value="<%= hijos.getFechaNacimiento() %>"> </td> <!-- Muestra la fecha de nacimiento -->
        </tr>
    </table>

    <input type="hidden" name="id" value="<%= hijos.getId() %>"> <!-- Pasa el ID en el formulario -->
    <input type="submit" name="accion" value="<%= accion != null ? accion : "Agregar" %>"> <!-- Define la acción -->
    <input type="button" value="Cancelar" onClick="window.history.back()"> <!-- Botón para cancelar -->
</form>
