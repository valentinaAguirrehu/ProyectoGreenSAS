<%-- 
    Document   : usuariosCerrarSesion
    Created on : 24 jun 2025, 22:32:25
    Author     : Angie
--%>

<%@page import="javax.servlet.ServletContext"%>
<%@page import="java.util.Map"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%
    String identificacion = request.getParameter("identificacion");
    ServletContext ctx = getServletContext(); 

    Map<String, HttpSession> sesiones = (Map<String, HttpSession>) ctx.getAttribute("sesionesActivas");

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
    alert("Sesión cerrada correctamente.");
    window.location.href = "usuarios.jsp";
</script>

