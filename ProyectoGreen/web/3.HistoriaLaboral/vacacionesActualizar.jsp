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
        variables.put("periodoDisfrute", request.getParameter("periodoDisfrute"));
        variables.put("periodoDisfruteFin", request.getParameter("periodoDisfruteFin"));
        variables.put("diasDisfrutados", request.getParameter("diasDisfrutados"));
        variables.put("diasCompensados", request.getParameter("diasCompensados"));
        variables.put("diasCompensar", request.getParameter("diasCompensar"));
        variables.put("observacion", request.getParameter("observacion"));
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
    vacacion.setIdVacaciones(variables.get("id"));
    vacacion.setIdPersona(variables.get("idPersona"));
    vacacion.setPeriodoDisfrute(variables.get("periodoDisfrute"));
    vacacion.setPeriodoDisfruteFin(variables.get("periodoDisfruteFin"));
    vacacion.setDiasDisfrutados(variables.get("diasDisfrutados"));
    vacacion.setDiasCompensados(variables.get("diasCompensados"));
    vacacion.setDiasCompensar(variables.get("diasCompensar"));
    String observacion = variables.get("observacion");
    if (observacion != null && observacion.trim().isEmpty()) {
        vacacion.setObservacion(null); 
    } else {
        vacacion.setObservacion(observacion);
    }

    // Acciones según el tipo de operación
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
