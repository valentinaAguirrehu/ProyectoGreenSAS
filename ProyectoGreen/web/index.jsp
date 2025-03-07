<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String mensaje = "";
    if (request.getParameter("error") != null) {
        switch (request.getParameter("error")) {
            case "1":
                mensaje = "Usuario o contraseña no válido";
                break;
            case "2":
                mensaje = "Acceso denegado";
                break;
            default:
                mensaje = "Error desconocido";
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GREEN SAS GESTION HUMANA</title>
        <link rel="stylesheet" href="presentacion/style-Index.css">
    </head>
    <body>
        <div class="logo-container">
            <img src="presentacion/imagenes/Logo-Fundacion.png" alt="Logo Izquierdo" class="logo logo-left">
            <img src="presentacion/imagenes/Logo.png" alt="Logo Derecho" class="logo logo-right">
        </div>
        <div class="fondo-container">
            <img src="presentacion/imagenes/fondoVillaEsperanza.jpg" class="fondoVE">
        </div>
        <div class="container">
            <h3>GESTION HUMANA</h3>
            <p id="error"><%=mensaje%></p>
            <form name="formulario" method="post" action="validar.jsp">
                <div class="input-box">
                    <label for="usuario">IDENTIFICACIÓN</label>
                    <div class="icon-input">
                        <input type="text" name="identificacion" id="usuario" required placeholder="Digite aquí su número de identificación">
                        <img src="presentacion/iconos/identificacion.png" alt="usuario" class="icon">
                    </div>
                </div>
                <div class="input-box">
                    <label for="clave">CONTRASEÑA</label>
                    <div class="icon-input">
                        <input type="password" name="clave" id="clave" required placeholder="Digite aquí su contraseña">
                        <img src="presentacion/iconos/seguridad.png" alt="clave" class="icon">
                    </div>
                </div>
                <a href="principal.jsp" class="btn-empezar">INICIAR SESIÓN</a>
            </form>
        </div>
    </body>
</html>