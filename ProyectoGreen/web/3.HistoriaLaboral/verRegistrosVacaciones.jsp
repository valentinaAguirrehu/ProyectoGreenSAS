<%@page import="clases.Cargo"%>
<%@ page import="java.sql.Date" %>
<%@ page import="clases.Vacaciones" %>
<%@ page import="clases.Persona" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="clases.Administrador"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }
%>

<%!
    public int calcularVacacionesAcumuladas(java.util.Date fechaIngreso, int diasRestados) {
        java.util.Calendar fechaActual = java.util.Calendar.getInstance();
        java.util.Calendar ingreso = java.util.Calendar.getInstance();
        ingreso.setTime(fechaIngreso);

        // Calcular los a�os completos de trabajo
        int aniosTrabajados = fechaActual.get(java.util.Calendar.YEAR) - ingreso.get(java.util.Calendar.YEAR);
        if (fechaActual.get(java.util.Calendar.MONTH) < ingreso.get(java.util.Calendar.MONTH)
                || (fechaActual.get(java.util.Calendar.MONTH) == ingreso.get(java.util.Calendar.MONTH)
                && fechaActual.get(java.util.Calendar.DAY_OF_MONTH) < ingreso.get(java.util.Calendar.DAY_OF_MONTH))) {
            aniosTrabajados--;
        }
        if (aniosTrabajados < 0) {
            aniosTrabajados = 0;
        }

        // Acumula 15 d�as por cada a�o completo de trabajo
        int diasAcumulados = aniosTrabajados * 15;

        // Se restan los d�as disfrutados + compensados
        return diasAcumulados - diasRestados;
    }
%>

<%
    String identificacionParam = request.getParameter("identificacion");
    Persona personaSeleccionada = null;

    if (identificacionParam != null && !identificacionParam.isEmpty()) {
        personaSeleccionada = new Persona(identificacionParam);
    }

    List<Vacaciones> listaVacaciones = new ArrayList<>();

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

    for (Vacaciones v : listaVacaciones) {
        if (v == null || v.getIdPersona() == null) {
            tabla += "<tr><td colspan='7' style='color:red;'>Registro inv�lido o incompleto en la lista de vacaciones.</td></tr>";
            continue;
        }

        Persona p = null;
        try {
            p = new Persona(v.getIdPersona());
        } catch (Exception ex) {
            tabla += "<tr><td colspan='7' style='color:red;'>Error al cargar persona: " + ex.getMessage() + "</td></tr>";
            continue;
        }

        String observacion = (v.getObservacion() == null
                || v.getObservacion().trim().isEmpty()
                || v.getObservacion().trim().equalsIgnoreCase("null"))
                ? "Ninguna"
                : v.getObservacion();

        tabla += "<tr>";
        tabla += "<td>" + (v.getPeriodoDisfrute() != null ? v.getPeriodoDisfrute() : "-") + "</td>";
        tabla += "<td>" + (v.getPeriodoDisfruteFin() != null ? v.getPeriodoDisfruteFin() : "-") + "</td>";
        tabla += "<td>" + v.getDiasDisfrutados() + "</td>";
        tabla += "<td>" + (v.getDiasCompensados() != null ? v.getDiasCompensados() : "0") + "</td>";
        tabla += "<td>" + (v.getDiasCompensar() != null ? v.getDiasCompensar() : "0") + "</td>";
        tabla += "<td>" + observacion + "</td>";
        tabla += "<td>";
        tabla += "<a href='vacacionesFormulario.jsp?accion=Modificar&id=" + v.getIdVacaciones() + "&idPersona=" + p.getIdentificacion() + "'><img src='../presentacion/iconos/modificar.png' title='Modificar'/></a> ";
        tabla += "<a href='vacacionesActualizar.jsp?accion=Eliminar&id=" + v.getIdVacaciones() + "&idPersona=" + p.getIdentificacion() + "' onclick='return confirm(\"�Deseas eliminar este registro?\")'><img src='../presentacion/iconos/eliminar.png' title='Eliminar'/></a>";
        tabla += "</td>";
        tabla += "</tr>";
    }

    // Calcular d�as disfrutados + d�as a compensar
    int totalDiasDisfrutados = 0;
    int totalDiasCompensar = 0;

    for (Vacaciones v : listaVacaciones) {
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
    if (personaSeleccionada != null) {
        String fechaIngresoString = personaSeleccionada.getFechaIngreso();
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
    }
%>

<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %> 

<head>
    <link rel="stylesheet" href="../presentacion/style-Usuarios.css">
</head>

<div class="content">
    <h3 class="titulo">REGISTROS DE VACACIONES</h3>

    <% if (personaSeleccionada != null) {%>
    <div style="margin-top:20px; border:1px solid #ccc; padding:10px; background:#f9f9f9;">
        <h3>Informaci�n del colaborador seleccionado:</h3>
        <p><strong>Identificaci�n:</strong> <%= personaSeleccionada.getIdentificacion()%></p>
        <p><strong>Nombre completo:</strong> <%= personaSeleccionada.getNombres()%> <%= personaSeleccionada.getApellidos()%></p>
        <p><strong>Cargo:</strong> 
            <%= Cargo.getCargoPersona(personaSeleccionada.getIdentificacion())%>
        </p>

        <p><strong>Unidad de negocio</strong> <%= personaSeleccionada.getUnidadNegocio()%></p>
        <p><strong>Fecha de ingreso:</strong> <%= personaSeleccionada.getFechaIngreso()%></p>
    </div>
    <% } %>

    <% if (personaSeleccionada != null) {%>
    <div style="margin-top:20px;">

        <p><strong>Vacaciones acumuladas restantes:</strong> <%= vacacionesAcumuladas%> d�as</p>
    </div>
    <% }%>

    <table border="1" class="table" style="margin-top:20px;">
        <tr>
            <th>Periodo Disfrute</th>
            <th>Periodo Disfrute Fin</th> 
            <th>D�as Disfrutados</th>
            <th>Desea compensar d�as?</th>
            <th>D�as compensados</th>
            <th>Observaci�n</th>
            <th><a href="../3.HistoriaLaboral/vacacionesFormulario.jsp?accion=Adicionar&idPersona=<%= personaSeleccionada.getIdentificacion()%>">
                    <img src='../presentacion/iconos/agregar.png' width='30' height='30' title='Agregar Vacaci�n'>
                </a></th>
        </tr>
        <%= tabla%>
    </table>
<% if (listaVacaciones.isEmpty()) { %>
<p style="color:red;">No hay registros de vacaciones.</p>
<% }%>
    
</div>

<script>
    // PERMISOS

    document.addEventListener("DOMContentLoaded", function () {
        controlarPermisos(
    <%= administrador.getpEliminar()%>,
    <%= administrador.getpEditar()%>,
    <%= administrador.getpAgregar()%>
        );
    });

</script>