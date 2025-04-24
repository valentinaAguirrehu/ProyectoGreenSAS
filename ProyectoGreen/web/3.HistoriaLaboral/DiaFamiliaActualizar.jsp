<%@page import="clases.DiaFamilia"%>
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
        variables.put("idPersona", request.getParameter("IdentificacionPersona1"));
        variables.put("diaDisfrutado", request.getParameter("diaDisfrutado"));
        variables.put("cartaFamilia", request.getParameter("cartaFamilia"));
        variables.put("observacion", request.getParameter("observacion"));
    } else {
        ServletRequestContext origen = new ServletRequestContext(request);
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> elementosFormulario = upload.parseRequest(origen);

        for (FileItem item : elementosFormulario) {
            if (item.isFormField()) {
                String fieldName = item.getFieldName();
                String fieldValue = item.getString("UTF-8");
                variables.put(fieldName, fieldValue);
            }
        }
    }

    DiaFamilia diaFamilia = new DiaFamilia();
    diaFamilia.setIdDiaFamilia(variables.get("id"));
    diaFamilia.setIdentificacionPersona1(variables.get("idPersona"));
    diaFamilia.setDiaDisfrutado(variables.get("diaDisfrutado"));
    diaFamilia.setCartaFamilia(variables.get("cartaFamilia"));

    String observacion = variables.get("observacion");
    if (observacion != null && observacion.trim().isEmpty()) {
        diaFamilia.setObservacion(null);
    } else {
        diaFamilia.setObservacion(observacion);
    }

    switch (variables.get("accion")) {
        case "Adicionar":
            diaFamilia.grabar();
            break;
        case "Modificar":
            diaFamilia.modificar(variables.get("id"));
            break;
        case "Eliminar":
            diaFamilia.eliminar(variables.get("id"));
            break;
    }

    // Redirigir siempre con la identificación del colaborador
    String redireccion = "verRegistroDiaFamlia.jsp?identificacion=" + variables.get("idPersona");
%>
<%
    // Verificación de parámetros antes de usar
    String idPersona = variables.get("idPersona");
    if (idPersona == null || idPersona.trim().isEmpty()) {
        out.println("Error: idPersona es null o vacío.");
    } else {
        out.println("idPersona: " + idPersona);
    }
%>

<script type="text/javascript">
    document.location = "<%= redireccion %>";
</script>
