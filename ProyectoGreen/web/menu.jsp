<%-- 
    Document   : menu
    Created on : 22 mar 2025, 22:48:40
    Author     : Angie
--%>

<%@ page import="clases.Administrador" %>

<div class="logo-container">
    <img src="presentacion/imagenes/LogoGreen.png" alt="Logo de Green">
</div>

<%
    Administrador usuarioMenu = (Administrador) session.getAttribute("usuario");
    String tipoUsuario = (usuarioMenu != null) ? usuarioMenu.getTipo() : "";
%>

<div class="logo-container">
    <img src="presentacion/imagenes/LogoGreen.png" alt="Logo de Green">
</div>

<nav class="sidebar">
    <link rel="stylesheet" href="presentacion/style-Menu.css">
    <ul>
        <li><a href="principal.jsp">Inicio</a></li>
        <li><a href="cargos.jsp">Cargos</a></li>

        <li class="dropdown">
            <a href="#">Colaboradores<img src="presentacion/iconos/flecha.png" alt="Icono flecha" class="icono-menu"></a>
            <ul class="dropdown-content">                           
                <li><a href="persona.jsp">Activos</a></li>
                <li><a href="temporales.jsp">Temporales</a></li>
                <li><a href="aprendiz.jsp">Aprendices</a></li>
                <li><a href="retirados.jsp">Retirados</a></li>
            </ul>
        </li>
        <li><a href="#">Dotaciones</a></li>
        <li class="dropdown">
            <a href="#">Reportes e indicadores<img src="presentacion/iconos/flecha.png" alt="Icono flecha" class="icono-menu"></a>
            <ul class="dropdown-content">                           
                <li><a href="#">Ingresos de colaboradores</a></li>
                <li><a href="#">Retiros de colaboradores</a></li>
                <li><a href="#">Dotaciones entregadas</a></li>
                <li><a href="cumpleanos.jsp">Cumpleañeros del mes</a></li>
            </ul>
        </li>
    </ul>
    <ul class="bottom-menu">
        <% if ("S".equals(tipoUsuario)) { %>
            <li><a href="usuarios.jsp">Usuarios</a></li>
        <% } %>
        <li><a href="perfil.jsp">Perfil</a></li>
        <li><a href="index.jsp">Cerrar sesión</a></li>
    </ul>
</nav>
