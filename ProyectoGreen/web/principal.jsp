<%-- 
    Document   : principal
    Created on : 6 mar 2025, 23:10:48
    Author     : Angie
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>GREEN SAS</title>
        <link rel="stylesheet" href="recursos/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="presentacion/style-Principal.css">
        <script src="recursos/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="recursos/jquery-3.7.1.min.js"></script>
        <script src="recursos/jquery-ui-1.13.3.custom/jquery-ui.min.js"></script>
    </head>
    <body>
        <div class="logo-container">
            <img src="presentacion/imagenes/LogoGreen.png" alt="Logo de Green">
        </div>

        <nav class="sidebar">
            <ul>
                <li><a href="#">Inicio</a></li>
                <li><a href="#">Cargos</a></li>
                <li class="dropdown">
                    <a href="#">Colaboradores<img src="presentacion/iconos/flecha.png" alt="Icono flecha" class="icono-menu"></a>
                    <ul class="dropdown-content">                           
                        <li><a href="persona.jsp">Activos</a></li>
                        <li><a href="personaFormulario.jsp">Sumar</a></li>
                        <li><a href="">Aprendices</a></li>
                        <li><a href="#">Retirados</a></li>
                    </ul>
                </li>
                <li><a href="#">Dotaciones</a></li>
                <li class="dropdown">
                    <a href="#">Reportes e indicadores<img src="presentacion/iconos/flecha.png" alt="Icono flecha" class="icono-menu"></a>
                    <ul class="dropdown-content">                           
                        <li><a href="#">Ingresos de colaboradores</a></li>
                        <li><a href="#">Retiros de colaboradores</a></li>
                        <li><a href="#">Dotaciones Entregadas</a></li>
                        <li><a href="#">Cumpleañeros del mes</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="bottom-menu">
                <li><a href="#">Gestion de usuarios</a></li>
                <li><a href="#">Cerrar Sesion</a></li>
            </ul>
        </nav>
        <main class="content">
            <div class="welcome-text">
                <h1>¡Bienvenido al Portal de Gestion Humana de GREEN SAS!</h1>
            </div>
            <div class="quad-container">
                <div class="quad">Politicas y Privacidad</div>
                <div class="quad">Manual de Uso</div>
            </div>
        </main>
    </body>
</html>
