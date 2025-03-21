<%-- 
    Document   : aprendizFormulario
    Created on : 21/03/2025, 02:08:50 PM
    Author     : VALEN
--%>
<%@page import="clases.Hijo"%>
<%@page import="clases.Vehiculo"%>
<%@page import="clases.Cargo"%>
<%@page import="clases.GeneroPersona"%>
<%@page import="clases.Persona"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="presentacion/estiloTablas.css">

<%
    String accion = request.getParameter("accion");
    String identificacion = request.getParameter("identificacion");
    Persona persona = new Persona();

    if ("Modificar".equals(accion)) {
        persona = new Persona(identificacion);

    }
    String opcionesCargos = Cargo.getListaEnOptions(persona.getIdentificacion());

    // Vehiculo vehiculo = (Vehiculo) request.getAttribute("vehiculo");
    String numeroPlaca = persona.obtenerNumeroPlacaVehiculo();
    Vehiculo vehiculo = Vehiculo.obtenerPorPlaca(numeroPlaca);

%>


<h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> TEMPORALES </h3>

<form name="formulario" method="post" action="temporalesActualizar.jsp">
    <table border="0">

        <tr>
            <th>Identificación</th>
            <td><input type="text" name="identificacion" value="<%= persona.getIdentificacion()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo Documento</th>
            <td><input type="text" name="tipoDocumento" value="<%= persona.getTipoDocumento()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Fecha de Expedición</th>
            <td><input type="date" name="fechaExpedicion" value="<%= persona.getFechaExpedicion()%>"></td>
        </tr>
        <tr>
            <th>Lugar de Expedición</th>
            <td><input type="text" name="lugarExpedicion" value="<%= persona.getLugarExpedicion()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Nombres</th>
            <td><input type="text" name="nombres" value="<%= persona.getNombres()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Apellidos</th>
            <td><input type="text" name="apellidos" value="<%= persona.getApellidos()%>" size="50" maxlength="50"></td>
        </tr>

        <tr>
            <th>Sexo</th>
            <th><%=persona.getGeneroPersona().getRadioButtons()%></th>   
        </tr>
        <tr>
            <th>Fecha de Nacimiento</th>
            <td><input type="date" name="fechaNacimiento" value="<%= persona.getFechaNacimiento()%>"></td>
        </tr>
        <tr>
            <th>Lugar de Nacimiento</th>
            <td><input type="text" name="lugarNacimiento" value="<%= persona.getLugarNacimiento()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo de Sangre</th>
            <td><input type="text" name="tipoSangre" value="<%= persona.getTipoSangre()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo de Vivienda</th>
            <td><input type="text" name="tipoVivienda" value="<%= persona.getTipoVivienda()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Dirección</th>
            <td><input type="text" name="direccion" value="<%= persona.getDireccion()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Barrio</th>
            <td><input type="text" name="barrio" value="<%= persona.getBarrio()%>" size="50" maxlength="50"></td>
        </tr>
          <tr>
            <th>Celular</th>
            <td><input type="text" name="celular" value="<%= persona.getCelular()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Email</th>
            <td><input type="email" name="email" value="<%= persona.getEmail()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Nivel Educativo</th>
            <td><input type="text" name="nivelEducativo" value="<%= persona.getNivelEducativo()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>EPS</th>
            <td><input type="text" name="eps" value="<%= persona.getEps()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Estado Civil</th>
            <td><input type="text" name="estadoCivil" value="<%= persona.getEstadoCivil()%>" size="50" maxlength="50"></td>
        </tr>
    </table>

   
    <h4>Información de Trabajo</h4>
    <table border="0">
        <tr>
            <th>Fecha de ingreso </th>
            <td><input type="date" name="fechaIngresoEtapaLectiva" value="<%= persona.getFechaIngreso()%>" size="50" maxlength="50"></td>
        </tr>
   
         <tr>
            <th>Fecha retiro</th>
            <td><input type="date" name="fechaRetiro" value="<%= persona.getFechaRetiro()%>" size="50" maxlength="50"></td>
        </tr>
        
        <tr>
            <th>Unidad de negocio</th>
            <td><input type="text" name="unidadDeNegocio" value="<%= persona.getUnidadNegocio()%>" size="50" maxlength="50"></td>
        </tr>
        
             <th>Cargo</th>
        <td>
            <select name="idCargo" required>
                <%= opcionesCargos%>
            </select>
        </td>
         <tr>
            <th>Centro de costos</th>
            <td><input type="text" name="centroDeCostos" value="<%= persona.getCentroCostos()%>" size="50" maxlength="50"></td>
        </tr>
         <tr>
            <th>Establecimiento</th>
            <td><input type="text" name="establecimiento" value="<%= persona.getEstablecimiento()%>" size="50" maxlength="50"></td>
        </tr>
        
        <tr>
            <th>Área</th>
            <td><input type="text" name="area" value="<%= persona.getArea()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Salario</th>
            <td><input type="text" name="salario" value="<%= persona.getSalario()%>" size="50" maxlength="50"></td>
        </tr>
           <tr>
            <th>Tipo de cargo</th>
            <td><input type="text" name="tipoCargo" value="<%= persona.getTipoCargo()%>" size="50" maxlength="50"></td>
        </tr>
    </table>

        
        
    <h4>Familiares</h4>
    <table border="0">
        <tr>
            <th>Primer Referencia Nombre</th>
            <td><input type="text" name="primerRefNombre" value="<%= persona.getPrimerRefNombre()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Primer Referencia Parentesco</th>
            <td><input type="text" name="primerRefParentezco" value="<%= persona.getPrimerRefParentezco()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Primer Referencia Celular</th>
            <td><input type="text" name="primerRefCelular" value="<%= persona.getPrimerRefCelular()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Segunda Referencia Nombre</th>
            <td><input type="text" name="segundaRefNombre" value="<%= persona.getSegundaRefNombre()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Segunda Referencia Parentesco</th>
            <td><input type="text" name="segundaRefParentezco" value="<%= persona.getSegundaRefParentezco()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Segunda Referencia Celular</th>
            <td><input type="text" name="segundaRefCelular" value="<%= persona.getSegundaRefCelular()%>" size="50" maxlength="50"></td>
        </tr>
    </table>

