<%-- 
    Document   : personaVehiculo
    Created on : 13/03/2025, 09:32:07 PM
    Author     : Mary
--%>
<%@ page import="clases.PersonaVehiculo" %>
<%
    int identificacionPersona = Integer.parseInt(request.getParameter("identificacionPersona"));
    String numeroPlacaVehiculo = request.getParameter("numeroPlacaVehiculo");

    if (PersonaVehiculo.existeRelacion(identificacionPersona)) {
        out.println("<p style='color: red;'>Esta persona ya tiene un vehículo asignado.</p>");
    } else {
        PersonaVehiculo personaVehiculo = new PersonaVehiculo(identificacionPersona, numeroPlacaVehiculo);
        if (personaVehiculo.guardar()) {
            out.println("<p style='color: green;'>Vehículo asignado correctamente.</p>");
        } else {
            out.println("<p style='color: red;'>Error al asignar el vehículo.</p>");
        }
    }
%>