<%-- 
    Document   : vacacionesActualizar
    Created on : 11/04/2025, 05:38:37 PM
    Author     : VALEN
--%>

<%@page import="clases.Vacaciones"%>
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
        variables.put("idPersona", request.getParameter("idPersona"));
        variables.put("observacion", request.getParameter("observacion"));
        variables.put("estado", request.getParameter("estado"));
    } else {
        ServletRequestContext origen = new ServletRequestContext(request);
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> elementosFormulario = upload.parseRequest(origen);

        for (FileItem item : elementosFormulario) {
            if (item.isFormField()) {
                variables.put(item.getFieldName(), item.getString());
            }
        }
    }

    Vacaciones vacacion = new Vacaciones();
    vacacion.setId(variables.get("id"));
    vacacion.setIdPersona(variables.get("idPersona"));
    vacacion.setObservacion(variables.get("observacion"));
    vacacion.setEstado(variables.get("estado"));

    switch (variables.get("accion")) {
        case "Adicionar":
            vacacion.grabar();
            break;
        case "Modificar":
            vacacion.modificar(variables.get("id"));
            break;
        case "Eliminar":
            vacacion.eliminar(variables.get("id"));
            break;
    }
%>

<script type="text/javascript">
    document.location = "verRegistrosVacaciones.jsp?identificacion=<%= variables.get("idPersona") %>";
</script>
