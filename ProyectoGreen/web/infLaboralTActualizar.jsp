<%-- 
    Document   : infLaboralActualizar
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.Talla"%>
<%@page import="clases.InformacionLaboral"%>
<%@page import="clases.Hijo"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Capturar acción y valores del formulario
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");
    System.out.println("ID CARGO JSP: " + request.getParameter("idCargo"));

    Talla talla = (Talla) request.getAttribute("talla");
    request.setAttribute("talla", talla);
    // Crear objeto InformacionLaboral y asignar valores del formulario
    InformacionLaboral informacionLaboral = new InformacionLaboral();
    informacionLaboral.setIdentificacion(request.getParameter("identificacion"));
    informacionLaboral.setIdCargo(request.getParameter("idCargo"));
    informacionLaboral.setFechaIngreso(request.getParameter("NA"));
    informacionLaboral.setFechaIngresoTemporal(request.getParameter("fechaIngresoTemporal"));
    informacionLaboral.setFechaRetiro(request.getParameter("fechaRetiro"));
    informacionLaboral.setUnidadNegocio(request.getParameter("unidadNegocio"));
    informacionLaboral.setCentroCostos(request.getParameter("centroCostos"));
    informacionLaboral.setEstablecimiento(request.getParameter("establecimiento"));
    informacionLaboral.setArea(request.getParameter("area"));
    informacionLaboral.setSalario(request.getParameter("salario"));
    informacionLaboral.setFechaTerPriContrato(request.getParameter("fechaTerPriContrato"));

    // Acción según el botón presionado
    switch (accion) {
        case "Adicionar":
            // Verificar si la identificación ya existe en la base de datos
            if (InformacionLaboral.getInformacionPorIdentificacion(informacionLaboral.getIdentificacion()) == null) {
                informacionLaboral.grabar(); // Llama al método de grabar si es una persona nueva
                // Redirige inmediatamente después de guardar
                String id = informacionLaboral.getIdentificacion();
                response.sendRedirect("tallaTFormulario.jsp?identificacion=" + id + "&accion=Adicionar");
                return;
            } else {
                // Si ya existe, muestra un mensaje de error o realiza alguna acción (opcional)
                out.println("<p>Error: La identificación ya existe en la base de datos.</p>");
            }
            break;

        case "Modificar":
            // Si la persona ya existe, proceder con la modificación
            informacionLaboral.modificar(identificacionAnterior); // Llama al método de modificar
            // Redirige al formulario manteniéndose en la vista
            response.sendRedirect("tallaTFormulario.jsp?identificacion=" + informacionLaboral.getIdentificacion() + "&accion=Modificar");
            return; // Esto termina la ejecución del JSP aquí
        // break eliminado porque ya no es necesario (ni válido)

        case "Eliminar":
            // Llama al método de eliminar
            informacionLaboral.eliminar();
            break;
    }

// 
%>

<script type="text/javascript">
    document.location = "temporales.jsp";
</script>