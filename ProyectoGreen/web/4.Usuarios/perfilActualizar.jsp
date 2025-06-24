<%-- 
    Document   : perfilActualizar
    Created on : 18 mar 2025, 14:11:52
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String identificacionAnterior = request.getParameter("identificacionAnterior");
    if (identificacionAnterior == null || identificacionAnterior.trim().isEmpty()) {
        out.print("<p>Error: La identificación anterior es inválida.</p>");
        return;
    }

    Administrador admin = new Administrador(request.getParameter("identificacion"));
    admin.setNombres(request.getParameter("nombres"));
    admin.setCelular(request.getParameter("celular"));
    admin.setEmail(request.getParameter("email"));
    String nuevaClave = request.getParameter("clave");
    String claveActual = request.getParameter("claveActual");

    boolean cambioClave = (nuevaClave != null && !nuevaClave.trim().isEmpty());
    if (!cambioClave) {
        nuevaClave = claveActual;
    }
    admin.setClave(nuevaClave);
    admin.setpLeer("S");
    admin.setpEditar("S");
    admin.setpAgregar("S");
    admin.setpEliminar("S");
    admin.setpDescargar("S");
    admin.setTipo("S");

    String estado = request.getParameter("estado");
    admin.setEstado((estado == null || estado.trim().isEmpty()) ? "Activo" : estado);

    boolean actualizado = admin.modificar(identificacionAnterior);   

    if (actualizado) {
        if (cambioClave) {
            session.invalidate();
%>
<script>
    alert("Perfil actualizado y contraseña cambiada. Inicia sesión de nuevo.");
    window.location.href = "../index.jsp";
</script>
<%
} else {
    /* --- Si NO cambió contraseña, refresca objeto y sigue --- */
    session.setAttribute("usuario", admin);
%>
<script>
    alert("Perfil actualizado correctamente.");
    window.location.href = "perfil.jsp";
</script>
<%
        }
    } else {
        out.print("<p>Error al actualizar el perfil.</p>");
    }
%>
