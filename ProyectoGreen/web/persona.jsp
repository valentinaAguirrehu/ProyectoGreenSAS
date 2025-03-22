<%-- 
    Document   : persona
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.Cargo"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>

<%
    String lista = "";

    List<Persona> datos = Persona.getListaEnObjetos(null, null);

    for (Persona persona : datos) {
        lista += "<tr>";
        lista += "<td align='right'>" + persona.getIdentificacion() + "</td>";
        lista += "<td>" + persona.getNombres() + "</td>";
        lista += "<td>" + persona.getApellidos() + "</td>";
        lista += "<td>" + Cargo.getCargoPersona(persona.getIdentificacion()) + "</td>";
        lista += "<td>";
        lista += "<a href='personaFormulario.jsp?accion=Modificar&identificacion=" + persona.getIdentificacion() + "' title='Modificar'>";
        lista += "<img src='presentacion/iconos/modificar.png' alt='Modificar'/></a> ";
        lista += "<img src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(" + persona.getIdentificacion() + ")' style='cursor:pointer;'/>";
        lista += "<img src='presentacion/iconos/ojo.png' title='Ver Detalles' onClick='verDetalles(" + persona.getIdentificacion() + ")'> ";
        lista += "</td>";
        lista += "</tr>";
    }
%>

<h3>Lista de Colaboradores</h3>
<table border="1">
    <tr>
        <th>Identificación</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Cargo</th>
        <th>Acciones</th>
    </tr>
    <%= lista%> 
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
