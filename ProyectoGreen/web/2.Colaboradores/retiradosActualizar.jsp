<%@page import="clases.InformacionLaboral"%>
<%@page import="clases.Retirados"%>
<%@page import="clases.Persona"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    String identificacion = request.getParameter("identificacion");

//    accion para el botonn------
    if ("CambiarTipo".equals(accion) && identificacion != null && !identificacion.trim().equals("")) {
        String sql = "UPDATE persona SET tipo = 'C' WHERE identificacion = '" + identificacion + "'";
        ConectorBD.ejecutarQuery(sql);

        String sqlEliminar = "DELETE FROM retirados WHERE identificacionPersona = '" + identificacion + "'";
        ConectorBD.ejecutarQuery(sqlEliminar);

        response.sendRedirect("retirados.jsp");
        return;
    }
//    ------

    String fechaRetiro = request.getParameter("fechaRetiro");
    String fechaIngreso = request.getParameter("fechaIngreso");
    String idCargo = request.getParameter("idCargo");
    String numCaja = request.getParameter("numCaja");
    String numCarpeta = request.getParameter("numCarpeta");
    String observaciones = request.getParameter("observaciones");

    InformacionLaboral informacionLaboral = new InformacionLaboral();
    informacionLaboral.setIdentificacion(identificacion);
    informacionLaboral.setFechaIngreso(fechaIngreso);
    informacionLaboral.setFechaRetiro(fechaRetiro);
    informacionLaboral.setIdCargo(idCargo);

    Persona persona = new Persona(identificacion);
    persona.setTipo("R");

    Retirados retirado = new Retirados(id);
    retirado.setIdentificacionPersona(identificacion);
    retirado.setNumCaja(numCaja);
    retirado.setNumCarpeta(numCarpeta);
    retirado.setObservaciones(observaciones);
// Capturar datos ocultos del formulario
String unidadNegocio = request.getParameter("unidadNegocio");
String centroCostos = request.getParameter("centroCostos");
String area = request.getParameter("area");
String salario = request.getParameter("salario");
String estado = request.getParameter("estado");
String fechaIngresoTemporal = request.getParameter("fechaIngresoTemporal");
String fechaTerPriContrato = request.getParameter("fechaTerPriContrato");

// Setear los campos faltantes
informacionLaboral.setUnidadNegocio(unidadNegocio);
informacionLaboral.setCentroCostos(centroCostos);
informacionLaboral.setArea(area);
informacionLaboral.setSalario(salario);
informacionLaboral.setEstado(estado);
informacionLaboral.setFechaIngresoTemporal(fechaIngresoTemporal);
informacionLaboral.setFechaTerPriContrato(fechaTerPriContrato);

    switch (accion) {
        case "Adicionar":
            persona.modificar(identificacion); // Asigna tipo "R"
            informacionLaboral.modificar(identificacion); // Modifica la info laboral
            informacionLaboral.grabar(); // <--- Cambiado aquí
            retirado.grabar();
            break;

        case "Modificar":
            if (id != null && fechaIngreso != null && fechaRetiro != null) {
                String sqlInfoLaboral = "UPDATE informacionlaboral SET "
                        + "fechaIngreso = '" + fechaIngreso + "', "
                        + "fechaRetiro = '" + fechaRetiro + "' "
                        + "WHERE identificacion = '" + identificacion + "'";
                boolean actualizado = ConectorBD.ejecutarQuery(sqlInfoLaboral);

                if (actualizado) {
                   if (id != null && fechaIngreso != null && !fechaIngreso.trim().isEmpty() && fechaRetiro != null) {
    String sqlRetirados = "UPDATE informacionlaboral SET "
        + "fechaIngreso = '" + fechaIngreso + "', "
        + "fechaRetiro = '" + fechaRetiro + "' "
                            + "WHERE id = '" + id + "'";
                    ConectorBD.ejecutarQuery(sqlRetirados);
                }
                }}
            break;

        case "Eliminar":
            retirado.eliminar();
            informacionLaboral.eliminar();
            break;
    }
%>

<script type="text/javascript">
    document.location = "retirados.jsp";
</script>