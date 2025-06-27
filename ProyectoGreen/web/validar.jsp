<%-- 
    Document   : validar
    Created on : 12/03/2025, 04:42:39 PM
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%@page import="utils.SessionTracker"%>  

<%
    String identificacion = request.getParameter("identificacion");
    String clave          = request.getParameter("clave");

    Administrador usuario = Administrador.validar(identificacion, clave);

    if (usuario == null) {
        response.sendRedirect("index.jsp?error=1");        
    } else if ("Inactivo".equalsIgnoreCase(usuario.getEstado())) {
        response.sendRedirect("index.jsp?error=2");         
    } else {
        SessionTracker.registrarSesion(usuario.getIdentificacion(), session);
        session.setAttribute("usuario", usuario);
        response.sendRedirect("politicas.jsp");
    }
%>

