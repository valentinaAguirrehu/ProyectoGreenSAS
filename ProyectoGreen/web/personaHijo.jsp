<%-- 
    Document   : personaHijo
    Created on : 17/03/2025, 03:29:00 PM
    Author     : Mary
--%>

<%@ page import="clases.PersonaHijo" %>
<%@ page import="java.util.List" %>
<%
    int identificacionPersona = Integer.parseInt(request.getParameter("identificacionPersona"));
    int identificacionHijo = Integer.parseInt(request.getParameter("identificacionHijo"));

    // Verificar si el hijo ya está registrado para esta persona
    List<Integer> hijosRegistrados = PersonaHijo.obtenerHijosDePersona(identificacionPersona);
    
    if (hijosRegistrados.contains(identificacionHijo)) {
        out.println("<p style='color: red;'>Este hijo ya está registrado para esta persona.</p>");
    } else {
        PersonaHijo personaHijo = new PersonaHijo(identificacionPersona, identificacionHijo);
        if (personaHijo.guardar()) {
            out.println("<p style='color: green;'>Hijo registrado correctamente.</p>");
        } else {
            out.println("<p style='color: red;'>Error al registrar el hijo.</p>");
        }
    }
%>
