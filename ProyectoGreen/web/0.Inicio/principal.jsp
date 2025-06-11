<%-- 
    Document   : principal
    Created on : 6 mar 2025, 23:10:48
    Author     : Angie
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>GREEN S.A.S.</title>
        <link rel="stylesheet" href="recursos/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../presentacion/style-Principal.css">
        <script src="recursos/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="recursos/jquery-3.7.1.min.js"></script>
        <script src="recursos/jquery-ui-1.13.3.custom/jquery-ui.min.js"></script>


    </head>

    <body>
        <%@ include file="../menu.jsp" %>
        <main class="content">
            <div class="welcome-text">
                <h1>¡Bienvenido al portal de Gestión Humana de GREEN S.A.S.!</h1>
            </div>
            <div class="quad-container">
                <a href="../politicas.jsp" style="text-decoration: none;">
                    <div class="quad">Políticas y Privacidad</div>
                </a>
                <a href="../9.ManualUso/manualUso.jsp" style="text-decoration: none;">
                    <div class="quad">Manual de Uso</div>
                </a>
<!--                <a href="../soporteTecnico.jsp" style="text-decoration: none;">
                    <div class="quad">Soporte Técnico</div>
                </a>-->
            </div>
        </main>

    </body>
</html>

