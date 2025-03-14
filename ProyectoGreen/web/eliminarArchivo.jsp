<%-- 
    Document   : eliminarArchivo
    Created on : 13/03/2025, 03:03:16 PM
    Author     : VALEN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>

<%
    String nombreArchivo = request.getParameter("archivo");
    String rutaArchivos = getServletContext().getRealPath("/") + "uploads/";
    
    out.println("Nombre del archivo: " + nombreArchivo + "<br>");
    out.println("Ruta completa: " + rutaArchivos + nombreArchivo + "<br>");

    File archivo = new File(rutaArchivos + nombreArchivo);
    boolean eliminado = false;

    if (archivo.exists()) {
        eliminado = archivo.delete();
        out.println("¿Archivo eliminado?: " + eliminado + "<br>");
    } else {
        out.println("El archivo no existe en la ruta especificada.<br>");
    }

    response.setContentType("application/json");
    out.print("{\"eliminado\": " + eliminado + "}");
%>

