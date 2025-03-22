<%@page import="java.util.List"%>
<%@page import="clases.Hijo"%>
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


%>


<h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADORES</h3>

<form name="formulario" method="post" action="personaActualizar.jsp">
    <table border="0">

        <tr>
            <th>Identificación</th>
            <td><input type="text" name="identificacion" value="<%= persona.getIdentificacion()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Fecha de Ingreso</th>
            <td><input type="date" name="fechaIngreso" value="<%= persona.getFechaIngreso()%>"></td>
        </tr><tr>
            <th>Fecha de Retiro</th>
            <td><input type="date" name="fechaRetiro" value="<%= persona.getFechaRetiro()%>"></td>
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

        <!-- Formulario para referencia familiares -->


        <div id="familiaresSection" style="display: <%= persona.getTieneHijos().equals("S") ? "block" : "none"%>;">
            <h4>Información de Hijos</h4>
            <table border="0" id="tablaHijos">
                <tr>
                    <th>Identificación</th>
                    <th>Nombre del Hijo</th>
                    <th>Fecha de Nacimiento</th>
                    <th>Acción</th>
                </tr>
                <%
                    if (persona.obtenerHijos() != null && !persona.obtenerHijos().isEmpty()) {
                        for (Hijo hijo : persona.obtenerHijos()) {
                %>
                <tr>
                    <td><input type="text" name="identificacionHijo[]" value="<%= hijo.getIdentificacion()%>" size="10" maxlength="10"></td></tr>
        <tr>
                    <td><input type="text" name="nombreHijo[]" value="<%= hijo.getNombres()%>" size="50" maxlength="50"></td></tr>
        <tr>
                    <td><input type="date" name="fechaNacimientoHijo[]" value="<%= hijo.getFechaNacimiento()%>"></td><br>
                    <td><button type="button" onclick="eliminarFila(this)">Eliminar</button></td>
                </tr>
                <%
                        }
                    }
                %>
                <tr>
                    <td colspan="4"><button type="button" onclick="agregarHijo()">Agregar Hijo</button></td>
                </tr>
            </table>
        </div>


        <!-- Formulario para Dotaciones -->
        <h4>Dotaciones</h4>
        <table border="0">
            <tr>
                <th>Talla Camisa</th>
                <td><input type="text" name="tallaCamisa" value="<%= persona.getTallaCamisa()%>" size="50" maxlength="50"></td>
            </tr>
            <tr>
                <th>Talla Chaqueta</th>
                <td><input type="text" name="tallaChaqueta" value="<%= persona.getTallaChaqueta()%>"size="50" maxlength="50"></td>
            </tr>
            <tr>
                <th>Talla Pantalón</th>
                <td><input type="text" name="tallaPantalon" value="<%= persona.getTallaPantalon()%>"size="50" maxlength="50"></td>
            </tr>

            <tr>
                <th>Talla Calzado</th>
                <td><input type="text" name="tallaCalzado" value="<%= persona.getTallaCalzado()%>"size="50" maxlength="50"></td>
            </tr>
            <td><label>Número de Placa:</label></td>
            <td><input type="text" name="numeroPlacaVehiculo" value="<%= persona.getNumeroPlacaVehiculo()%>"size="50" maxlength="50"></td>
            </tr>
            <tr>
                <td><label>Tipo de Vehículo:</label></td>
                <td><input type="text" name="tipoVehiculo" value="<%= persona.getTipoVehiculo()%>"size="50" maxlength="50"></td>
            </tr>
            <tr>
                <td><label>Modelo:</label></td>
                <td><input type="text" name="modeloVehiculo" value="<%= persona.getModeloVehiculo()%>"size="50" maxlength="50"></td>
            </tr>
            <tr>
                <td><label>Línea:</label></td>
                <td><input type="text" name="linea" value="<%= persona.getLinea()%>"size="50" maxlength="50"></td>
            </tr>
            <tr>
                <td><label>Año:</label></td>
                <td><input type="text" name="ano" value="<%= persona.getAno()%>"size="50" maxlength="50"></td>
            </tr>
            <tr>
                <td><label>Color:</label></td>
                <td><input type="text" name="color" value="<%= persona.getColor()%>"size="50" maxlength="50"></td>
            </tr>
            <tr>
                <td><label>Cilindraje:</label></td>
                <td><input type="text" name="cilindraje" value="<%= persona.getCilindraje()%>"size="50" maxlength="50"></td>
            </tr>
            <tr>
                <td><label>Restricciones:</label></td>
                <td><input type="text" name="restricciones" value="<%= persona.getRestricciones()%>"></td>
            </tr>
            <tr>
                <td><label>Número Licencia de Tránsito:</label></td>
                <td><input type="text" name="numLicenciaTransito" value="<%= persona.getNumLicenciaTransito()%>" size="50" maxlength="50" required>
                </td>
            </tr>

            <tr>
                <td><label>Fecha Exp. Licencia de Tránsito:</label></td>
                <td><input type="date" name="fechaExpLicenciaTransito" value="<%= persona.getFechaExpLicenciaTransito()%>"></td>
            </tr>

            <tr>
                <td><label>Estado:</label></td>
                <td><input type="text" name="estado" value="<%= persona.getEstado()%>"></td>
            </tr>

            <tr>
                <td><label>Fecha Exp. Licencia de Conducción:</label></td>
                <td><input type="date" name="fechaExpConduccion" value="<%= persona.getFechaExpConduccion()%>"></td>
            </tr>

            <tr>
                <td><label>Fecha de Vencimiento:</label></td>
                <td><input type="date" name="fechaVencimiento" value="<%= persona.getFechaVencimiento()%>"></td>
            </tr>
            <tr>
                <td><label>Número Licencia de Conducción:</label></td>
                <td>
                    <input type="text" name="numLicenciaConduccion" 
                           value="<%= persona.getNumLicenciaConduccion() != null ? persona.getNumLicenciaConduccion() : ""%>" 
                           size="50" maxlength="50">
                </td>
            </tr>


        </table>
        </div>

        <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>"><p>
            <input type="submit" name="accion" value="<%=accion%>">
            <input type="button" value="Cancelar" onClick="window.history.back()">
            </form>

<script>
    // Función para mostrar/ocultar la sección de hijos
    function mostrarHijos() {
        var tieneHijos = document.querySelector('input[name="tieneHijos"]:checked').value;
        document.getElementById("familiaresSection").style.display = (tieneHijos === "S") ? "block" : "none";
    }

    // Asignar evento a los radio buttons de "Tiene Hijos"
    document.querySelectorAll('input[name="tieneHijos"]').forEach(function (radio) {
        radio.addEventListener("change", mostrarHijos);
    });

    // Función para agregar un nuevo hijo a la tabla
    function agregarHijo() {
        var tabla = document.getElementById("tablaHijos");
        var fila = tabla.insertRow(tabla.rows.length - 1);
        fila.innerHTML = `
            <td><input type="text" name="identificacionHijo[]" size="10" maxlength="10" required></td>
            <td><input type="text" name="nombreHijo[]" size="50" maxlength="50" required></td>
            <td><input type="date" name="fechaNacimientoHijo[]" required></td>
            <td><button type="button" onclick="eliminarFila(this)">Eliminar</button></td>
        `;
    }

    // Función para eliminar una fila de la tabla de hijos
    function eliminarFila(boton) {
        var fila = boton.parentNode.parentNode;
        fila.parentNode.removeChild(fila);
    }
</script>

