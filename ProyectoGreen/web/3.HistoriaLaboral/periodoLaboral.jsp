<%@page import="clases.PeriodoLaboral"%>
<%@page import="clases.Persona"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>

<%
    // Recoger el parámetro correcto desde la URL
    String idColaboradorParam = request.getParameter("identificacion");
    Persona personaSeleccionada = null;

    if (idColaboradorParam != null && !idColaboradorParam.isEmpty()) {
        personaSeleccionada = new Persona(idColaboradorParam);
    }

    List<PeriodoLaboral> listaPeriodos = PeriodoLaboral.getListaEnObjetos(null, null);
    String tabla = "";

    for (PeriodoLaboral p : listaPeriodos) {
        Persona persona = new Persona(p.getIdColaborador());

        String fechaInicioStr = "No registrada";
        String fechaFinStr = "No registrada";

        try {
            String fechaInicioTexto = p.getFechaInicio();
            String fechaFinTexto = p.getFechaFin();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            if (fechaInicioTexto != null && !fechaInicioTexto.isEmpty()) {
                Date fechaInicioReal = sdf.parse(fechaInicioTexto);
                fechaInicioStr = sdf.format(fechaInicioReal);
            }

            if (fechaFinTexto != null && !fechaFinTexto.isEmpty()) {
                Date fechaFinReal = sdf.parse(fechaFinTexto);
                fechaFinStr = sdf.format(fechaFinReal);
            }

        } catch (Exception e) {
            System.out.println("Error al calcular fechas: " + e.getMessage());
        }

        tabla += "<tr>";
        tabla += "<td>" + fechaInicioStr + "</td>";
        tabla += "<td>" + fechaFinStr + "</td>";
        tabla += "<td>" + p.getVacacionesDisponibles() + "</td>";
        tabla += "<td>" + p.getVacacionesTomadas() + "</td>";
        tabla += "<td>";
        tabla += "<a href='periodoLaboralFormulario.jsp?accion=Modificar&id=" + p.getIdPeriodo() + "'><img src='../presentacion/iconos/modificar.png' title='Modificar'/></a> ";
        tabla += "<a href='periodoLaboralActualizar.jsp?accion=Eliminar&id=" + p.getIdPeriodo() + "' onclick='return confirm(\"¿Deseas eliminar este registro?\")'><img src='../presentacion/iconos/eliminar.png' title='Eliminar'/></a>";
        tabla += "</td>";
        tabla += "</tr>";
    }
%>

<h2>REGISTROS DE PERIODOS LABORALES</h2>

<!-- Mostrar botón general de agregar periodo -->
<a href='../3.HistoriaLaboral/periodoLaboralFormulario.jsp?accion=Adicionar'>
    <img src='../presentacion/iconos/agregar.png' width='30' height='30' title='Agregar Periodo Laboral'>
</a>

<!-- Mostrar datos del colaborador si fue seleccionado -->
<% if (personaSeleccionada != null && personaSeleccionada.getNombres() != null) { %>
    <div style="margin-top:20px; border:1px solid #ccc; padding:10px; background:#f9f9f9;">
        <h3>Información del colaborador seleccionado:</h3>
        <p><strong>Identificación:</strong> <%= personaSeleccionada.getIdentificacion() %></p>
        <p><strong>Nombre completo:</strong> <%= personaSeleccionada.getNombres() %> <%= personaSeleccionada.getApellidos() %></p>
        <p><strong>Fecha de ingreso:</strong> <%= personaSeleccionada.getFechaIngreso() %></p>
        <a href="../3.HistoriaLaboral/periodoLaboralFormulario.jsp?accion=Adicionar&idColaborador=<%= personaSeleccionada.getIdentificacion() %>">
            <img src='../presentacion/iconos/agregar.png' width='20' height='20' title='Agregar periodo para este colaborador'> Agregar periodo laboral para este colaborador
        </a>
    </div>
<% } %>

<!-- Tabla de registros -->
<table border="1" class="tabla" style="margin-top:20px;">
    <tr>
        <th>Fecha Inicio</th>
        <th>Fecha Fin</th>
        <th>Vacaciones Disponibles</th>
        <th>Vacaciones Tomadas</th>
        <th>Acciones</th>
    </tr>
    <%= tabla %>
</table>
