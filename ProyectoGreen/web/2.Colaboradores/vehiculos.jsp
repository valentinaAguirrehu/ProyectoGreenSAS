<%-- 
    Document   : vehiculos
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="java.util.List"%>
<%@page import="clases.Vehiculo"%>

<%
    String lista = "";
    List<Vehiculo> datos = Vehiculo.getListaEnObjetos(null, null);

    for (Vehiculo vehiculo : datos) {
        lista += "<tr>";
        lista += "<td>" + vehiculo.getNumeroPlaca() + "</td>";
        lista += "<td>" + vehiculo.getTipoVehiculo() + "</td>";
        lista += "<td>" + vehiculo.getModeloVehiculo() + "</td>";
        lista += "<td>" + vehiculo.getLinea() + "</td>";
        lista += "<td>" + vehiculo.getAno() + "</td>";
        lista += "<td>" + vehiculo.getColor() + "</td>";
        lista += "<td>" + vehiculo.getCilindraje() + "</td>";
        lista += "<td>" + vehiculo.getNumLicenciaTransito() + "</td>";
        lista += "<td>" + vehiculo.getFechaExpLicenciaTransito() + "</td>";
        lista += "<td>";
        lista += "<a href='vehiculoFormulario.jsp?accion=Modificar&numeroPlaca=" + vehiculo.getNumeroPlaca() + "' title='Modificar'><img src='presentacion/iconos/modificar.png'></a> ";
        lista += "<img src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(\"" + vehiculo.getNumeroPlaca() + "\")'> ";
        lista += "</td>";
        lista += "</tr>";
    }
%>

<h3>LISTA DE VEHÍCULOS</h3>
<table border="1">
    <tr>
        <th>Número de Placa</th>
        <th>Tipo de vehículo</th>
        <th>Modelo del Vehículo</th>
        <th>Linea</th>
        <th>Año</th>
        <th>Color</th>
        <th>Cilindraje</th>
        <th>Numero de la licencia de tránsito</th>
        <th>Fecha de expedición de la licencia</th>
        <th>Acciones</th>
    </tr>
    <%= lista %>
</table>

<div class="add-button">
    <a href="vehiculoFormulario.jsp?accion=Adicionar" title="Agregar">
        <img src='presentacion/iconos/agregar.png' alt="Agregar" style="width: 20px; vertical-align: middle;"> Agregar Vehículo
    </a>
</div>

<script type="text/javascript">
    function eliminar(numeroPlaca) {
        let respuesta = confirm("¿Realmente desea eliminar el Vehículo?");
        if (respuesta) {
            document.location = "vehiculosActualizar.jsp?accion=Eliminar&numeroPlaca=" + numeroPlaca;
        }
    }
</script>

<p>
    <input type="button" value="Cancelar" onClick="window.history.back()">
</p>