<table border="0">
    <th>Tiene Hijos?</th>
    <td> 
        <%
            // Obtenemos el valor de tieneHijos de la persona (evitamos null)
            String valorTieneHijos = (persona.getTieneHijos() != null && persona.getTieneHijos().equals("S")) ? "S" : "N";
        %>

        <!-- Radio Button para "No" -->
        <input type="radio" name="tieneHijos" value="N" <%= valorTieneHijos.equals("N") ? "checked" : ""%> onclick="mostrarFamiliares()"> No

        <!-- Radio Button para "Sí" -->
        <input type="radio" name="tieneHijos" value="S" <%= valorTieneHijos.equals("S") ? "checked" : ""%> onclick="mostrarFamiliares()"> Sí
    </td>
</table>

<!-- Sección de familiares (fuera de la tabla) -->
<div id="familiaresSection" style="display: <%= valorTieneHijos.equals("S") ? "block" : "none"%>;">
    <h4>Información de Hijos</h4>

    <table border="0" id="tablaHijos">
        <%
            if (persona.obtenerHijos() != null && !persona.obtenerHijos().isEmpty()) {
        %>
        <tr>
            <th>Nombre del Hijo</th>
            <th>Fecha de Nacimiento</th>
            <th>Acción</th>
        </tr>
        <%
            for (Hijo hijo : persona.obtenerHijos()) {
        %>
        <tr>
            <td><input type="text" name="nombreHijo[]" value="<%= hijo.getNombres()%>" size="50" maxlength="50"></td>
            <td><input type="date" name="fechaNacimientoHijo[]" value="<%= hijo.getFechaNacimiento()%>"></td>
            <td><button type="button" onclick="eliminarFila(this)">Eliminar</button></td>
        </tr>
        <% } %>
        <% }%>
        <tr>
            <td colspan="3"><button type="button" onclick="agregarHijo()">Agregar Hijo</button></td>
        </tr>
    </table>
</div>


<table border="0">
    <tr>
        <th>Tiene Vehículo?</th>
        <td>
            <input type="radio" name="tieneVehiculo" id="vehiculoSi" value="S"
                <%= "S".equals(persona.getTieneVehiculo()) ? "checked" : "" %>
                onclick="mostrarVehiculo()">
            <label for="vehiculoSi">Sí</label>

            <input type="radio" name="tieneVehiculo" id="vehiculoNo" value="N"
                <%= !"S".equals(persona.getTieneVehiculo()) ? "checked" : "" %>
                onclick="mostrarVehiculo()">
            <label for="vehiculoNo">No</label>
        </td>
    </tr>
</table>

