<%@page import="clases.Vacaciones"%>
<%@page import="clases.Persona"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>

<%
    String identificacionParam = request.getParameter("identificacion");
    Persona personaSeleccionada = null;

    if (identificacionParam != null && !identificacionParam.isEmpty()) {
        personaSeleccionada = new Persona(identificacionParam);
    }

    List<Vacaciones> listaVacaciones = Vacaciones.getListaEnObjetos(null, null);
    String tabla = "";

    for (Vacaciones v : listaVacaciones) {
        Persona p = new Persona(v.getIdPersona());

        String fechaIngresoStr = "No registrada";
        String fechaVacacion = "No calculada";

        try {
            String fechaIngresoTexto = p.getFechaIngreso();

            if (fechaIngresoTexto != null && !fechaIngresoTexto.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date fechaIngresoReal = sdf.parse(fechaIngresoTexto);

                fechaIngresoStr = sdf.format(fechaIngresoReal);

                Calendar cal = Calendar.getInstance();
                cal.setTime(fechaIngresoReal);
                cal.add(Calendar.YEAR, 1); // Sumar un año

                fechaVacacion = sdf.format(cal.getTime());
            }
        } catch (Exception e) {
            System.out.println("Error al calcular fecha de vacación: " + e.getMessage());
        }

        tabla += "<tr>";
        tabla += "<td>" + fechaVacacion + "</td>";
        tabla += "<td>" + v.getObservacion() + "</td>";
        tabla += "<td>" + v.getEstado() + "</td>";
        tabla += "<td>";
        tabla += "<a href='vacacionesFormulario.jsp?accion=Modificar&id=" + v.getId() + "&idPersona=" + p.getIdentificacion() + "'><img src='../presentacion/iconos/modificar.png' title='Modificar'/></a> ";
        tabla += "<a href='vacacionesActualizar.jsp?accion=Eliminar&id=" + v.getId() + "&idPersona=" + p.getIdentificacion() + "' onclick='return confirm(\"¿Deseas eliminar este registro?\")'><img src='../presentacion/iconos/eliminar.png' title='Eliminar'/></a>";
        tabla += "</td>";
        tabla += "</tr>";
    }
%>

<h2>REGISTROS DE VACACIONES</h2>

<a href='../3.HistoriaLaboral/vacacionesFormulario.jsp?accion=Adicionar'>
    <img src='../presentacion/iconos/agregar.png' width='30' height='30' title='Agregar Vacación'>
</a>

<% if (personaSeleccionada != null) {%>
<div style="margin-top:20px; border:1px solid #ccc; padding:10px; background:#f9f9f9;">
    <h3>Información del colaborador seleccionado:</h3>
    <p><strong>Identificación:</strong> <%= personaSeleccionada.getIdentificacion()%></p>
    <p><strong>Nombre completo:</strong> <%= personaSeleccionada.getNombres()%> <%= personaSeleccionada.getApellidos()%></p>
    <p><strong>Fecha de ingreso:</strong> <%= personaSeleccionada.getFechaIngreso()%></p>
    <a href="../3.HistoriaLaboral/vacacionesFormulario.jsp?accion=Adicionar&idPersona=<%= personaSeleccionada.getIdentificacion()%>">
        <img src='../presentacion/iconos/agregar.png' width='20' height='20' title='Agregar Vacación para este colaborador'> Agregar vacación para esta persona
    </a>
</div>
<% }%>

<table border="1" class="tabla" style="margin-top:20px;">
    <tr>
        <th>Fecha Vacación</th>
        <th>Observación</th>
        <th>Estado</th>
        <th>Acciones</th>
    </tr>
    <%= tabla%>
</table>
