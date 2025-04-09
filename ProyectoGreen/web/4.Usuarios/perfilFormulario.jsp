<%-- 
    Document   : perfilFormulario
    Created on : 18 mar 2025, 14:12:15
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession sesion = request.getSession();
    Administrador usuarioActual = (Administrador) sesion.getAttribute("usuario");

    if (usuarioActual == null) {
        response.sendRedirect("index-InicioSesion.jsp");
        return;
    }

    String nombres = request.getParameter("nombre");
    String celular = request.getParameter("celular");
    String email = request.getParameter("email");
    String nuevaClave = request.getParameter("clave");
    String confirmarClave = request.getParameter("confirmarClave");

    if (request.getParameter("accion") != null && request.getParameter("accion").equals("Modificar")) {
        usuarioActual.setNombres(nombres);
        usuarioActual.setCelular(celular);
        usuarioActual.setEmail(email);

        if (nuevaClave != null && !nuevaClave.isEmpty() && nuevaClave.equals(confirmarClave)) {
            usuarioActual.setClave(nuevaClave);
        }

        sesion.setAttribute("usuario", usuarioActual);
        response.sendRedirect("perfil.jsp");
    }
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../presentacion/style-Perfil.css">
</head>

<%@ include file="../menu.jsp" %>

<div class="content">
    <div class="card">
        <div class="titulo">
            <h2>MODIFICAR PERFIL</h2>
        </div>
        <div class="card-body">
            <form method="post" action="perfilActualizar.jsp">
                <div class="form-group">
                    <label for="identificacion">Identificación:</label>
                    <input type="text" name="identificacion" id="identificacion" value="<%=usuarioActual.getIdentificacion()%>" readonly>
                </div>

                <div class="form-group">
                    <label for="nombres">Nombres:</label>
                    <input type="text" name="nombres" id="nombres" value="<%=usuarioActual.getNombres()%>">
                </div>

                <div class="form-group">
                    <label for="celular">Celular:</label>
                    <input type="text" name="celular" id="celular" value="<%=usuarioActual.getCelular()%>">
                </div>

                <div class="form-group">
                    <label for="email">Correo electrónico:</label>
                    <input type="email" name="email" id="email" value="<%=usuarioActual.getEmail()%>">
                </div>

                <div class="form-group">
                    <label for="clave">Nueva contraseña:</label>
                    <input type="password" name="clave" id="clave" onkeyup="validarClave();">
                </div>

                <div class="form-group">
                    <label for="confirmarClave">Confirmar contraseña:</label>
                    <input type="password" name="confirmarClave" id="confirmarClave" onkeyup="verificarCoincidencia();">
                </div>

                <div id="requisitosClave">
                    <p>La contraseña debe cumplir los siguientes requisitos:</p>
                    <ul>
                        <li id="minimoCaracteres">Mínimo 8 caracteres</li>
                        <li id="letraMayuscula">Una letra mayúscula</li>
                        <li id="letraMinuscula">Una letra minúscula</li>
                        <li id="numero">Un número</li>
                        <li id="coincidencia">Las contraseñas deben coincidir</li>
                    </ul>
                </div>

                <div class='btn-container'>
                    <button type="button" class="btn-adicionar" name="accion" value="Modificar">Guardar Cambios</button>
                    <button type="button" class="btn-eliminar" value="Cancelar" onClick="window.history.back();">Cancelar</button>
                </div>
                <input type="hidden" name="identificacionAnterior" value="<%= usuarioActual.getIdentificacion()%>">
            </form>
        </div>
    </div>
</div>

<script>
    function validarClave() {
        let clave = document.getElementById("clave").value;
        document.getElementById("minimoCaracteres").style.color = clave.length >= 8 ? "green" : "red";
        document.getElementById("letraMayuscula").style.color = /[A-Z]/.test(clave) ? "green" : "red";
        document.getElementById("letraMinuscula").style.color = /[a-z]/.test(clave) ? "green" : "red";
        document.getElementById("numero").style.color = /\d/.test(clave) ? "green" : "red";
    }

    function verificarCoincidencia() {
        let clave = document.getElementById("clave").value;
        let confirmarClave = document.getElementById("confirmarClave").value;
        document.getElementById("coincidencia").style.color = clave === confirmarClave ? "green" : "red";
    }

</script>