<!-- Formulario de vehículo (Oculto por defecto) -->
<div id="vehiculoSection" style="display: none;">
    <h4>Información de Vehículo</h4>
    <table border="0">
        <tr>
            <td><label>Número de Placa:</label></td>
            <td><input type="text" name="numeroPlaca" value="<%= (vehiculo != null) ? vehiculo.getNumeroPlaca() : ""%>"></td>
        </tr>
        <tr>
            <td><label>Tipo de Vehículo:</label></td>
            <td><input type="text" name="tipoVehiculo" value="<%= (vehiculo != null) ? vehiculo.getTipoVehiculo() : ""%>"></td>
        </tr>
        <tr>
            <td><label>Modelo:</label></td>
            <td><input type="text" name="modeloVehiculo" value="<%= (vehiculo != null) ? vehiculo.getModeloVehiculo() : ""%>"></td>
        </tr>
        <tr>
            <td><label>Línea:</label></td>
            <td><input type="text" name="linea" value="<%= (vehiculo != null) ? vehiculo.getLinea() : ""%>"></td>
        </tr>
        <tr>
            <td><label>Año:</label></td>
            <td><input type="text" name="ano" value="<%= (vehiculo != null) ? vehiculo.getAno() : ""%>"></td>
        </tr>
        <tr>
            <td><label>Color:</label></td>
            <td><input type="text" name="color" value="<%= (vehiculo != null) ? vehiculo.getColor() : ""%>"></td>
        </tr>
        <tr>
            <td><label>Cilindraje:</label></td>
            <td><input type="text" name="cilindraje" value="<%= (vehiculo != null) ? vehiculo.getCilindraje() : ""%>"></td>
        </tr>
        <tr>
            <td><label>Número Licencia de Tránsito:</label></td>
            <td><input type="text" name="numLicenciaTransito" value="<%= (vehiculo != null) ? vehiculo.getNumLicenciaTransito() : ""%>"></td>
        </tr>
        <tr>
            <td><label>Fecha Exp. Licencia:</label></td>
            <td><input type="text" name="fechaExpLicenciaTransito" value="<%= (vehiculo != null) ? vehiculo.getFechaExpLicenciaTransito() : ""%>"></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="Guardar"></td>
        </tr>
    </table>
</div>

        <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>"><p>
            <input type="submit" name="accion" value="<%=accion%>">
            <input type="button" value="Cancelar" onClick="window.history.back()">
            </form>

            <script>
function mostrarFamiliares() {
    // Obtener los valores de los radio buttons
    var tieneHijos = document.querySelector('input[name="tieneHijos"]:checked').value;
    
    // Mostrar u ocultar la sección de familiares
    document.getElementById("familiaresSection").style.display = (tieneHijos === "S") ? "block" : "none";
}


                function agregarHijo() {
                    var tabla = document.getElementById("tablaHijos");
                    var fila = document.createElement("tr");

                    // Campo para el nombre del hijo
                    var tdNombre = document.createElement("td");
                    var inputNombre = document.createElement("input");
                    inputNombre.type = "text";
                    inputNombre.name = "nombreHijo[]";
                    inputNombre.size = "50";
                    inputNombre.maxLength = "50";
                    tdNombre.appendChild(inputNombre);

                    // Campo para la fecha de nacimiento del hijo
                    var tdFecha = document.createElement("td");
                    var inputFecha = document.createElement("input");
                    inputFecha.type = "date";
                    inputFecha.name = "fechaNacimientoHijo[]";
                    tdFecha.appendChild(inputFecha);

                    // Botón para eliminar la fila
                    var tdAccion = document.createElement("td");
                    var btnEliminar = document.createElement("button");
                    btnEliminar.type = "button";
                    btnEliminar.innerText = "Eliminar";
                    btnEliminar.onclick = function () {
                        tabla.removeChild(fila);
                    };
                    tdAccion.appendChild(btnEliminar);

                    // Agregar las celdas a la fila
                    fila.appendChild(tdNombre);
                    fila.appendChild(tdFecha);
                    fila.appendChild(tdAccion);

                    // Agregar la fila a la tabla
                    tabla.appendChild(fila);
                }
                function mostrarVehiculo() {
    var tieneVehiculo = document.querySelector('input[name="tieneVehiculo"]:checked').value;
    var vehiculoSection = document.getElementById("vehiculoSection");

    if (tieneVehiculo === "S") {  
        vehiculoSection.style.display = "block";
    } else {
        vehiculoSection.style.display = "none";
    }
}

// Ejecutar la función al cargar la página para mostrar u ocultar la sección correctamente
window.onload = function() {
    mostrarVehiculo();
};
</script>

