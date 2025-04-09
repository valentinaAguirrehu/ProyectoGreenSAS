<%-- 
    Document   : CargosAct
    Created on : 8 mar 2025, 18:49:10
    Author     : Angie
--%>

<%@page import="clases.Cargo"%>
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
        variables.put("codigoCargo", request.getParameter("codigoCargo"));
        variables.put("descripcion", request.getParameter("descripcion"));
    } else {
        ServletRequestContext origen = new ServletRequestContext(request);
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> elementosFormulario = upload.parseRequest(origen);
        
        for (FileItem elemento : elementosFormulario) {
            if (elemento.isFormField()) {
                variables.put(elemento.getFieldName(), elemento.getString());
            }
        }
    }
    
    Cargo cargo = new Cargo();
    cargo.setId(variables.get("id"));
    cargo.setNombre(variables.get("nombre"));
    cargo.setCodigoCargo(variables.get("codigoCargo"));
    cargo.setDescripcion(variables.get("descripcion"));
    
    switch (variables.get("accion")) {
        case "Adicionar":
            cargo.grabar();
            break;
        case "Modificar":
            cargo.modificar(variables.get("id"));
            break;
        case "Eliminar":
            cargo.eliminar(variables.get("id"));
            break;
    }
%>
<script type="text/javascript">
    document.location = "cargos.jsp";
</script>
