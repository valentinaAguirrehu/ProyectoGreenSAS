<%@page import="clasesGenericas.ConectorBD"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Retirados"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Map<String, String> variables = new HashMap<>();
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    if (!isMultipart) {
        variables.put("accion", request.getParameter("accion"));
        variables.put("id", request.getParameter("id"));
        variables.put("identificacion", request.getParameter("identificacion"));
        variables.put("fechaRetiro", request.getParameter("fechaRetiro"));
        variables.put("numCaja", request.getParameter("numCaja"));
        variables.put("numCarpeta", request.getParameter("numCarpeta"));
        variables.put("observaciones", request.getParameter("observaciones"));
    } else {
        ServletRequestContext origen = new ServletRequestContext(request);
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> elementosFormulario = upload.parseRequest(origen);

        for (FileItem elemento : elementosFormulario) {
            if (elemento.isFormField()) {
                variables.put(elemento.getFieldName(), elemento.getString().trim());
            }
        }
    }

    if (variables.get("identificacion") == null || variables.get("identificacion").trim().isEmpty()) {
        return;
    }

    Persona persona = new Persona(variables.get("identificacion"));
    persona.setFechaRetiro(variables.get("fechaRetiro"));
    persona.setTipo("R");

    Retirados retirado = new Retirados(variables.get("id"));
    retirado.setIdentificacionPersona(variables.get("identificacion"));
    retirado.setNumCaja(variables.get("numCaja"));
    retirado.setNumCarpeta(variables.get("numCarpeta"));
    retirado.setObservaciones(variables.get("observaciones"));

    switch (variables.get("accion")) {
        case "Adicionar":
            persona.setTipo("R"); // Cambiar tipo a "R"
            persona.modificar(variables.get("identificacion")); // Guardar en la BD 
            retirado.grabar(); // Insertar en la tabla 'retirados'
            break;
        case "Modificar":
             if (variables.get("id") != null && variables.get("fechaRetiro") != null) {
                String nuevaFechaRetiro = variables.get("fechaRetiro");
                String numCaja = variables.get("numCaja");
                String numCarpeta = variables.get("numCarpeta");
                String observaciones = variables.get("observaciones");
                String cadenaSQL = "UPDATE persona SET fechaRetiro = '" + nuevaFechaRetiro + "' WHERE identificacion = '" + variables.get("identificacion") + "'";
                boolean actualizado = ConectorBD.ejecutarQuery(cadenaSQL);        
             if (actualizado) {
                String cadenaSQLRetirados = "UPDATE retirados SET numCaja = '" + numCaja + "', numCarpeta = '" + numCarpeta + "', observaciones = '" + observaciones + "' WHERE id = '" + variables.get("id") + "'";
                ConectorBD.ejecutarQuery(cadenaSQLRetirados);
                    }
                }
            break;
        case "Eliminar":
            if (variables.get("id") != null) {
                retirado.eliminar(variables.get("id"));
            }
            break;
    }
%>

<script type="text/javascript">
    document.location = "retirados.jsp";
</script>