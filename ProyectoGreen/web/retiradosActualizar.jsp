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
        variables.put("id", request.getParameter("id") != null && !request.getParameter("id").trim().isEmpty() ? request.getParameter("id") : null);
        variables.put("identificacion", request.getParameter("identificacion") != null && !request.getParameter("identificacion").trim().isEmpty() ? request.getParameter("identificacion") : null);

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
                String valor = elemento.getString().trim();
                variables.put(elemento.getFieldName(), valor.isEmpty() ? null : valor);
            }
        }
    }

    if (variables.get("accion").equals("Modificar") || variables.get("accion").equals("Eliminar")) {
        if (variables.get("id") == null || variables.get("id").isEmpty()) {
            out.println("Error: ID no proporcionado para la acción " + variables.get("accion"));
            return;
        }
    }

    // Crear instancias de Persona y Retirados
    Persona persona = new Persona(variables.get("identificacion"));
    Retirados retirado = new Retirados(variables.get("id"));

    persona.setFechaRetiro(variables.get("fechaRetiro"));

    retirado.setIdentificacion(variables.get("identificacion"));
    retirado.setNumCaja(variables.get("numCaja"));
    retirado.setNumCarpeta(variables.get("numCarpeta"));
    retirado.setObservaciones(variables.get("observaciones"));

    // Ejecutar acción según el caso
    switch (variables.get("accion")) {
        case "Adicionar":
            persona.setTipo("R");
            persona.modificar(variables.get("identificacion")); // Asegura que se actualice en la BD
            retirado.grabar();
        break;
        case "Modificar":
            if (variables.get("id") != null) {
                persona.modificar(variables.get("identificacion"));
                retirado.modificar(variables.get("id"));
            } else {
                out.println("Error: ID no válido para modificar.");
                return;
            }
            break;
        case "Eliminar":
    if (variables.get("id") != null) {
        retirado.eliminar(variables.get("id")); 
    } else {
        out.println("Error: ID no válido para eliminar.");
        return;
    }
    break;

    }
%>

<script type="text/javascript">
    document.location = "retirados.jsp";
</script>
