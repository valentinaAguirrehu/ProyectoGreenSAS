<%@page import="clases.Persona"%>
<%@page import="clases.DiaFamilia"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>

<%
    String accion = request.getParameter("accion");
    String identificacionPersona1 = request.getParameter("idPersona");
    String id = request.getParameter("id");

    Persona persona = null;
    DiaFamilia diaFamilia = null;

    // Verificamos si la identificacionPersona1 está presente en la URL
    if (identificacionPersona1 != null && !identificacionPersona1.isEmpty()) {
        persona = new Persona(identificacionPersona1);
    }

    // Si la acción es "Modificar", cargamos el objeto DiaFamilia
    if ("Modificar".equals(accion) && id != null && !id.isEmpty()) {
        diaFamilia = new DiaFamilia(id);  // Cargamos el registro existente de DiaFamilia
    } else {
        diaFamilia = new DiaFamilia();  // Nuevo registro si no es "Modificar"
    }

    // Verificamos si la observación está vacía y le asignamos un valor por defecto
    String observacion = (diaFamilia.getObservacion() == null ||
                          diaFamilia.getObservacion().trim().isEmpty() ||
                          diaFamilia.getObservacion().trim().equalsIgnoreCase("null"))
                         ? "NINGUNA"
                         : diaFamilia.getObservacion();

    // Cargamos los valores de "Día disfrutado" y "Carta familia" desde el objeto DiaFamilia
    String diaDisfrutado = (diaFamilia.getDiaDisfrutado() != null) ? diaFamilia.getDiaDisfrutado() : "";
    String cartaFamilia = (diaFamilia.getCartaFamilia() != null) ? diaFamilia.getCartaFamilia() : "";
%>

<h2><%= ("Modificar".equals(accion)) ? "Modificar Día de la Familia" : "Registrar Día de la Familia" %></h2>

<form action="DiaFamiliaActualizar.jsp" method="post">
    <input type="hidden" name="accion" value="<%= accion %>">
    <input type="hidden" name="id" value="<%= (diaFamilia.getIdDiaFamilia() != null) ? diaFamilia.getIdDiaFamilia() : "" %>">
    <input type="hidden" name="IdentificacionPersona1" value="<%= (persona != null) ? persona.getIdentificacion() : "" %>">

    <table>
        <tr>
            <td><strong>Colaborador:</strong></td>
            <td><%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() : "No seleccionado" %></td>
        </tr>
        <tr>
            <td><strong>Fecha Ingreso:</strong></td>
            <td><%= (persona != null && persona.getFechaIngreso() != null) ? persona.getFechaIngreso() : "No disponible" %></td>
        </tr>
        <tr>
            <td><label for="diaDisfrutado">Día disfrutado:</label></td>
            <td>
                <input type="date" name="diaDisfrutado" id="diaDisfrutado" required
                       value="<%= diaDisfrutado %>">
            </td>
        </tr>
        <tr>
            <td><label for="cartaFamilia">¿Se adjuntó carta firmada?</label></td>
            <td>
                <select name="cartaFamilia" id="cartaFamilia" required>
                    <option value="">--Seleccione--</option>
                    <option value="SI" <%= "Si".equalsIgnoreCase(cartaFamilia) ? "selected" : "" %>>Sí</option>
                    <option value="NO" <%= "No".equalsIgnoreCase(cartaFamilia) ? "selected" : "" %>>No</option>
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
                <button type="submit">Guardar</button>
                <a href="verRegistroDiaFamlia.jsp?identificacion=<%= (persona != null) ? persona.getIdentificacion() : "" %>">
                    <button type="button">Cancelar</button>
                </a>
            </td>
        </tr>
    </table>
</form>
