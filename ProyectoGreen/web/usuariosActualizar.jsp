<%-- 
    Document   : usuariosActualizar
    Created on : 10 mar 2025, 14:52:02
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>

<%
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    Administrador usuario;

    if ("Modificar".equals(accion)) {
        usuario = new Administrador(identificacionAnterior);
    } else {
        usuario = new Administrador();
    }

    usuario.setIdentificacion(request.getParameter("identificacion"));
    usuario.setTipo(request.getParameter("tipo"));
    usuario.setNombres(request.getParameter("nombres"));
    usuario.setCelular(request.getParameter("celular"));
    usuario.setEmail(request.getParameter("email"));
    usuario.setClave(request.getParameter("clave"));
    usuario.setpLeer(request.getParameter("pLeer"));
    usuario.setpEditar(request.getParameter("pEditar"));
    usuario.setpAgregar(request.getParameter("pAgregar"));
    usuario.setpEliminar(request.getParameter("pEliminar"));
    usuario.setpDescargar(request.getParameter("pDescargar"));
    usuario.setEstado(request.getParameter("estado"));

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

<script type="text/javascript">
    document.location = "usuarios.jsp";
</script>
