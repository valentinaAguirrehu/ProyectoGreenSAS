<%@page import="clases.Educacion"%>
<%@page import="clases.Talla"%>
<%@page import="clases.InformacionLaboral"%>
<%@page import="clases.Hijo"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    Talla talla = (Talla) request.getAttribute("talla");
    request.setAttribute("talla", talla);

    InformacionLaboral informacionLaboral = new InformacionLaboral();
    informacionLaboral.setIdentificacion(request.getParameter("identificacion"));
    informacionLaboral.setIdCargo(request.getParameter("idCargo"));
    informacionLaboral.setFechaIngreso(request.getParameter("NA"));
    informacionLaboral.setFechaIngresoTemporal(request.getParameter("NA"));
    informacionLaboral.setFechaRetiro(request.getParameter("NA"));
    informacionLaboral.setUnidadNegocio(request.getParameter("unidadNegocio"));
    informacionLaboral.setCentroCostos(request.getParameter("centroCostos"));
    informacionLaboral.setEstablecimiento(request.getParameter("establecimiento"));
    informacionLaboral.setArea(request.getParameter("area"));
    informacionLaboral.setSalario(request.getParameter("salario"));
    informacionLaboral.setFechaTerPriContrato(request.getParameter("NA"));

    Educacion educacion = new Educacion();
    educacion.setIdentificacion(request.getParameter("identificacion"));
    educacion.setFechaEtapaLectiva(request.getParameter("fechaEtapaLectiva"));
    educacion.setFechaFinalizacionEtapaLectiva(request.getParameter("fechaFinalizacionEtapaLectiva"));
    educacion.setFechaEtapaProductiva(request.getParameter("fechaEtapaProductiva"));
    educacion.setFechaFinalizacionEtapaProductiva(request.getParameter("fechaFinalizacionEtapaProductiva"));
    educacion.setFechaRetiroAnticipado(request.getParameter("fechaRetiroAnticipado"));
    educacion.setTituloAprendiz(request.getParameter("tituloAprendiz"));

    switch (accion) {
        case "Adicionar":
            if (InformacionLaboral.getInformacionPorIdentificacion(informacionLaboral.getIdentificacion()) == null) {
                informacionLaboral.grabar();
                educacion.grabar();
                response.sendRedirect("tallaAFormulario.jsp?identificacion=" + informacionLaboral.getIdentificacion() + "&accion=Adicionar");
                return;
            } else {
                out.println("<p>Error: La identificación ya existe en la base de datos.</p>");
            }
            break;

        case "Modificar":
            // Aquí aseguramos que el WHERE utilice la identificación anterior
            informacionLaboral.modificar(identificacionAnterior);
            educacion.modificar(identificacionAnterior);
            response.sendRedirect("tallaAFormulario.jsp?identificacion=" + informacionLaboral.getIdentificacion() + "&accion=Modificar");
            return;

        case "Eliminar":
            informacionLaboral.eliminar();
            educacion.eliminar();
            break;
    }
%>

<script type="text/javascript">
    document.location = "aprendiz.jsp";
</script>