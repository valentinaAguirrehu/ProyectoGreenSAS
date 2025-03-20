<%-- 
    Document   : perfil
    Created on : 17 mar 2025, 17:31:51
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession sesion = request.getSession();
    Administrador usuarioActual = (Administrador) sesion.getAttribute("usuario");

    if (usuarioActual == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    if (request.getParameter("accion") != null && request.getParameter("accion").equals("Modificar")) {
        String nombres = request.getParameter("nombre");
        String celular = request.getParameter("celular");
        String email = request.getParameter("email");

        usuarioActual.setNombres(nombres);
        usuarioActual.setCelular(celular);
        usuarioActual.setEmail(email);

        sesion.setAttribute("usuario", usuarioActual);
        response.sendRedirect("perfil.jsp");
    }
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="presentacion/style-Perfil.css">
</head>

<div class="card">
    <div class="titulo">
        <h2>MI PERFIL</h2>
    </div>
    <div class="card-body">
        <div class="form-group">
            <label for="identificacion">Identificación:</label>
            <input type="text" name="identificacion" id="identificacion" value="<%=usuarioActual.getIdentificacion()%>" readonly>
        </div>

        <div class="form-group">
            <label for="nombres">Nombres:</label>
            <input type="text" name="nombres" id="nombres" value="<%=usuarioActual.getNombres()%>" readonly>
        </div>

        <div class="form-group">
            <label for="celular">Celular:</label>
            <input type="text" name="celular" id="celular" value="<%=usuarioActual.getCelular()%>" readonly>
        </div>

        <div class="form-group">
            <label for="email">Correo Electrónico:</label>
            <input type="text" name="email" id="email" value="<%=usuarioActual.getEmail()%>" readonly>
        </div>

    </div>
  <div class='btn-container'>
        <a href='perfilFormulario.jsp' title='Modificar'>
            <button class='btn-adicionar' title='Modificar'> Modificar </button>
        </a>
    </div>
</div>
