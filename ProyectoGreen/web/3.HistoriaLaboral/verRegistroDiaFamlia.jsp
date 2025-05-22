<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.Cargo"%>
<%@ page import="java.sql.Date" %>
<%@ page import="clases.DiaFamilia" %>
<%@ page import="clases.Persona" %>
<%@ page import="clases.InformacionLaboral" %>  <%-- Importa esta clase --%>
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

<%
    String identificacionParam = request.getParameter("identificacion");
    Persona personaSeleccionada = null;
    InformacionLaboral infoLaboral = null;

    if (identificacionParam != null && !identificacionParam.isEmpty()) {
        personaSeleccionada = new Persona(identificacionParam);
        infoLaboral = InformacionLaboral.getInformacionPorIdentificacion(identificacionParam);
    }

    List<DiaFamilia> listaDias = new ArrayList<>();

    try {
        if (personaSeleccionada != null) {
            listaDias = DiaFamilia.getListaEnObjetos("identificacionPersona1 = '" + personaSeleccionada.getIdentificacion() + "'", null);
        } else {
            listaDias = DiaFamilia.getListaEnObjetos(null, null);
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error al obtener días de la familia: " + e.toString() + "</p>");
    }

    String tabla = "";
    int totalDisfrutados = 0;

    for (DiaFamilia d : listaDias) {
        if (d == null || d.getIdentificacionPersona1() == null) {
            tabla += "<tr><td colspan='5' style='color:red;'>Registro inválido o incompleto en Día de la Familia.</td></tr>";
            continue;
        }

        Persona p = null;
        try {
            p = new Persona(d.getIdentificacionPersona1());
        } catch (Exception ex) {
            tabla += "<tr><td colspan='5' style='color:red;'>Error al cargar persona: " + ex.getMessage() + "</td></tr>";
            continue;
        }

        String observacion = (d.getObservacion() == null || d.getObservacion().trim().isEmpty() || d.getObservacion().equalsIgnoreCase("null"))
                ? "Ninguna" : d.getObservacion();

        tabla += "<tr>";
        tabla += "<td>" + (d.getDiaDisfrutado() != null ? d.getDiaDisfrutado() : "-") + "</td>";
        tabla += "<td>" + (d.getCartaFamilia() != null ? d.getCartaFamilia() : "-") + "</td>";
        tabla += "<td>" + observacion + "</td>";

        tabla += "<td>";
        tabla += "<a href='DiaFamiliaFormulario.jsp?accion=Modificar&id=" + d.getIdDiaFamilia() + "&idPersona=" + p.getIdentificacion() + "&identificacion=" + p.getIdentificacion() + "'><img src='../presentacion/iconos/modificar.png' width='25' height='25' title='Modificar'/></a> ";
        tabla += "<a href='DiaFamiliaActualizar.jsp?accion=Eliminar&id=" + d.getIdDiaFamilia() + "&idPersona=" + p.getIdentificacion() + "' onclick='return confirm(\"¿Deseas eliminar este registro?\")'><img src='../presentacion/iconos/eliminar.png' width='25' height='25' title='Eliminar'/></a>";
        tabla += "</td>";
        tabla += "</tr>";

        totalDisfrutados++;
    }

    int diasFamiliaAcumulados = 0;
    if (infoLaboral != null) {
        String fechaIngresoStr = infoLaboral.getFechaIngreso();
        if (fechaIngresoStr != null && !fechaIngresoStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date fechaIngreso = sdf.parse(fechaIngresoStr);
                diasFamiliaAcumulados = calcularDiasFamilia(fechaIngreso, totalDisfrutados);
            } catch (Exception e) {
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
    <h3 class="titulo">REGISTROS DE DÍA DE LA FAMILIA</h3>

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
        <p>Días de la familia acumulados restantes: <%= diasFamiliaAcumulados %> días</p>
        <a href="../3.HistoriaLaboral/detalleHistoria.jsp?identificacion=<%= personaSeleccionada.getIdentificacion() %>&tipo=DIAFAMotros" class="btn-volver">VOLVER</a>
    </div>

    <% } %>

    <table border="1" class="table" style="margin-top:20px;">
        <tr>
            <th>Día Disfrutado</th>
            <th>Carta Día de la Familia</th>
            <th>Observación</th>
            <% if (personaSeleccionada != null) { %>
            <th>
                <a href='../3.HistoriaLaboral/DiaFamiliaFormulario.jsp?accion=Adicionar&idPersona=<%= personaSeleccionada.getIdentificacion() %>&identificacion=<%= personaSeleccionada.getIdentificacion() %>'>
                    <img src='../presentacion/iconos/agregar.png' width='25' height='25' title='Agregar Día de la Familia'>
                </a>
            </th>
            <% } else { %>
            <th style="color:red;">Persona no seleccionada</th>
            <% } %>
        </tr>
        <%= tabla %>
    </table>

    <% if (listaDias.isEmpty()) { %>
    <p style="color:red;">No hay registros de días de la familia.</p>
    <% } %>
</div>

<script>
    // PERMISOS
    document.addEventListener("DOMContentLoaded", function () {
        controlarPermisos(
            <%= administrador.getpEliminar() %>,
            <%= administrador.getpEditar() %>,
            <%= administrador.getpAgregar() %>
        );
    });
</script>
