<%@page import="clases.Cargo"%>
<%@ page import="java.util.List" %>
<%@ page import="clases.Persona" %>
<%@ page import="clases.DiaFamilia" %>
<%@ page import="java.util.Calendar" %> <!-- Aquí importamos Calendar -->
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.PrintWriter" %>

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
        response.setHeader("Content-Disposition", "inline; filename=\"Reporte Dia Familia" + extensionArchivo + "\"");
    }
%>

<%!
    public int calcularDiasFamilia(java.util.Date fechaIngreso, int diasDisfrutados) {
        Calendar ingreso = Calendar.getInstance();
        ingreso.setTime(fechaIngreso);

        Calendar hoy = Calendar.getInstance();

        int mesesTrabajados = (hoy.get(Calendar.YEAR) - ingreso.get(Calendar.YEAR)) * 12 +
                              (hoy.get(Calendar.MONTH) - ingreso.get(Calendar.MONTH));

        int diasAcumulados = mesesTrabajados / 6; // 1 día cada 6 meses
        return diasAcumulados - diasDisfrutados;
    }
%>

<h2>REPORTE GENERAL - DÍA DE LA FAMILIA ACTIVOS GREEN S.A.S </h2>

<%
    if (!isDownloadMode) {
%>
    <!-- Íconos para exportar -->
    <a href="diaFamilia.jsp?formato=excel" target="_blank"><img src="../presentacion/iconos/excel.png " alt="Exportar a Excel"></a>
    <a href="diaFamilia.jsp?formato=word" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>
<%
    }
%>

<table border="1" class="tabla" style="margin-top:20px; width:100%; font-size: 14px;">
    <tr style="background-color: #e0e0e0;">
        <th>Identificación</th>
        <th>Nombre completo</th>
        <th>Cargo</th>
        <th>Unidad de negocio</th>
        <th>Fecha ingreso</th>
        <th>Días disfrutados</th>
        <th>Días acumulados restantes</th>
    </tr>

<%
    // Asegúrate de que la clase Persona filtra por el campo correcto que es 'tipo'
    List<Persona> listaPersonas = Persona.getListaEnObjetos("tipo = 'C'", null);

    for (Persona p : listaPersonas) {
        if (p.getFechaIngreso() == null || p.getFechaIngreso().isEmpty()) continue;

        List<DiaFamilia> diasPersona = DiaFamilia.getListaEnObjetos("identificacionPersona1 = '" + p.getIdentificacion() + "'", null);
        int diasDisfrutados = diasPersona.size();

        int diasRestantes = 0;
        try {
            java.util.Date fechaIngreso = new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaIngreso());
            diasRestantes = calcularDiasFamilia(fechaIngreso, diasDisfrutados);
        } catch (Exception e) {
            diasRestantes = -1;
        }
%>
    <tr>
        <td><%= p.getIdentificacion() %></td>
        <td><%= p.getNombres() %> <%= p.getApellidos() %></td>
        <td><%= Cargo.getCargoPersona(p.getIdentificacion()) %></td>  <!-- Aquí mostramos el nombre del cargo -->
        <td><%= p.getUnidadNegocio() %></td>
        <td><%= p.getFechaIngreso() %></td>
        <td><%= diasDisfrutados %></td>
        <td><%= diasRestantes >= 0 ? diasRestantes : "Error cálculo" %></td>
    </tr>
<%
    }
%>
</table>
