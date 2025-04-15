<%-- 
    Document   : vacacionesFormulario
    Created on : 11/04/2025, 04:33:43 PM
    Author     : VALEN
--%>

<%@page import="clases.Persona"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>

<%
    String accion = request.getParameter("accion");
    String idPersona = request.getParameter("idPersona");

    Persona persona = null;
    String fechaVacacion = "No calculada";

    if (idPersona != null && !idPersona.isEmpty()) {
        persona = new Persona(idPersona);

        try {
            String fechaIngresoTexto = persona.getFechaIngreso();

            if (fechaIngresoTexto != null && !fechaIngresoTexto.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date fechaIngresoReal = sdf.parse(fechaIngresoTexto);

                Calendar cal = Calendar.getInstance();
                cal.setTime(fechaIngresoReal);
                cal.add(Calendar.YEAR, 1); // Sumar un año

                fechaVacacion = sdf.format(cal.getTime());
            }
        } catch (Exception e) {
            System.out.println("Error al calcular fecha de vacación: " + e.getMessage());
        }
    }
%>

<h2>Registrar Vacaciones</h2>

<form action="vacacionesActualizar.jsp" method="post">
    <input type="hidden" name="accion" value="Adicionar">
    <input type="hidden" name="idPersona" value="<%= (persona != null) ? persona.getIdentificacion() : "" %>">

    <table>
        <tr>
            <td><strong>Colaborador:</strong></td>
            <td><%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() : "No seleccionado" %></td>
        </tr>
        <tr>
            <td><strong>Fecha Ingreso:</strong></td>
            <td><%= (persona != null) ? persona.getFechaIngreso() : "No disponible" %></td>
        </tr>
        <tr>
            <td><strong>Fecha Vacación:</strong></td>
            <td><%= fechaVacacion %></td>
        </tr>
        <tr>
            <td><label for="observacion">Observación:</label></td>
            <td><textarea name="observacion" id="observacion" rows="3" cols="40" required></textarea></td>
        </tr>
        <tr>
            <td><label for="estado">Estado:</label></td>
            <td>
                <select name="estado" id="estado" required>
                    <option value="">--Seleccione--</option>
                    <option value="Pendiente">Pendiente</option>
                    <option value="Aprobado">Aprobado</option>
                    <option value="Rechazado">Rechazado</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <button type="submit">Guardar</button>
                <a href="verRegistrosVacaciones.jsp">
                    <button type="button">Cancelar</button>
                </a>
            </td>
        </tr>
    </table>
</form>
