<%-- 
    Document   : personaHijoActualizar
    Created on : 17/03/2025, 03:30:56 PM
    Author     : Mary
--%>

<%@ page import="clases.Persona, clases.Hijo, clases.PersonaHijo" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <title>Actualizar Hijos de Persona</title>
</head>
<body>
    <h2>Actualizar Hijos de Persona</h2>

    <%
        String mensaje = "";
        if (request.getMethod().equals("POST")) {
            try {
                int identificacionPersona = Integer.parseInt(request.getParameter("identificacionPersona"));
                int identificacionHijo = Integer.parseInt(request.getParameter("identificacionHijo"));

                // Verificar si el hijo ya está registrado para esta persona
                if (PersonaHijo.existeRelacion(identificacionPersona, identificacionHijo)) {
                    mensaje = "<p style='color: red;'>Este hijo ya está registrado para esta persona.</p>";
                } else {
                    PersonaHijo personaHijo = new PersonaHijo(identificacionPersona, identificacionHijo);
                    if (personaHijo.guardar()) {
                        mensaje = "<p style='color: green;'>Hijo registrado correctamente.</p>";
                    } else {
                        mensaje = "<p style='color: red;'>Error al registrar el hijo.</p>";
                    }
                }
            } catch (Exception e) {
                mensaje = "<p style='color: red;'>Error en la actualización: " + e.getMessage() + "</p>";
            }
        }
    %>

    <form action="personaHijosActualizar.jsp" method="post">
        <label>Seleccione Persona:</label>
        <select name="identificacionPersona">
            <%
                List<Persona> personas = Persona.getListaEnObjetos(null, "nombre");
                for (Persona p : personas) {
            %>
                <option value="<%= p.getIdentificacion() %>">
                    <%= p.getNombres() %>
                </option>
            <%
                }
            %>
        </select>
        <br>

        <label>Seleccione Hijo:</label>
        <select name="identificacionHijo">
            <%
                List<Hijo> hijos = Hijo.getListaEnObjetos(null, "nombre");
                for (Hijo h : hijos) {
            %>
                <option value="<%= h.getIdentificacionHijo() %>">
                    <%= h.getNombre() %> - <%= h.getFechaNacimiento() %>
                </option>
            <%
                }
            %>
        </select>
        <br>

        <input type="submit" value="Agregar Hijo">
    </form>

    <%= mensaje %>

</body>
</html>
