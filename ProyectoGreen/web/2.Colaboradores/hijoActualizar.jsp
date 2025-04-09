<%-- 
    Document   : hijosActualizar
    Created on : 17/03/2025, 04:12:52 PM
    Author     : Mary
--%>

<%@page import="clasesGenericas.ConectorBD"%>
<%@page import="clases.Hijo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Obtener los parámetros del formulario
    String accion = request.getParameter("accion");
    String identificacionPersona = request.getParameter("identificacionPersona");
    String identificacionHijoAnterior = request.getParameter("identificacionHijoAnterior");

    // Crear un objeto Hijo y asignarle los valores del formulario
    Hijo hijo = new Hijo();
    hijo.setIdentificacion(request.getParameter("identificacion"));
    hijo.setNombres(request.getParameter("nombres"));
    hijo.setFechaNacimiento(request.getParameter("fechaNacimiento"));

    switch (accion) {
        case "Adicionar":
            if (hijo.grabar()) { 
                String relSQL = "INSERT INTO persona_hijos (identificacionPersona, identificacionHijo) "
                              + "VALUES ('" + identificacionPersona + "', '" + hijo.getIdentificacion() + "')";
                ConectorBD.ejecutarQuery(relSQL);
            }
            break;

        case "Modificar":
            hijo.modificar(identificacionHijoAnterior);
            break;

        case "Eliminar":
            ConectorBD.ejecutarQuery("DELETE FROM persona_hijos WHERE identificacionPersona = '" + identificacionPersona + "' AND identificacionHijo = '" + hijo.getIdentificacion() + "'");
            ConectorBD.ejecutarQuery("DELETE FROM hijos WHERE identificacion = '" + hijo.getIdentificacion() + "'");
            break;
    }
%>

<script type="text/javascript">
    document.location = "hijo.jsp?identificacionPersona=<%= identificacionPersona %>";
</script>