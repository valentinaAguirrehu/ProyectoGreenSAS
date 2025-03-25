<%-- 
    Document   : index
    Created on : 07/03/2025, 04:42:24 PM
    Author     : VALEN
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String mensaje = "";
    if (request.getParameter("error") != null) {
        switch (request.getParameter("error")) {
            case "1":
                mensaje = "Usuario o contraseña incorrecta";
                break;
            case "2":
                mensaje = "Acceso denegado. Usuario inactivo";
                break;
            default:
                mensaje = "Error desconocido";
        }
    }
%>

<!DOCTYPE html>

<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GREEN SAS</title>
        <link rel="stylesheet" href="presentacion/style-Index.css">
    </head>
    <body>
    <div class="login-container">
        <div class="left-section">
            <img src="presentacion/imagenes/LogoGreen.png" alt="Logo de GREEN S.A.S" class="logo">
            <p>BIENVENIDO</p>
            <p>A</p>
            <p>GREEN S.A.S</p>
        </div>

        <div class="right-section">
            <h2>GESTIÓN HUMANA</h2>
            <p id="error"><%= mensaje%></p>
            <form method="post" action="validar.jsp">
                <div class="input-box">
                    <label for="usuario">Identificación</label>
                    <div class="icon-input">
                        <input type="text" name="identificacion" id="usuario" required placeholder="Digite su identificación">
                        <img src="presentacion/imagenes/user.png" alt="usuario" class="icon">
                    </div>
                </div>
                <div class="input-box">
                    <label for="clave">Contraseña</label>
                    <div class="icon-input">
                        <input type="password" name="clave" id="clave" required placeholder="Digite su contraseña">
                        <img src="presentacion/imagenes/clave.png" alt="clave" class="icon">
                    </div>
                </div>
                <button type="submit" id="boton">Iniciar Sesión</button>
            </form>
        </div>
    </div>
</body>
</html>
