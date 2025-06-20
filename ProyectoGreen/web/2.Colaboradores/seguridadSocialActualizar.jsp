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
    request.setCharacterEncoding("UTF-8");
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    Referencia referencia = (Referencia) request.getAttribute("referencia");
    request.setAttribute("referencia", referencia);

    SeguridadSocial seguridadSocial = new SeguridadSocial();
    seguridadSocial.setIdentificacion(request.getParameter("identificacion"));
    seguridadSocial.setEps(request.getParameter("epsFinal"));
    seguridadSocial.setArl(request.getParameter("arlFinal"));
    seguridadSocial.setFondoPensiones(request.getParameter("fondoPensionesFinal"));
    seguridadSocial.setFondoCesantias(request.getParameter("fondoCesantiasFinal"));

    switch (accion) {
        case "Adicionar":
            // Solo si no existe, lo graba y redirige al formulario para continuar llenando
            if (seguridadSocial.getSeguridadSocialPorIdentificacion(seguridadSocial.getIdentificacion()) == null) {
                seguridadSocial.grabar();

                // Redirige al formulario después de guardar
                String id = seguridadSocial.getIdentificacion();
                response.sendRedirect("referenciaFormulario.jsp?identificacion=" + id + "&accion=Adicionar");
                return; // Importante para evitar que siga ejecutando el resto del JSP
            } else {
                out.println("<p>Error: La identificación ya existe en la base de datos.</p>");
            }
            break;

        case "Modificar":
            seguridadSocial.modificar(identificacionAnterior);

            // Redirige al formulario manteniéndose en la vista
            response.sendRedirect("referenciaFormulario.jsp?identificacion=" + seguridadSocial.getIdentificacion() + "&accion=Modificar");
            return; // Esto termina la ejecución del JSP aquí
        // break eliminado porque ya no es necesario (ni válido)

      case "Cancelar":
        response.sendRedirect("persona.jsp");
        return;
    }

%>


<script type="text/javascript">
    // Esto se ejecuta solo si no hubo redirección
    document.location = "persona.jsp";
//    aqui cambiar para que siga el modificar
</script>
