<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.Cargo"%>
<%@page import="java.sql.Date" %>
<%@page import="clases.Vacaciones" %>
<%@page import="clases.Persona" %>
<%@page import="clases.InformacionLaboral" %> 
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="clases.Administrador"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }
%>

<%!
    public int calcularVacacionesAcumuladas(java.util.Date fechaIngreso, int diasRestados) {
        Calendar fechaActual = Calendar.getInstance();
        Calendar ingreso = Calendar.getInstance();
        ingreso.setTime(fechaIngreso);

        int aniosTrabajados = fechaActual.get(Calendar.YEAR) - ingreso.get(Calendar.YEAR);
        if (fechaActual.get(Calendar.MONTH) < ingreso.get(Calendar.MONTH)
                || (fechaActual.get(Calendar.MONTH) == ingreso.get(Calendar.MONTH)
                && fechaActual.get(Calendar.DAY_OF_MONTH) < ingreso.get(Calendar.DAY_OF_MONTH))) {
            aniosTrabajados--;
        }

        aniosTrabajados = Math.max(aniosTrabajados, 0);
        int diasAcumulados = aniosTrabajados * 15;
        return diasAcumulados - diasRestados;
    }
%>

<%
    String identificacionParam = request.getParameter("identificacion");
    Persona personaSeleccionada = null;
    InformacionLaboral infoLaboral = null;
    List<Vacaciones> listaVacaciones = new ArrayList<>();

    if (identificacionParam != null && !identificacionParam.isEmpty()) {
        personaSeleccionada = new Persona(identificacionParam);
        infoLaboral = InformacionLaboral.getInformacionPorIdentificacion(identificacionParam);
    }

    try {
        if (personaSeleccionada != null) {
            listaVacaciones = Vacaciones.getListaEnObjetos("Id_persona = '" + personaSeleccionada.getIdentificacion() + "'", null);
        } else {
            listaVacaciones = Vacaciones.getListaEnObjetos(null, null);
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error al obtener las vacaciones: " + e.toString() + "</p>");
    }

    String tabla = "";
    int totalDiasDisfrutados = 0;
    int totalDiasCompensar = 0;

    for (Vacaciones v : listaVacaciones) {
        if (v == null || v.getIdPersona() == null) {
            tabla += "<tr><td colspan='7' style='color:red;'>Registro inválido o incompleto en la lista de vacaciones.</td></tr>";
            continue;
        }

        Persona p = new Persona(v.getIdPersona());

        String observacion = (v.getObservacion() == null || v.getObservacion().trim().isEmpty()
                || v.getObservacion().trim().equalsIgnoreCase("null")) ? "Ninguna" : v.getObservacion();

        tabla += "<tr>";
        tabla += "<td>" + (v.getPeriodoDisfrute() != null ? v.getPeriodoDisfrute() : "-") + "</td>";
        tabla += "<td>" + (v.getPeriodoDisfruteFin() != null ? v.getPeriodoDisfruteFin() : "-") + "</td>";
        tabla += "<td>" + v.getDiasDisfrutados() + "</td>";
        tabla += "<td>" + (v.getDiasCompensados() != null ? v.getDiasCompensados() : "0") + "</td>";
        tabla += "<td>" + (v.getDiasCompensar() != null ? v.getDiasCompensar() : "0") + "</td>";
        tabla += "<td>" + observacion + "</td>";
        tabla += "<td>";
        tabla += "<a href='vacacionesFormulario.jsp?accion=Modificar&id=" + v.getIdVacaciones() + "&idPersona=" + p.getIdentificacion() + "'><img src='../presentacion/iconos/modificar.png' title='Modificar'/></a> ";
        tabla += "<a href='vacacionesActualizar.jsp?accion=Eliminar&id=" + v.getIdVacaciones() + "&idPersona=" + p.getIdentificacion() + "' onclick='return confirm(\"¿Deseas eliminar este registro?\")'><img src='../presentacion/iconos/eliminar.png' title='Eliminar'/></a>";
        tabla += "</td>";
        tabla += "</tr>";

        try {
            if (v.getDiasDisfrutados() != null && !v.getDiasDisfrutados().trim().isEmpty()) {
                totalDiasDisfrutados += Integer.parseInt(v.getDiasDisfrutados());
            }
            if (v.getDiasCompensar() != null && !v.getDiasCompensar().trim().isEmpty()) {
                totalDiasCompensar += Integer.parseInt(v.getDiasCompensar());
            }
        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
        }
    }

    int vacacionesAcumuladas = 0;
    String fechaIngresoString = (infoLaboral != null) ? infoLaboral.getFechaIngreso() : null;
    if (fechaIngresoString != null && !fechaIngresoString.isEmpty()) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date fechaIngresoDate = sdf.parse(fechaIngresoString);
            int totalRestado = totalDiasDisfrutados + totalDiasCompensar;
            vacacionesAcumuladas = calcularVacacionesAcumuladas(fechaIngresoDate, totalRestado);
        } catch (java.text.ParseException e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>Error al convertir la fecha de ingreso: " + e.getMessage() + "</p>");
        }
    }
