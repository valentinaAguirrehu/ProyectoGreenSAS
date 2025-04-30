<%-- 
    Document   : vacaciones
    Created on : 24/04/2025, 05:21:20 PM
    Author     : VALEN
--%>

<%@page import="clases.Cargo"%>
<%@ page import="java.sql.Date" %>
<%@ page import="clases.Vacaciones" %>
<%@ page import="clases.Persona" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
public int calcularVacacionesAcumuladas(java.util.Date fechaIngreso, int diasRestados) {
    java.util.Calendar fechaActual = java.util.Calendar.getInstance();
    java.util.Calendar ingreso = java.util.Calendar.getInstance();
    ingreso.setTime(fechaIngreso);

    // Calcular los años completos de trabajo
    int aniosTrabajados = fechaActual.get(java.util.Calendar.YEAR) - ingreso.get(java.util.Calendar.YEAR);
    if (fechaActual.get(java.util.Calendar.MONTH) < ingreso.get(java.util.Calendar.MONTH) ||
        (fechaActual.get(java.util.Calendar.MONTH) == ingreso.get(java.util.Calendar.MONTH) &&
         fechaActual.get(java.util.Calendar.DAY_OF_MONTH) < ingreso.get(java.util.Calendar.DAY_OF_MONTH))) {
        aniosTrabajados--;
    }
    if (aniosTrabajados < 0) { 
        aniosTrabajados = 0;
    }

    // Acumula 15 días por cada año completo de trabajo
    int diasAcumulados = aniosTrabajados * 15;
    
    // Se restan los días disfrutados + compensados
    return diasAcumulados - diasRestados;
}
%>

<h2>REPORTE DE VACACIONES ACTIVOS GREE S.A.S</h2>

<%
    boolean isDownloadMode = request.getParameter("formato") != null;
    if (isDownloadMode) {
        String tipoContenido = "";
        String extensionArchivo = "";
        switch (request.getParameter("formato")) {
            case "excel":
                tipoContenido = "application/vnd.ms-excel";
                extensionArchivo = ".xls";
                break;
            case "word":
                tipoContenido = "application/vnd.msword";
                extensionArchivo = ".doc";
                break;
        }
        response.setContentType(tipoContenido);
        response.setHeader("Content-Disposition", "inline; filename=\"Reporte Vacaciones" + extensionArchivo + "\"");
    }
%>

<%-- Íconos para exportar si no es modo descarga --%>
<% if (!isDownloadMode) { %>
<a href="vacaciones.jsp?formato=excel" target="_blank"><img src="../presentacion/iconos/excel.png " alt="Exportar a Excel"></a>
    <a href="vacaciones.jsp?formato=word" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>
<% } %>

<table border="1" class="tabla" style="margin-top:20px; width:100%; font-size: 14px;">
    <tr style="background-color: #e0e0e0;">
        <th>Identificación</th>
        <th>Nombre completo</th>
        <th>Cargo</th>
        <th>Unidad de negocio</th>
        <th>Fecha ingreso</th>
        <th>Días disfrutados</th>
        <th>Días a compensar</th>
        <th>Días acumulados restantes</th>
    </tr>

<%
    // Asegúrate de que la clase Persona filtra por el campo correcto que es 'tipo'
    List<Persona> listaPersonas = Persona.getListaEnObjetos("tipo = 'C'", null);

    for (Persona p : listaPersonas) {
        if (p.getFechaIngreso() == null || p.getFechaIngreso().isEmpty()) continue;

        List<Vacaciones> vacacionesPersona = Vacaciones.getListaEnObjetos("Id_persona = '" + p.getIdentificacion() + "'", null);
        int diasDisfrutados = 0;
        int diasCompensar = 0;

        for (Vacaciones v : vacacionesPersona) {
            diasDisfrutados += Integer.parseInt(v.getDiasDisfrutados() != null ? v.getDiasDisfrutados() : "0");
            diasCompensar += Integer.parseInt(v.getDiasCompensar() != null ? v.getDiasCompensar() : "0");
        }

        int diasRestantes = 0;
        try {
            java.util.Date fechaIngreso = new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaIngreso());
            int totalRestado = diasDisfrutados + diasCompensar;
            diasRestantes = calcularVacacionesAcumuladas(fechaIngreso, totalRestado);
        } catch (Exception e) {
            diasRestantes = -1;
        }
%>
    <tr>
        <td><%= p.getIdentificacion() %></td>
        <td><%= p.getNombres() %> <%= p.getApellidos() %></td>
        <td><%= Cargo.getCargoPersona(p.getIdentificacion()) %></td>
        <td><%= p.getUnidadNegocio() %></td>
        <td><%= p.getFechaIngreso() %></td>
        <td><%= diasDisfrutados %></td>
        <td><%= diasCompensar %></td>
        <td><%= diasRestantes >= 0 ? diasRestantes : "Error cálculo" %></td>
    </tr>
<%
    }
%>
</table>
