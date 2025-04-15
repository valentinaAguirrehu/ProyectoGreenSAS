<%-- 
    Document   : menu
    Created on : 22 mar 2025, 22:48:40
    Author     : Angie
--%>

<%@ page import="clases.Administrador" %>
<title>GREEN S.A.S.</title>

<div class="logo-container">
    <img src="../presentacion/imagenes/LogoGreen.png" alt="Logo de Green">
</div>

<%
    Administrador usuarioMenu = (Administrador) session.getAttribute("usuario");
    String tipoUsuario = (usuarioMenu != null) ? usuarioMenu.getTipo() : "";
%>

<div class="logo-container">
    <img src="../presentacion/imagenes/LogoGreen.png" alt="Logo de Green">
</div>

<nav class="sidebar">
    <link rel="stylesheet" href="../presentacion/style-Menu.css">
    <ul>
        <li><a href="../1.Cargos/principal.jsp">Inicio</a></li>
        <li><a href="../1.Cargos/cargos.jsp">Cargos</a></li>

        <li class="dropdown">
            <a>Colaboradores<img src="../presentacion/iconos/flecha.png" alt="Icono flecha" class="icono-menu"></a>
            <ul class="dropdown-content">                           
                <li><a href="../2.Colaboradores/persona.jsp">Activos</a></li>
                <li><a href="../2.Colaboradores/temporales.jsp">Temporales</a></li>
                <li><a href="../2.Colaboradores/aprendiz.jsp">Aprendices</a></li>
                <li><a href="../2.Colaboradores/retirados.jsp">Retirados</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a>Dotaciones<img src="../presentacion/iconos/flecha.png" alt="Icono flecha" class="icono-menu"></a>
            <ul class="dropdown-content">                           
                <li><a href="../7.Dotaciones/prenda.jsp">Prendas</a></li>
                <li><a href="../7.Dotaciones/inventarioDotacion.jsp">Inventario dotación</a></li>
                <li><a href="../7.Dotaciones/inventarioDotacionUsada.jsp">Inventario dotación usada</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a href="#">Reportes e indicadores<img src="../presentacion/iconos/flecha.png" alt="Icono flecha" class="icono-menu"></a>
            <ul class="dropdown-content">                           
                <li><a href="#">Ingresos de colaboradores</a></li>
                <li><a href="#">Retiros de colaboradores</a></li>
                <li><a href="#">Dotaciones entregadas</a></li>
                <li><a href="../5.Reportes/cumpleanos.jsp">Cumpleañeros del mes</a></li>
            </ul>
        </li>
    </ul>
    <ul class="bottom-menu">
        <% if ("S".equals(tipoUsuario)) { %>
            <li><a href="../4.Usuarios/usuarios.jsp">Usuarios</a></li>
        <% } %>
        <li><a href="../4.Usuarios/perfil.jsp">Perfil</a></li>
        <li><a href="../index.jsp">Cerrar sesión</a></li>
    </ul>
</nav>
