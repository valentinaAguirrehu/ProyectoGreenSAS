<%@page import="clases.Persona"%>
<%@page import="clases.Vacaciones"%>
<%@page import="clases.InformacionLaboral"%> 
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>

<%
    String accion = request.getParameter("accion");
    String idPersona = request.getParameter("idPersona");
    String id = request.getParameter("id");

    Persona persona = null;
    InformacionLaboral infoLaboral = null;
    Vacaciones vacacion = null;
    String fechaVacacion = "No calculada";

    if (idPersona != null && !idPersona.isEmpty()) {
        persona = new Persona(idPersona);
        infoLaboral = InformacionLaboral.getInformacionPorIdentificacion(idPersona);

        try {
            String fechaIngresoTexto = (infoLaboral != null) ? infoLaboral.getFechaIngreso() : null;

            if (fechaIngresoTexto != null && !fechaIngresoTexto.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date fechaIngresoReal = sdf.parse(fechaIngresoTexto);

                Calendar cal = Calendar.getInstance();
                cal.setTime(fechaIngresoReal);
                cal.add(Calendar.YEAR, 1);

                fechaVacacion = sdf.format(cal.getTime());
            }
        } catch (Exception e) {
            System.out.println("Error al calcular fecha de vacaci�n: " + e.getMessage());
        }
    }

    if ("Modificar".equals(accion) && id != null && !id.isEmpty()) {
        vacacion = new Vacaciones(id);
    } else {
        vacacion = new Vacaciones();
    }

    String observacion = (vacacion.getObservacion() == null
            || vacacion.getObservacion().trim().isEmpty()
            || vacacion.getObservacion().trim().equalsIgnoreCase("null"))
            ? "NINGUNA"
            : vacacion.getObservacion();
%>

<%@ include file="../menu.jsp" %>
<link rel="stylesheet" href="../presentacion/style-AusentismosFormulario.css">

<div class="content">

    <form action="vacacionesActualizar.jsp" method="post">
        <h3 class="titulo"><%= ("Modificar".equals(accion)) ? "Modificar Vacaciones" : "Registrar Vacaciones"%></h3>
        <input type="hidden" name="accion" value="<%= accion%>">
        <input type="hidden" name="id" value="<%= (vacacion.getIdVacaciones() != null) ? vacacion.getIdVacaciones() : ""%>">
        <input type="hidden" name="idPersona" value="<%= (persona != null) ? persona.getIdentificacion() : ""%>">

        <table class="table">
            <tr>
                <td><strong>Colaborador:</strong></td>
                <td><%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() : "No seleccionado"%></td>
            </tr>
            <tr>
                <td><strong>Fecha Ingreso:</strong></td>
                <td><%= (infoLaboral != null && infoLaboral.getFechaIngreso() != null) ? infoLaboral.getFechaIngreso() : "No disponible"%></td>
            </tr>

            <tr>
                <td><label for="periodoDisfrute">Periodo disfrute:</label></td>
                <td>
                    <input type="date" name="periodoDisfrute" id="periodoDisfrute" required
                           value="<%= vacacion.getPeriodoDisfrute() != null ? vacacion.getPeriodoDisfrute() : ""%>"> 
                    <span> a </span>
                    <input type="date" name="periodoDisfruteFin" id="periodoDisfruteFin" required
                           value="<%= vacacion.getPeriodoDisfruteFin() != null ? vacacion.getPeriodoDisfruteFin() : ""%>">
                </td>
            </tr>
            <tr>
                <td><label for="diasDisfrutados">D�as disfrutados:</label></td>
                <td><input type="number" name="diasDisfrutados" id="diasDisfrutados" min="0" required
                           value="<%= vacacion.getDiasDisfrutados() != null ? vacacion.getDiasDisfrutados() : ""%>"></td>
            </tr>
            <tr>
                <td><label for="diasCompensados">�Los d�as pendientes ser�n compensados?</label></td>
                <td>
                    <select name="diasCompensados" id="diasCompensados" required>
                        <option value="">--Seleccione--</option>
                        <option value="SI" <%= "Si".equalsIgnoreCase(vacacion.getDiasCompensados()) ? "selected" : ""%>>S�</option>
                        <option value="NO" <%= "No".equalsIgnoreCase(vacacion.getDiasCompensados()) ? "selected" : ""%>>No</option>
                    </select>
                </td>
            </tr>
            <tr id="filaDiasCompensar">
                <td><label for="diasCompensar">D�as a compensar:</label></td>
                <td><input type="number" name="diasCompensar" id="diasCompensar" min="0"
                           value="<%= vacacion.getDiasCompensar() != null ? vacacion.getDiasCompensar() : "0"%>"></td>
            </tr>
            <tr>
                <td><label for="observacion">Observaci�n:</label></td>
                <td>
                    <textarea name="observacion" id="observacion" rows="3" cols="40"><%= observacion%></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button class="submit" type="submit">Guardar</button>
                    <a href="verRegistrosVacaciones.jsp?identificacion=<%= (persona != null) ? persona.getIdentificacion() : ""%>">
                        <button class="button" type="button">Cancelar</button>
                    </a>
                </td>
            </tr>
        </table>
    </form>
</div>

<script>
    const selectDias = document.getElementById("diasCompensados");
    const filaDias = document.getElementById("filaDiasCompensar");
    const diasInput = document.getElementById("diasCompensar");

    function toggleDiasCompensar() {
        if (selectDias.value === "SI") {
            filaDias.style.display = "";
            diasInput.required = true;
        } else {
            filaDias.style.display = "none";
            diasInput.required = false;
            diasInput.value = "0";
        }
    }

    selectDias.addEventListener("change", toggleDiasCompensar);
    window.addEventListener("DOMContentLoaded", toggleDiasCompensar);
</script>
