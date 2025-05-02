<%-- 
    Document   : diaFamilia
    Created on : 24/04/2025, 05:25:20 PM
    Author     : VALEN
--%>

<%@page import="clases.Cargo"%>
<%@ page import="java.util.List" %>
<%@ page import="clases.Persona" %>
<%@ page import="clases.DiaFamilia" %>
<%@ page import="java.util.Calendar" %> 
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.PrintWriter" %>

<%
    boolean isDownloadMode = request.getParameter("formato") != null;
    if (isDownloadMode) {
        String tipoContenido = "";
        String extensionArchivo = "";
        String fechaActual = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
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
        response.setHeader("Content-Disposition", "inline; filename=\"Reporte_Dia_Familia-" + fechaActual + extensionArchivo + "\"");
    }
%>

<% if (!isDownloadMode) { %>
<style>
    body {
        display: flex;
        min-height: 10vh;
        margin: 0;
    }
    .titulo {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 2px;
        color: #2c6e49;
        position: relative;
        text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        transition: transform 0.3s ease-in-out;
    }
    .titulo:hover {
        transform: scale(1.05);
    }
    .table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        border-radius: 8px;
        overflow: hidden;
    }
    .table th, .table td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
        text-align: center;
    }
    .table th {
        background-color: #2c6e49;
        color: white;
        text-transform: uppercase;
    }
    .table tr:hover {
        background-color: #daf2da;
    }
    .table img {
        cursor: pointer;
        transition: transform 0.2s;
    }
    .table img:hover {
        transform: scale(1.1);
    }
    .table th:last-child {
        text-align: center;
    }
    .content {
        flex-grow: 1;
        overflow-x: auto;
        margin-left: 220px;
        padding: 20px;
    }
</style>
<% } %>

<%!
    public int calcularDiasFamilia(java.util.Date fechaIngreso, int diasDisfrutados) {
        Calendar ingreso = Calendar.getInstance();
        ingreso.setTime(fechaIngreso);

        Calendar hoy = Calendar.getInstance();

        int mesesTrabajados = (hoy.get(Calendar.YEAR) - ingreso.get(Calendar.YEAR)) * 12
                + (hoy.get(Calendar.MONTH) - ingreso.get(Calendar.MONTH));

        int diasAcumulados = mesesTrabajados / 6; // 1 día cada 6 meses
        return diasAcumulados - diasDisfrutados;
    }
%>

<% if (!isDownloadMode) {%>
<%@ include file="../menu.jsp" %> 
<% } %> 

<div class="content">
    <h3 class="titulo">REPORTE GENERAL DEL DÍA DE LA FAMILIA </h3>

    <%
        if (!isDownloadMode) {
    %>
    <a href="diaFamilia.jsp?formato=excel" target="_blank"><img src="../presentacion/iconos/excel.png " alt="Exportar a Excel"></a>
    <a href="diaFamilia.jsp?formato=word" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>
        <%
            }
        %>

    <table border="1" class="table" style="margin-top:20px; width:100%; font-size: 14px;">
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
                if (p.getFechaIngreso() == null || p.getFechaIngreso().isEmpty()) {
                    continue;
                }

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
            <td><%= p.getIdentificacion()%></td>
            <td><%= p.getNombres()%> <%= p.getApellidos()%></td>
            <td><%= Cargo.getCargoPersona(p.getIdentificacion())%></td>  
            <td><%= p.getUnidadNegocio()%></td>
            <td><%= p.getFechaIngreso()%></td>
            <td><%= diasDisfrutados%></td>
            <td><%= diasRestantes >= 0 ? diasRestantes : "Aun no se genera"%></td>
        </tr>
        <%
            }
        %>
    </table>
</div>