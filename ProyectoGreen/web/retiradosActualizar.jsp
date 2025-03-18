<%@page import="clases.Persona"%>
<%@page import="clases.Retirados"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Crear mapa para almacenar los valores del formulario
    Map<String, String> variables = new HashMap<>();
    boolean isMultipart = request.getContentType() != null && request.getContentType().startsWith("multipart/form-data");

    if (!isMultipart) {
        // Si no es multipart, obtener valores directamente del request
        variables.put("accion", request.getParameter("accion"));
        variables.put("identificacion", request.getParameter("identificacion"));
        variables.put("cargo", request.getParameter("cargo"));
        variables.put("numCaja", request.getParameter("numCaja"));
        variables.put("numCarpeta", request.getParameter("numCarpeta"));
        variables.put("observaciones", request.getParameter("observaciones"));
    }

    // Obtener los datos de Persona y Retirados usando la identificación
    Persona persona = new Persona(variables.get("identificacion"));
    Retirados retirado = new Retirados(variables.get("identificacion"));

    if ("Adicionar".equals(variables.get("accion"))) {
        // Solo creamos un nuevo registro de retirado si Persona ya existe
        if (persona.getIdentificacion() != null) {
            retirado.setIdentificacionPersona(variables.get("identificacion"));
            retirado.setNombreCargo(variables.get("cargo"));
            retirado.setNumCaja(variables.get("numCaja"));
            retirado.setNumCarpeta(variables.get("numCarpeta"));
            retirado.setObservaciones(variables.get("observaciones"));
            retirado.grabar();
        }
    } else if ("Modificar".equals(variables.get("accion"))) {
        if (retirado.getIdentificacionPersona() != null) {
            retirado.setNombreCargo(variables.get("cargo"));
            retirado.setNumCaja(variables.get("numCaja"));
            retirado.setNumCarpeta(variables.get("numCarpeta"));
            retirado.setObservaciones(variables.get("observaciones"));
            retirado.modificar();
        }
    } else if ("Eliminar".equals(variables.get("accion"))) {
        if (retirado.getIdentificacionPersona() != null) {
            retirado.eliminar();
        }
    }
%>

<script type="text/javascript">
    document.location = "retirados.jsp";
</script>
