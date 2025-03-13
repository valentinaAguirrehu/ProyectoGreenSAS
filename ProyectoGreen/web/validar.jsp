<%-- 
    Document   : validar
    Created on : 12/03/2025, 04:42:39 PM
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    
    String identificacion = request.getParameter("identificacion");
    String clave = request.getParameter("clave");
    Administrador usuario = Administrador.validar(identificacion, clave);
    if (usuario != null) {
        HttpSession sesion = request.getSession();
        sesion.setAttribute("usuario", usuario);
        sesion.setAttribute("tipo", usuario.getTipo()); 
        response.sendRedirect("principal.jsp");
    } else {
        response.sendRedirect("index.jsp?error=1");
    }
%>