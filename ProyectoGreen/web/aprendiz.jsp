<%-- 
    Document   : persona
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.Cargo"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<link rel="stylesheet" href="presentacion/style-colaboradores.css">
<%
    StringBuilder lista = new StringBuilder();

    List<Persona> datos = Persona.getListaEnObjetos(null, null);

    for (Persona persona : datos) {
        if (persona.getTipo().equals("A")) { 
            lista.append("<tr>");
            lista.append("<td align='right'>").append(persona.getIdentificacion()).append("</td>");
            lista.append("<td>").append(persona.getNombres()).append("</td>");
            lista.append("<td>").append(persona.getApellidos()).append("</td>");
            lista.append("<td>").append(Cargo.getCargoPersona(persona.getIdentificacion())).append("</td>");
            lista.append("<td>");
            lista.append("<a href='aprendizFormulario.jsp?accion=Modificar&identificacion=").append(persona.getIdentificacion()).append("' title='Modificar'>");
            lista.append("<img src='presentacion/iconos/modificar.png' alt='Modificar'/></a> ");
            lista.append("<img src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(").append(persona.getIdentificacion()).append(")' style='cursor:pointer;'/>");
            lista.append("<img src='presentacion/iconos/ojo.png' title='Ver Detalles' onClick='verDetalles(").append(persona.getIdentificacion()).append(")' style='cursor:pointer;'/>");
            lista.append("</td>");
            lista.append("</tr>");
        }
    }
%>
<h3>Lista de Aprendices</h3>
<table class="table">
    <tr>
        <th>Identificación</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Cargo</th>      

        <th>
            <a href="aprendizFormulario.jsp?accion=Adicionar" title="Agregar">
                <img src="presentacion/iconos/agregar.png" alt="Agregar" style="width: 20px; vertical-align: middle;">
            </a>
        </th>
    </tr>
    <%= lista %> 
</table>

<!-- Botón para agregar un nuevo colaborador -->
<div class="add-button" style="margin-top: 10px;">
    <a href="aprendizFormulario.jsp?accion=Adicionar" title="Agregar">
        <img src="presentacion/iconos/agregar.png" alt="Agregar" style="width: 20px; vertical-align: middle;"> Agregar Colaboradores
    </a>
</div>

<!-- Script para eliminar una persona con confirmación -->
<script type="text/javascript">
    function eliminar(identificacion) {
        var respuesta = confirm("¿Realmente desea eliminar el registro del aprendiz?");
        if (respuesta) {
            window.location.href = "aprendizActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
    function verDetalles(identificacion) {
    document.location = "aprendizDetalles.jsp?identificacion=" + identificacion;
}

</script>

<!-- Botón de cancelar para regresar a la página anterior -->
<input type="button" value="Cancelar" onClick="window.history.back()">
