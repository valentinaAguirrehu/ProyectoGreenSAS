<%-- 
    Document   : seguridadSocialActualizar
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.Referencia"%>
<%@page import="clases.SeguridadSocial"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    Referencia referencia = (Referencia) request.getAttribute("referencia");
    request.setAttribute("referencia", referencia);

    SeguridadSocial seguridadSocial = new SeguridadSocial();
    seguridadSocial.setIdentificacion(request.getParameter("identificacion"));
    seguridadSocial.setEps(request.getParameter("eps"));
    seguridadSocial.setArl(request.getParameter("arl"));
    seguridadSocial.setFondoPensiones(request.getParameter("fondoPensiones"));
    seguridadSocial.setFondoCesantias(request.getParameter("fondoCesantias"));

    switch (accion) {
        case "Adicionar":
            // Solo si no existe, lo graba y redirige
            if (seguridadSocial.getSeguridadSocialPorIdentificacion(seguridadSocial.getIdentificacion()) == null) {
                seguridadSocial.grabar();

                // Redirige inmediatamente después de guardar
                String id = seguridadSocial.getIdentificacion();
                response.sendRedirect("referenciaFormulario.jsp?identificacion=" + id + "&accion=Adicionar");
                return;
            } else {
                out.println("<p>Error: La identificación ya existe en la base de datos.</p>");
            }
            break;

        case "Modificar":
            seguridadSocial.modificar(identificacionAnterior);
            break;

        case "Eliminar":
            seguridadSocial.eliminar();
            break;
    }
%>

<script type="text/javascript">
    // Esto se ejecuta solo si no hubo redirección
    document.location = "persona.jsp"; 
//    aqui cambiar para que siga el modificar
</script>
