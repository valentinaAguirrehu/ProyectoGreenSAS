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


<h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADORES</h3>

<form name="formulario" method="post" action="personaActualizar.jsp">
    <table border="0">

        <tr>
            <th>Identificación</th>
            <td><input type="text" name="identificacion" value="<%= persona.getIdentificacion()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo</th>
            <td><input type="text" name="tipo" value="<%= persona.getTipo()%>" size="50" maxlength="50"></td>
        </tr>
        <th>Cargos</th>
        <td>
            <select name="idCargo" required>
                <%= opcionesCargos%>
            </select>
        </td>
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

    <!-- Tabla de Referencias Personales -->
    <h4>Referencias Personales</h4>
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

    <!-- Tabla de Información de Trabajo -->
    <h4>Información de Trabajo</h4>
    <table border="0">
        <tr>
            <th>Unidad de Negocio</th>
            <td><input type="text" name="unidadNegocio" value="<%= persona.getUnidadNegocio()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Centro de Costos</th>
            <td><input type="text" name="centroCostos" value="<%= persona.getCentroCostos()%>" size="50" maxlength="50"></td>
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
            <th>Tipo de Cargo</th>
            <td><input type="text" name="tipoCargo" value="<%= persona.getTipoCargo()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Cuenta Bancaria</th>
            <td><input type="text" name="cuentaBancaria" value="<%= persona.getCuentaBancaria()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Número de Cuenta</th>
            <td><input type="text" name="numeroCuenta" value="<%= persona.getNumeroCuenta()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Salario</th>
            <td><input type="text" name="salario" value="<%= persona.getSalario()%>" size="50" maxlength="50"></td>
        </tr>
    </table>

    <h4>Familiares</h4>
    <table border="0">
        <tr>
            <th>Tiene Hijos</th>
            <td>
                <select name="tieneHijos" id="tieneHijos" onchange="mostrarFamiliares()">
                    <option value="No" <%= persona.getTieneHijos().equals("No") ? "selected" : ""%>>No</option>
                    <option value="Sí" <%= persona.getTieneHijos().equals("Sí") ? "selected" : ""%>>Sí</option>
                </select>
            </td>
        </tr>
    </table>

    <!-- Sección de familiares (inicialmente oculta) -->
    <div id="familiaresSection" style="display: none;">
        <h4>Información de Hijos</h4>
        <table border="0" id="tablaHijos">
            <tr>
                <th>Nombre del Hijo</th>
                <th>Fecha de Nacimiento</th>
                <th>Acción</th>
            </tr>
        </table>

        <button type="button" onclick="agregarHijo()">Agregar Hijo</button>
    </div>


    <!-- Formulario para Dotaciones -->
    <h4>Dotaciones</h4>
    <table border="0">
        <tr>
            <th>Talla Camisa</th>
            <td><input type="text" name="tallaCamisa" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Talla Chaqueta</th>
            <td><input type="text" name="tallaChaqueta" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Talla Pantalón</th>
            <td><input type="text" name="tallaPantalon" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Talla Calzado</th>
            <td><input type="text" name="tallaCalzado" size="50" maxlength="50"></td>
        </tr>
        <input type="hidden" name="identificacion" value="<%= persona.getIdentificacion()%>">
    </table>

    <table border="0">
        <tr>
            <th>Tiene Vehiculo</th>
            <td>
                <select name="numeroPlacaVehiculo" id="numeroPlacaVehiculo" onchange="mostrarVehiculo()">
                    <option value="No" <%= persona.getNumeroPlacaVehiculo().equals("No") ? "selected" : ""%>>No</option>
                    <option value="Sí" <%= persona.getNumeroPlacaVehiculo().equals("Sí") ? "selected" : ""%>>Sí</option>
                </select>
            </td>
        </tr>
    </table>  <!-- Formulario de vehículo (Oculto por defecto) -->
    <div id="vehiculoSection" style="display: none;">
        <h4>Información de Vehiculo</h4>
        <table border="0" id="tablaHijos"> 

            <label>Número de Placa:</label>
            <input type="text" name="numeroPlaca" value="<%= (vehiculo != null) ? vehiculo.getNumeroPlaca() : ""%>">

            <label>Tipo de Vehículo:</label>
            <input type="text" name="tipoVehiculo" value="<%= (vehiculo != null) ? vehiculo.getTipoVehiculo() : ""%>">

            <label>Modelo:</label>
            <input type="text" name="modeloVehiculo" value="<%= (vehiculo != null) ? vehiculo.getModeloVehiculo() : ""%>">

            <label>Línea:</label>
            <input type="text" name="linea" value="<%= (vehiculo != null) ? vehiculo.getLinea() : ""%>">

            <label>Año:</label>
            <input type="text" name="ano" value="<%= (vehiculo != null) ? vehiculo.getAno() : ""%>">

            <label>Color:</label>
            <input type="text" name="color" value="<%= (vehiculo != null) ? vehiculo.getColor() : ""%>">

            <label>Cilindraje:</label>
            <input type="text" name="cilindraje" value="<%= (vehiculo != null) ? vehiculo.getCilindraje() : ""%>">

            <label>Número Licencia de Tránsito:</label>
            <input type="text" name="numLicenciaTransito" value="<%= (vehiculo != null) ? vehiculo.getNumLicenciaTransito() : ""%>">

            <label>Fecha Exp. Licencia:</label>
            <input type="text" name="fechaExpLicenciaTransito" value="<%= (vehiculo != null) ? vehiculo.getFechaExpLicenciaTransito() : ""%>">

            <input type="submit" value="Guardar">

        </table>
    </div>

    <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>"><p>
        <input type="submit" name="accion" value="<%=accion%>">
        <input type="button" value="Cancelar" onClick="window.history.back()">
</form>

<script>
    function mostrarFamiliares() {
        var tieneHijos = document.getElementById("tieneHijos").value;
        var familiaresSection = document.getElementById("familiaresSection");
        if (tieneHijos === "Sí") {
            familiaresSection.style.display = "block";
        } else {
            familiaresSection.style.display = "none";
        }
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
        var numeroPlacaVehiculo = document.getElementById("numeroPlacaVehiculo").value;
        var vehiculoSection = document.getElementById("vehiculoSection");
        if (numeroPlacaVehiculo === "Sí") {
            vehiculoSection.style.display = "block";
        } else {
            vehiculoSection.style.display = "none";
        }
    }
    // Ejecutar la función al cargar la página para reflejar el valor actual
    window.onload = mostrarFamiliares;
    window.onload = mostrarVehiculo;
</script>
