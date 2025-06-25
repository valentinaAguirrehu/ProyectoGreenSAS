<%-- 
    Document   : usuariosCerrarSesion
    Created on : 24 jun 2025, 22:32:25
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String identificacion = request.getParameter("identificacion");
    Administrador usuario = new Administrador(identificacion);
    usuario.setEstado("Inactivo");
    usuario.modificar(identificacion); 

    Map<String, HttpSession> sesiones = (Map<String, HttpSession>) application.getAttribute("sesionesActivas");
    if (sesiones != null) {
        HttpSession sesionUsuario = sesiones.get(identificacion);
        if (sesionUsuario != null) {
            try {
                sesionUsuario.invalidate();
            } catch (IllegalStateException e) {
            }
            sesiones.remove(identificacion);
        }
    }
%>

<script>
    alert("Sesión cerrada correctamente y usuario marcado como inactivo.");
    window.location.href = "usuarios.jsp";
</script>

