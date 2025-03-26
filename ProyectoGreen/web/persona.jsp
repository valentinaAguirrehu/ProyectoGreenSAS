<%@page import="clases.Cargo"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<link rel="stylesheet" href="presentacion/style-colaboradores.css">

<%
    // Obtener el parámetro de búsqueda
    String filtro = request.getParameter("filtro");
    if (filtro == null) {
        filtro = "";
    }

    String lista = "";
    List<Persona> datos = Persona.getListaEnObjetos(null, null);

    for (Persona persona : datos) {
        String identificacion = persona.getIdentificacion();
        String nombres = persona.getNombres();
        String apellidos = persona.getApellidos();
        String cargo = Cargo.getCargoPersona(persona.getIdentificacion());
        String establecimiento = persona.getEstablecimiento();
        String fechaIngreso = persona.getFechaIngreso();

        // Verificar si el filtro coincide con alguno de los campos
        if (identificacion.toLowerCase().contains(filtro.toLowerCase()) ||
            nombres.toLowerCase().contains(filtro.toLowerCase()) ||
            apellidos.toLowerCase().contains(filtro.toLowerCase()) ||
            cargo.toLowerCase().contains(filtro.toLowerCase()) ||
            establecimiento.toLowerCase().contains(filtro.toLowerCase()) ||
            fechaIngreso.toLowerCase().contains(filtro.toLowerCase()) ||
            filtro.isEmpty()) {
            
            lista += "<tr>";
            lista += "<td align='right'>" + identificacion + "</td>";
            lista += "<td>" + nombres + "</td>";
            lista += "<td>" + apellidos + "</td>";
            lista += "<td>" + cargo + "</td>";
            lista += "<td>" + establecimiento + "</td>";
            lista += "<td>" + fechaIngreso + "</td>";
            lista += "<td>";
            lista += "<a href='personaFormulario.jsp?accion=Modificar&identificacion=" + identificacion + "' title='Modificar'>";
            lista += "<img src='presentacion/iconos/modificar.png' alt='Modificar'/></a> ";
            lista += "<img src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(" + identificacion + ")' style='cursor:pointer;'/>";
            lista += "<img src='presentacion/iconos/ojo.png' title='Ver Detalles' onClick='verDetalles(" + identificacion + ")'> ";
            lista += "</td>";
            lista += "</tr>";
        }
    }
%>

<h3>Lista de Colaboradores</h3>

<!-- Campo de búsqueda -->
<form method="GET">
    <input type="text" name="filtro" value="<%= filtro %>" placeholder="Buscar por identificación, nombre, cargo, establecimiento o fecha de ingreso" class="recuadro">
    <button type="submit">Buscar</button>
</form>

<table class="table">
    <tr>
        <th>Identificación</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Cargo</th>
        <th>Establecimiento</th>
        <th>Fecha de Ingreso</th>
        <th>Acciones</th>
    </tr>
    <%= lista %> 
</table>

<!-- Botón para agregar un nuevo colaborador -->
<div class="add-button" style="margin-top: 10px;">
    <a href="personaFormulario.jsp?accion=Adicionar" title="Agregar">
        <img src="presentacion/iconos/agregar.png" alt="Agregar" style="width: 20px; vertical-align: middle;"> Agregar Colaboradores
    </a>
</div>

<!-- Script para eliminar una persona con confirmación -->
<script type="text/javascript">
    function eliminar(identificacion) {
        var respuesta = confirm("¿Realmente desea eliminar el registro del colaborador?");
        if (respuesta) {
            window.location.href = "personaActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
    function verDetalles(identificacion) {
        document.location = "personaDetalles.jsp?identificacion=" + identificacion;
    }
</script>

<!-- Botón de cancelar para regresar a la página anterior -->
<input type="button" value="Cancelar" onClick="window.history.back()">
