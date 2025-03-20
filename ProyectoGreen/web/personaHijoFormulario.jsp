<%-- 
    Document   : personaHijoFormulario
    Created on : 17/03/2025, 03:35:10 PM
    Author     : Mary
--%>


<%@ page import="clases.Persona, clases.Hijo, clases.PersonaHijo" %>
<%@ page import="java.util.List" %>
<html>

<body>
    <h2>Asignar Hijos a Persona</h2>

    <form action="personaHijos.jsp" method="post">
        <label>Seleccione Persona:</label>
        <select name="identificacionPersona">
            
            <%
    Persona persona = (Persona) request.getAttribute("persona");
    if (persona == null) {
        persona = new Persona(); // Evita NullPointerException
    }
    List<Hijo> hijos = persona.getHijos(); // Ahora no dará error
%>
            
        </select>
        <br>
<!-- Sección de familiares -->
<div id="familiaresSection" style="<%= hijos.isEmpty() ? "display: none;" : "display: block;" %>">
    <h4>Información de Hijos</h4>
    <table border="0" id="tablaHijos">
        <tr>
            <th>Nombre del Hijo</th>
            <th>Fecha de Nacimiento</th>
            <th>Acción</th>
        </tr>
        <% for (Hijo hijo : hijos) { %>
            <tr>
                <td>
                    <input type="hidden" name="idHijo[]" value="<%= hijo.getIdentificacion() %>">
                    <input type="text" name="nombreHijo[]" value="<%= hijo.getNombres() %>" size="50" maxlength="50">
                </td>
                <td>
                    <input type="date" name="fechaNacimientoHijo[]" value="<%= hijo.getFechaNacimiento() %>">
                </td>
                <td>
                    <button type="button" onclick="eliminarFila(this)">Eliminar</button>
                </td>
            </tr>
        <% } %>
    </table>

    <button type="button" onclick="agregarHijo()">Agregar Hijo</button>
</div>
    </form>
</body>
</html>
