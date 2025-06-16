<%-- 
    Document   : prendaActualizar
    Created on : 10 abr 2025, 14:59:21
    Author     : Angie
--%>

<%@page import="clases.Prenda"%>
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
        variables.put("nombre", request.getParameter("nombre"));
        variables.put("id_tipo_prenda", request.getParameter("id_tipo_prenda"));
    } else {
        ServletRequestContext origen = new ServletRequestContext(request);
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> elementosFormulario = upload.parseRequest(origen);

        for (FileItem item : elementosFormulario) {
            if (item.isFormField()) {
                variables.put(item.getFieldName(), item.getString("UTF-8"));
            }
        }
    }

    Prenda prenda = new Prenda();
    prenda.setIdPrenda(variables.get("id"));
    prenda.setNombre(variables.get("nombre"));
    prenda.setIdTipoPrenda(variables.get("id_tipo_prenda"));

    switch (variables.get("accion")) {
        case "Adicionar":
            prenda.grabar();
            break;
        case "Modificar":
            prenda.modificar(variables.get("id"));
            break;
        case "Eliminar":
            prenda.eliminar(variables.get("id"));
            break;
    }
%>

<script type="text/javascript">
    document.location = "prenda.jsp";
</script>
