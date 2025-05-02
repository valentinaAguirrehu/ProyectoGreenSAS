<%-- 
    Document   : perfilActualizar
    Created on : 18 mar 2025, 14:11:52
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    if (identificacionAnterior == null || identificacionAnterior.trim().isEmpty()) {
        out.print("<p>Error: La identificaci�n anterior es inv�lida.</p>");
        return;
    }

    Administrador admin = new Administrador(request.getParameter("identificacion"));

    admin.setIdentificacion(request.getParameter("identificacion"));
    admin.setTipo(request.getParameter("tipo"));
    admin.setNombres(request.getParameter("nombres"));
    admin.setCelular(request.getParameter("celular"));
    admin.setEmail(request.getParameter("email"));
    admin.setClave(request.getParameter("clave"));

    admin.setpLeer("S");
    admin.setpEditar("S");
    admin.setpAgregar("S");
    admin.setpEliminar("S");
    admin.setpDescargar("S");
    admin.setTipo("S");

    String estado = request.getParameter("estado");
    if (estado == null || estado.trim().isEmpty()) {
        estado = "Activo"; 
    }
    admin.setEstado(estado);

    boolean actualizado = admin.modificar(identificacionAnterior);

    if (actualizado) {
        // Invalidar la sesi�n actual
        session.invalidate();
%>
        <script>
            alert("Tu perfil se ha actualizado exitosamente. Por favor, vuelve a iniciar sesi�n.");
            window.location.href = "../index.jsp";
        </script>
<%
    } else {
        out.print("<p>Error al actualizar el perfil.</p>");
    }
%>


