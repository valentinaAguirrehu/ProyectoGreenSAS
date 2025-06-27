<%@page import="java.sql.ResultSet"%>
<%@page import="clases.InformacionLaboral"%>
<%@page import="clases.Retirados"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Educacion"%>
<%@page import="clases.Cargo"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    
    request.setCharacterEncoding("UTF-8");

    // ✅ Parámetros principales
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    String identificacion = request.getParameter("identificacion");

    String fechaIngresoParam = request.getParameter("fechaIngreso");
    String fechaRetiroParam = request.getParameter("fechaRetiro");

    String idCargo = request.getParameter("idCargo");
    String numCaja = request.getParameter("numCaja");
    String numCarpeta = request.getParameter("numCarpeta");
    String observaciones = request.getParameter("observaciones");
    String unidadNegocio = request.getParameter("unidadNegocio");
    String centroCostos = request.getParameter("centroCostos");
    String area = request.getParameter("area");
    String salario = request.getParameter("salario");
    String estado = request.getParameter("estado");

    // ✅ Objetos base
    Persona persona = new Persona(identificacion);
    InformacionLaboral informacionLaboral = new InformacionLaboral(identificacion);
    Educacion educacion = new Educacion(identificacion);

    // ✅ Obtener tipo colaborador de la persona
    String tipoColaborador = (persona != null && persona.getTipo() != null && !persona.getTipo().isEmpty())
                             ? persona.getTipo()
                             : request.getParameter("tipo");
    if (tipoColaborador == null || tipoColaborador.trim().isEmpty()) {
        tipoColaborador = "C";
    }

    // ✅ Calcular fecha de ingreso inteligente si no la manda el usuario
    String fechaIngreso = (fechaIngresoParam != null && !fechaIngresoParam.trim().isEmpty())
                          ? fechaIngresoParam
                          : informacionLaboral.obtenerFechaIngresoInteligente(tipoColaborador, educacion, fechaIngresoParam);

    String fechaRetiro = (fechaRetiroParam != null && !fechaRetiroParam.trim().isEmpty())
                         ? fechaRetiroParam
                         : "";

    // ✅ Crear objeto Retirados
    Retirados retirado = new Retirados(id);
    retirado.setIdentificacionPersona(identificacion);
//    retirado.setFechaIngreso(fechaIngreso);
//    retirado.setFechaRetiro(fechaRetiro);
    retirado.setNumCaja(numCaja);
    retirado.setNumCarpeta(numCarpeta);
    retirado.setObservaciones(observaciones);

    // ✅ Actualizar información laboral
    informacionLaboral.setIdentificacion(identificacion);
    informacionLaboral.setFechaIngreso(fechaIngreso);
    informacionLaboral.setFechaRetiro(fechaRetiro);
    informacionLaboral.setIdCargo(idCargo);
    informacionLaboral.setUnidadNegocio(unidadNegocio);
    informacionLaboral.setCentroCostos(centroCostos);
    informacionLaboral.setArea(area);
    informacionLaboral.setSalario(salario);
    informacionLaboral.setEstado(estado);

    // ✅ Cambiar tipo persona
    persona.setTipo("R");

    // ✅ Switch de acción
    switch (accion) {
        case "Adicionar":
            persona.modificar(identificacion);

            try {
                boolean existe = false;
                ResultSet rs = ConectorBD.consultar("SELECT identificacion FROM informacionlaboral WHERE identificacion = '" + identificacion + "'");
                if (rs.next()) {
                    existe = true;
                }
                rs.getStatement().getConnection().close();

                if (existe) {
                    informacionLaboral.modificar(identificacion);
                } else {
                    informacionLaboral.grabar();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            retirado.grabar();
            break;

        case "Modificar":
            informacionLaboral.modificar(identificacion);

            String sqlRetirados = "UPDATE retirados SET "
                                + "fechaIngreso = '" + fechaIngreso + "', "
                                + "fechaRetiro = '" + fechaRetiro + "', "
                                + "numCaja = '" + numCaja + "', "
                                + "numCarpeta = '" + numCarpeta + "', "
                                + "observaciones = '" + observaciones + "' "
                                + "WHERE identificacionPersona = '" + identificacion + "'";
            ConectorBD.ejecutarQuery(sqlRetirados);
            break;

        case "Eliminar":
            retirado.eliminar();
            informacionLaboral.eliminar();
            break;

        case "CambiarTipo":
            String sqlPersona = "UPDATE persona SET tipo = 'C' WHERE identificacion = '" + identificacion + "'";
            ConectorBD.ejecutarQuery(sqlPersona);

            String sqlEliminar = "DELETE FROM retirados WHERE identificacionPersona = '" + identificacion + "'";
            ConectorBD.ejecutarQuery(sqlEliminar);
            break;

        default:
            out.println("<p>⚠️ Acción no reconocida: " + accion + "</p>");
            break;
    }
%>

<script type="text/javascript">
    document.location = "retirados.jsp";
</script>
