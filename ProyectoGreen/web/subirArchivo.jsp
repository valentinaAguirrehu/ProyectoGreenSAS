<%-- 
    Document   : subirArchivo
    Created on : 11/03/2025, 05:18:55 PM
    Author     : VALEN
--%>

<%@ page import="java.io.File, java.util.List" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.FileItem" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext" %>

<%
    String rutaArchivos = getServletContext().getRealPath("/") + "uploads/";
    File destino = new File(rutaArchivos);

    if (!destino.exists()) {
        destino.mkdirs();
    }

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    String rutaArchivoGuardado = "";

    if (isMultipart) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));

        for (FileItem item : items) {
            if (!item.isFormField()) {
                String nombreArchivo = new File(item.getName()).getName();
                if (!nombreArchivo.isEmpty()) {
                    File archivoGuardado = new File(destino, nombreArchivo);
                    item.write(archivoGuardado);
                    rutaArchivoGuardado = "uploads/" + nombreArchivo;
                }
            }
        }
    }

    out.print(rutaArchivoGuardado);
%>
