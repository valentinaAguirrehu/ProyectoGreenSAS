<%@page import="clases.Vehiculo"%>
<%@page import="clases.SeguridadSocial"%>
<%@page import="clases.Referencia"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    // Capturar acción y valores del formulario
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    Vehiculo vehiculo = (Vehiculo) request.getAttribute("vehiculo");
    request.setAttribute("vehiculo", vehiculo);
    // Obtener los datos de la referencia desde el request
    Referencia referencia = new Referencia();
    referencia.setIdentificacion(request.getParameter("identificacion"));
    referencia.setPrimerRefNombre(request.getParameter("primerRefNombre"));
    referencia.setPrimerRefParentezco(request.getParameter("primerRefParentezco"));
    referencia.setPrimerRefCelular(request.getParameter("primerRefCelular"));
    referencia.setSegundaRefNombre(request.getParameter("segundaRefNombre"));
    referencia.setSegundaRefParentezco(request.getParameter("segundaRefParentezco"));
    referencia.setSegundaRefCelular(request.getParameter("segundaRefCelular"));
    referencia.setTerceraRefNombre(request.getParameter("terceraRefNombre"));
    referencia.setTerceraRefParentezco(request.getParameter("terceraRefParentezco"));
    referencia.setTerceraRefCelular(request.getParameter("terceraRefCelular"));
    referencia.setCuartaRefNombre(request.getParameter("cuartaRefNombre"));
    referencia.setCuartaRefParentezco(request.getParameter("cuartaRefParentezco"));
    referencia.setCuartaRefCelular(request.getParameter("cuartaRefCelular"));

    // Variable para saber si la referencia fue guardada con éxito
    boolean referenciaGuardada = false;

    // Acción según el botón presionado
    try {
        switch (accion) {
            case "Adicionar":
                // Verificar si la identificación ya existe en la base de datos
                if (Referencia.getReferenciaPorIdentificacion(referencia.getIdentificacion()) == null) {
                    referencia.grabar(); // Llama al método de grabar si es una persona nueva
                    // Redirige inmediatamente después de guardar
                    String id = referencia.getIdentificacion();
                    response.sendRedirect("vehiculoTFormulario.jsp?identificacion=" + id + "&accion=Adicionar");
                    return;
                } else {
                    out.println("<p>Error: La identificación ya existe en la base de datos.</p>");
                }
                break;

            case "Modificar":
                // Si la persona ya existe, proceder con la modificación
                referencia.modificar(identificacionAnterior); // Llama al método de modificar
                // Redirige al formulario manteniéndose en la vista
                response.sendRedirect("vehiculoTFormulario.jsp?identificacion=" + referencia.getIdentificacion() + "&accion=Modificar");
                return; // Esto termina la ejecución del JSP aquí
            // break eliminado porque ya no es necesario (ni válido)

            case "Eliminar":
                // Llama al método de eliminar
                referencia.eliminar();
                break;

            default:
                out.println("<p>Acción desconocida.</p>");
                break;
        }

        // Redirigir automáticamente si la acción es "Adicionar"
        if ("Adicionar".equals(accion) && referenciaGuardada) {
            String identificacionParaRedirigir = referencia.getIdentificacion();
            response.sendRedirect("vehiculoTFormulario.jsp?identificacion=" + identificacionParaRedirigir);
            return; // Detiene el JSP después de redirigir
        }
    } catch (Exception e) {
        out.println("<p>Error en el proceso: " + e.getMessage() + "</p>");
    }
%>



<script type="text/javascript">
    document.location = "temporales.jsp";
</script>