%>

<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>

<head>
    <link rel="stylesheet" href="../presentacion/style-Usuarios.css">
    <style>
        .dias-acumulados-con-boton {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 20px;
            border: 1px solid #ccc;
            padding: 10px;
            background: #f9f9f9;
        }

        .dias-acumulados-con-boton p {
            margin: 0;
            font-weight: bold;
        }

        .btn-volver {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-volver:hover {
            background-color: #218838;
        }
    </style>
</head>

<div class="content">
    <h3 class="titulo">REGISTROS DE VACACIONES</h3>

    <% if (personaSeleccionada != null) { %>
    <div style="margin-top:20px; border:1px solid #ccc; padding:10px; background:#f9f9f9;">
        <h3>Información del colaborador seleccionado:</h3>
        <p><strong>Identificación:</strong> <%= personaSeleccionada.getIdentificacion() %></p>
        <p><strong>Nombre completo:</strong> <%= personaSeleccionada.getNombres() %> <%= personaSeleccionada.getApellidos() %></p>
        <p><strong>Cargo:</strong> <%= Cargo.getCargoPersona(personaSeleccionada.getIdentificacion()) %></p>
        <p><strong>Unidad de negocio:</strong> <%= (infoLaboral != null && infoLaboral.getUnidadNegocio() != null) ? infoLaboral.getUnidadNegocio() : "No disponible" %></p>
        <p><strong>Fecha de ingreso:</strong> <%= (infoLaboral != null && infoLaboral.getFechaIngreso() != null) ? infoLaboral.getFechaIngreso() : "No disponible" %></p>
    </div>

    <div class="dias-acumulados-con-boton">
        <p>Vacaciones acumuladas restantes: <%= vacacionesAcumuladas %> días</p>
        <a href="../3.HistoriaLaboral/detalleHistoria.jsp?identificacion=<%= personaSeleccionada.getIdentificacion() %>&tipo=Votros" class="btn-volver">VOLVER</a>
    </div>
    <% } %>

    <table border="1" class="table" style="margin-top:20px;">
        <tr>
            <th>Periodo Disfrute</th>
            <th>Periodo Disfrute Fin</th>
            <th>Días Disfrutados</th>
            <th>Días Compensados</th>
            <th>Días a Compensar</th>
            <th>Observación</th>
            <% if (personaSeleccionada != null) { %>
            <th>
                <a href='vacacionesFormulario.jsp?accion=Adicionar&idPersona=<%= personaSeleccionada.getIdentificacion() %>'>
                    <img src='../presentacion/iconos/agregar.png' width='25' height='25' title='Agregar Vacaciones'>
                </a>
            </th>
            <% } else { %>
            <th style="color:red;">Persona no seleccionada</th>
            <% } %>
        </tr>
        <%= tabla %>
    </table>

    <% if (listaVacaciones.isEmpty()) { %>
    <p style="color:red;">No hay registros de vacaciones.</p>
    <% } %>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        controlarPermisos(
            <%= administrador.getpEliminar() %>,
            <%= administrador.getpEditar() %>,
            <%= administrador.getpAgregar() %>
        );
    });
</script>
