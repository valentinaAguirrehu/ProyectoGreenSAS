<%-- 
    Document   : usuariosActualizar
    Created on : 10 mar 2025, 14:52:02
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    Administrador usuario = "Modificar".equals(accion)
        ? new Administrador(identificacionAnterior)
        : new Administrador();

    usuario.setIdentificacion(request.getParameter("identificacion"));
    usuario.setNombres(request.getParameter("nombres"));
    usuario.setCelular(request.getParameter("celular"));
    usuario.setEmail(request.getParameter("email"));

    String nuevaClave = request.getParameter("clave");
    String claveActual = request.getParameter("claveActual"); 

    if (nuevaClave != null && !nuevaClave.trim().isEmpty()) {
        usuario.setClave(nuevaClave); 
    } else if ("Modificar".equals(accion)) {
        usuario.setClave(claveActual); 
    }

    usuario.setpLeer("S");
    usuario.setpEditar(request.getParameter("pEditar") != null ? "S" : "N");
    usuario.setpAgregar(request.getParameter("pAgregar") != null ? "S" : "N");
    usuario.setpEliminar(request.getParameter("pEliminar") != null ? "S" : "N");
    usuario.setpDescargar(request.getParameter("pDescargar") != null ? "S" : "N");

    usuario.setTipo("U");
    usuario.setEstado(request.getParameter("estado") != null ? request.getParameter("estado") : "Activo");

    switch (accion) {
        case "Adicionar":
            usuario.grabar();
            break;
        case "Modificar":
            usuario.modificar(identificacionAnterior);
            break;
        case "Eliminar":
            usuario.eliminar();
            break;
    }
%>

<script>
    window.location.href = "usuarios.jsp";
</script>

