<%@page import="clases.Persona"%>
<%@page import="clases.DiaFamilia"%>
<%@page import="clases.InformacionLaboral"%>  <%-- Nueva importación --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
    String accion = request.getParameter("accion");
    String identificacionPersona1 = request.getParameter("idPersona");
    String idPersona = request.getParameter("idPersona");
    String id = request.getParameter("id");

    Persona persona = null;
    DiaFamilia diaFamilia = null;
    InformacionLaboral infoLaboral = null;

    if (identificacionPersona1 != null && !identificacionPersona1.isEmpty()) {
        persona = new Persona(identificacionPersona1);
        infoLaboral = new InformacionLaboral(identificacionPersona1);
    }

    if ("Modificar".equals(accion) && id != null && !id.isEmpty()) {
        diaFamilia = new DiaFamilia(id);
    } else {
        diaFamilia = new DiaFamilia();
    }

    String observacion = (diaFamilia.getObservacion() == null
            || diaFamilia.getObservacion().trim().isEmpty()
            || diaFamilia.getObservacion().trim().equalsIgnoreCase("null"))
            ? "NINGUNA"
            : diaFamilia.getObservacion();

    String diaDisfrutado = (diaFamilia.getDiaDisfrutado() != null) ? diaFamilia.getDiaDisfrutado() : "";
    String cartaFamilia = (diaFamilia.getCartaFamilia() != null) ? diaFamilia.getCartaFamilia() : "";

    // Formatear la fecha de ingreso de forma segura
    String fechaIngresoStr = "No disponible";

    if (infoLaboral != null) {
        Object fechaIngresoObj = infoLaboral.getFechaIngreso();
        if (fechaIngresoObj != null) {
            if (fechaIngresoObj instanceof java.util.Date) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                fechaIngresoStr = sdf.format((java.util.Date) fechaIngresoObj);
            } else if (fechaIngresoObj instanceof String) {
                fechaIngresoStr = (String) fechaIngresoObj;
            } else {
                fechaIngresoStr = fechaIngresoObj.toString();
            }
        }
    }
%>

<%@ include file="../menu.jsp" %>

<link rel="stylesheet" href="../presentacion/style-AusentismosFormulario.css">

<div class="content">

    <form action="DiaFamiliaActualizar.jsp" method="post">
        <h3 class="titulo"><%= ("Modificar".equals(accion)) ? "Modificar Día de la Familia" : "Registrar Día de la Familia" %></h3>
        <input type="hidden" name="accion" value="<%= accion %>">
        <input type="hidden" name="id" value="<%= (diaFamilia.getIdDiaFamilia() != null) ? diaFamilia.getIdDiaFamilia() : "" %>">
        <input type="hidden" name="IdentificacionPersona1" value="<%= (persona != null) ? persona.getIdentificacion() : "" %>">
        <input type="hidden" name="idPersona" value="<%= idPersona %>">

        <table class="table">
            <tr>
                <td><strong>Colaborador:</strong></td>
                <td><%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() : "No seleccionado" %></td>
            </tr>
            <tr>
                <td><strong>Fecha Ingreso:</strong></td>
                <td><%= fechaIngresoStr %></td>
            </tr>
            <tr>
                <td><label for="diaDisfrutado">Día disfrutado:</label></td>
                <td>
                    <input type="date" name="diaDisfrutado" id="diaDisfrutado" required value="<%= diaDisfrutado %>">
                </td>
            </tr>
            <tr>
                <td><label for="cartaFamilia">¿Se adjuntó carta firmada?</label></td>
                <td>
                    <select name="cartaFamilia" id="cartaFamilia" required>
                        <option value="">--Seleccione--</option>
                        <option value="SI" <%= "SI".equalsIgnoreCase(cartaFamilia) ? "selected" : "" %>>Sí</option>
                        <option value="NO" <%= "NO".equalsIgnoreCase(cartaFamilia) ? "selected" : "" %>>No</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="observacion">Observación:</label></td>
                <td>
                    <textarea name="observacion" id="observacion" rows="3" cols="40"><%= observacion %></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button class="submit" type="submit">Guardar</button>
                    <a href="verRegistroDiaFamlia.jsp?identificacion=<%= identificacionPersona1 %>">
                        <button class="button" type="button">Cancelar</button>
                    </a>
                </td>
            </tr>
        </table>
    </form>
</div>
