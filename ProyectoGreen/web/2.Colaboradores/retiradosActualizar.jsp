<%@page import="clases.InformacionLaboral"%>
<%@page import="clases.Retirados"%>
<%@page import="clases.Persona"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    String identificacion = request.getParameter("identificacion");

    if (identificacion == null || identificacion.trim().isEmpty()) {
        return;
    }

    String fechaRetiro = request.getParameter("fechaRetiro");
    String fechaIngreso = request.getParameter("fechaIngreso");
    String numCaja = request.getParameter("numCaja");
    String numCarpeta = request.getParameter("numCarpeta");
    String observaciones = request.getParameter("observaciones");

    InformacionLaboral informacionLaboral = new InformacionLaboral();
    informacionLaboral.setIdentificacion(identificacion);
    informacionLaboral.setFechaIngreso(fechaIngreso);
    informacionLaboral.setFechaRetiro(fechaRetiro);

    Persona persona = new Persona(identificacion);
    persona.setTipo("R");

    Retirados retirado = new Retirados(id);
    retirado.setIdentificacionPersona(identificacion);
    retirado.setNumCaja(numCaja);
    retirado.setNumCarpeta(numCarpeta);
    retirado.setObservaciones(observaciones);

    switch (accion) {
        case "Adicionar":
            persona.modificar(identificacion); // Asigna tipo "R"
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
                    String sqlRetirados = "UPDATE retirados SET "
                            + "numCaja = '" + numCaja + "', "
                            + "numCarpeta = '" + numCarpeta + "', "
                            + "observaciones = '" + observaciones + "' "
                            + "WHERE id = '" + id + "'";
                    ConectorBD.ejecutarQuery(sqlRetirados);
                }
            }
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