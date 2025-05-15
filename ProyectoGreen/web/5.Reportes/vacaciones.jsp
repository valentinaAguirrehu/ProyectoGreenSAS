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
        response.setHeader("Content-Disposition", "inline; filename=\"Reporte_Vacaciones-" + fechaActual + extensionArchivo + "\"");
    }
%>

<% if (!isDownloadMode) { %>
<style>
    body {
        display: flex;
        min-height: 10vh;
        margin: 0;
    }
    /* Estilo del título */
    .titulo {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 2px;
        font-weight: bold;
        color: #2c6e49;
        position: relative;
        text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2); /* Sombra ligera para efecto 3D */
        transition: transform 0.3s ease-in-out;
    }
    /* Efecto de elevación al pasar el mouse */
    .titulo:hover {
        transform: scale(1.05);
    }
    /* Estilos de la tabla */
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
    /* Iconos de acciones */
    .table img {
        cursor: pointer;
        transition: transform 0.2s;
    }
    .table img:hover {
        transform: scale(1.1);
    }
    /* Botón de añadir */
    .table th:last-child {
        text-align: center;
    }
    .content {
        flex-grow: 1;
        overflow-x: auto;
        margin-left: 220px; /* Desplazar el contenido a la derecha */
        padding: 20px;
    }
</style>
<% } %>

<%!
    public int calcularVacacionesAcumuladas(java.util.Date fechaIngreso, int diasRestados) {
        java.util.Calendar fechaActual = java.util.Calendar.getInstance();
        java.util.Calendar ingreso = java.util.Calendar.getInstance();
        ingreso.setTime(fechaIngreso);

        // Calcular los años completos de trabajo
        int aniosTrabajados = fechaActual.get(java.util.Calendar.YEAR) - ingreso.get(java.util.Calendar.YEAR);
        if (fechaActual.get(java.util.Calendar.MONTH) < ingreso.get(java.util.Calendar.MONTH)
                || (fechaActual.get(java.util.Calendar.MONTH) == ingreso.get(java.util.Calendar.MONTH)
                && fechaActual.get(java.util.Calendar.DAY_OF_MONTH) < ingreso.get(java.util.Calendar.DAY_OF_MONTH))) {
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

<% if (!isDownloadMode) {%>
<%@ include file="../menu.jsp" %> 
<% } %> 

<div class="content">

    <h3 class="titulo">REPORTE GENERAL DE VACACIONES </h3>

    <%-- Íconos para exportar si no es modo descarga --%>
    <% if (!isDownloadMode) { %>
    <a href="vacaciones.jsp?formato=excel" target="_blank"><img src="../presentacion/iconos/excel.png " alt="Exportar a Excel"></a>
    <a href="vacaciones.jsp?formato=word" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>
        <% } %>

    <table border="1" class="table" style="margin-top:20px; width:100%; font-size: 14px;">
        <tr style="background-color: #e0e0e0;">
            <th>Identificación</th>
            <th>Nombre completo</th>
            <th>Cargo</th>
            <th>Unidad de negocio</th>
            <th>Fecha ingreso</th>

            <th>Días acumulados restantes</th>
        </tr>

        <%
            // Asegúrate de que la clase Persona filtra por el campo correcto que es 'tipo'
            List<Persona> listaPersonas = Persona.getListaEnObjetos("tipo = 'C'", null);

            for (Persona p : listaPersonas) {
                if (p.getFechaIngreso() == null || p.getFechaIngreso().isEmpty()) {
                    continue;
                }

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

                if (diasRestantes <= 0) {
                    continue; // No mostrar empleados sin días acumulados
                }

        %>
        <tr>
            <td><%= p.getIdentificacion()%></td>
            <td><%= p.getNombres()%> <%= p.getApellidos()%></td>
            <td><%= Cargo.getCargoPersona(p.getIdentificacion())%></td>
            <td><%= p.getUnidadNegocio()%></td>
            <td><%= p.getFechaIngreso()%></td>
            <td><%= diasRestantes >= 0 ? diasRestantes : "Error cálculo"%></td>
        </tr>
        <%
            }
        %>
    </table>
</div>
