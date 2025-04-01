<%-- 
    Document   : personaFormulario
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>

<%@page import="clases.Departamento"%>
<%@page import="clases.Municipio"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="clases.Hijo"%>
<%@page import="clases.Cargo"%>
<%@page import="clases.GeneroPersona"%>
<%@page import="clases.Persona"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="presentacion/style-PersonaFormulario.css">

<%

    String accion = request.getParameter("accion");
    String identificacion = request.getParameter("identificacion");
    Persona persona = new Persona();

    if ("Modificar".equals(accion)) {
        persona = new Persona(identificacion);

    }
    String opcionesCargos = Cargo.getListaEnOptions(persona.getIdentificacion());

// Obtener los parámetros del formulario y evitar valores nulos
    String idDepartamento = request.getParameter("departamento") != null ? request.getParameter("departamento") : "";
    String idMunicipio = request.getParameter("lugarExpedicion") != null ? request.getParameter("lugarExpedicion") : "";

// Concatenar los valores de forma segura
    String lugarExpedicion = idDepartamento + "-" + idMunicipio;


%>

<%@ include file="menu.jsp" %>

<head>
    <link rel="stylesheet" href="presentacion/style-FormularioColaboradores.css">
</head>
<body>
    <div class="content"> 
        <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADOR</h3>
        <form name="formulario" method="post" action="personaActualizar.jsp" onsubmit="obtenerDatosHijos()">
            <h1>Datos personales</h1>
            <table border="1">
                <tr>
                    <th>Nombres</th>
                    <td><input type="text" name="nombres" value="<%= persona.getNombres()%>" size="50" maxlength="50"required></td>
                </tr>
                <tr>
                    <th>Apellidos</th>
                    <td><input type="text" name="apellidos" value="<%= persona.getApellidos()%>" size="50" maxlength="50"required></td>
                </tr>
                <tr>
                    <th colspan="2">Sexo</th>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="radio-container">
                            <%= persona.getGeneroPersona().getRadioButtons()%>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>Fecha de ingreso</th>
                    <td><input type="date" name="fechaIngreso" value="<%= persona.getFechaIngreso()%>"required></td>
                </tr>
                <tr>
                    <th>Fecha de retiro</th>
                    <td>
                        <input type="date" name="fechaRetiro" value="<%= (persona.getFechaRetiro() != null && !persona.getFechaRetiro().isEmpty()) ? persona.getFechaRetiro() : "0000-00-00"%>">
                    </td>     
                </tr>
                <tr>
                    <th>Documento de identidad</th>
                    <td>
                        <select name="tipoDocumentoSelect" id="tipoDocumento" onchange="manejarOtro('tipoDocumento', 'otroTipoDocumento', 'tipoDocumentoHidden')"required>
                            <option value="Cédula de Ciudadanía" <%= (persona.getTipoDocumento() == null || persona.getTipoDocumento().isEmpty() || "CC".equals(persona.getTipoDocumento())) ? "selected" : ""%>>Cédula de Ciudadanía</option>
                            <option value="Tarjeta de Identidad" <%= "TI".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Tarjeta de Identidad</option>
                            <option value="Cédula de Extranjería" <%= "CE".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Cédula de Extranjería</option>
                            <option value="Permiso Temporal" <%= "EXT".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Permiso Temporal</option>
                            <option value="Otro">Otro</option>
                        </select>
                        <!-- Campo de entrada oculto para "Otro" -->
                        <input type="text" id="otroTipoDocumento" name="otroTipoDocumento"
                               style="display: none;" placeholder="Especifique otro"
                               value="">
                        <!-- Campo oculto para almacenar el valor final -->
                        <input type="hidden" id="tipoDocumentoHidden" name="tipoDocumento"
                               value="<%= persona.getTipoDocumento() != null ? persona.getTipoDocumento() : ""%>"required>
                    </td>
                </tr>
                <tr>
                    <th>Número de documento</th>
                    <td><input type="text" name="identificacion" value="<%= persona.getIdentificacion()%>" required></td>
                </tr>
                <tr>
                    <th>Fecha de expedición</th>
                    <td><input type="date" name="fechaExpedicion" value="<%= persona.getFechaExpedicion()%>"required></td>
                </tr>
                <tr>
                    <th colspan="2" >Lugar de expedición</th>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="campos-container">
                            <label for="departamentoExpedicion"><b>Departamento:</b></label>
                            <select name="departamentoExpedicion" id="departamentoExpedicion" onchange="cargarMunicipios(this.value, 'expedicion');" required>
                                <option value="">Seleccione un Departamento</option>
                                <%
                                    List<Departamento> departamentos = Departamento.getListaEnObjetos(null, "nombre ASC");
                                    String idDepartamentoExpedicion = persona.getIdDepartamentoExpedicion();
                                    for (Departamento departamento : departamentos) {
                                        String selected = (idDepartamentoExpedicion != null && idDepartamentoExpedicion.equals(departamento.getId())) ? "selected" : "";
                                %>
                                <option value="<%= departamento.getId()%>" <%= selected%>><%= departamento.getNombre()%></option>
                                <% } %>
                            </select>

                            <label for="municipioExpedicion"><b>Municipio:</b></label>
                            <select name="lugarExpedicion" id="municipioExpedicion" required>
                                <option value="">Seleccione un municipio</option>
                                <%
                                    String idMunicipioExpedicion = persona.getIdMunicipioExpedicion();
                                    if (idDepartamentoExpedicion != null) {
                                        List<Municipio> municipios = Municipio.getListaEnObjetos(idDepartamentoExpedicion, "nombre ASC");
                                        for (Municipio municipio : municipios) {
                                            String selected = (idMunicipioExpedicion != null && idMunicipioExpedicion.equals(municipio.getId())) ? "selected" : "";
                                %>
                                <option value="<%= municipio.getId()%>" <%= selected%>><%= municipio.getNombre()%></option>
                                <% }
                                    }%>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>Fecha de nacimiento</th>
                    <td><input type="date" name="fechaNacimiento" value="<%= persona.getFechaNacimiento()%>"required></td>
                </tr>
                <tr>
                    <th colspan="2">Lugar de nacimiento</th>
                </tr>
                <tr>
                    <td colspan="2">         
                        <div class="campos-container">
                            <label for="departamentoNacimiento"><b>Departamento:</b></label>
                            <select name="departamentoNacimiento" id="departamentoNacimiento" onchange="cargarMunicipios(this.value, 'nacimiento');" required>
                                <option value="">Seleccione un departamento</option>
                                <%
                                    List<Departamento> departamentos2 = Departamento.getListaEnObjetos(null, "nombre ASC");
                                    String idDepartamentoNacimiento = persona.getIdDepartamentoNacimiento();
                                    for (Departamento departamento : departamentos2) {
                                        String selected = (idDepartamentoNacimiento != null && idDepartamentoNacimiento.equals(departamento.getId())) ? "selected" : "";
                                %>
                                <option value="<%= departamento.getId()%>" <%= selected%>><%= departamento.getNombre()%></option>
                                <% } %>
                            </select>
                            <label for="municipioNacimiento"><b>Municipio:</b></label>
                            <select name="lugarNacimiento" id="municipioNacimiento" required>
                                <option value="">Seleccione un municipio</option>
                                <%
                                    String idMunicipioNacimiento = persona.getIdMunicipioNacimiento();
                                    if (idDepartamentoNacimiento != null) {
                                        List<Municipio> municipios = Municipio.getListaEnObjetos(idDepartamentoNacimiento, "nombre ASC");
                                        for (Municipio municipio : municipios) {
                                            String selected = (idMunicipioNacimiento != null && idMunicipioNacimiento.equals(municipio.getId())) ? "selected" : "";
                                %>
                                <option value="<%= municipio.getId()%>" <%= selected%>><%= municipio.getNombre()%></option>
                                <% }
                                    }%>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>Tipo de sangre</th>
                    <td>
                        <select name="tipoSangre" required>
                            <option value="" <%= (persona.getTipoSangre() == null || persona.getTipoSangre().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="O+" <%= "O+".equals(persona.getTipoSangre()) ? "selected" : ""%>>O+</option>
                            <option value="O-" <%= "O-".equals(persona.getTipoSangre()) ? "selected" : ""%>>O-</option>
                            <option value="A+" <%= "A+".equals(persona.getTipoSangre()) ? "selected" : ""%>>A+</option>
                            <option value="A-" <%= "A-".equals(persona.getTipoSangre()) ? "selected" : ""%>>A-</option>
                            <option value="B+" <%= "B+".equals(persona.getTipoSangre()) ? "selected" : ""%>>B+</option>
                            <option value="B-" <%= "B-".equals(persona.getTipoSangre()) ? "selected" : ""%>>B-</option>
                            <option value="AB+" <%= "AB+".equals(persona.getTipoSangre()) ? "selected" : ""%>>AB+</option>
                            <option value="AB-" <%= "AB-".equals(persona.getTipoSangre()) ? "selected" : ""%>>AB-</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Tipo de vivienda</th>
                    <td>
                        <select name="tipoVivienda" required>
                            <option value="" <%= (persona.getTipoVivienda() == null || persona.getTipoVivienda().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="Propia" <%= "Propia".equals(persona.getTipoVivienda()) ? "selected" : ""%>>Propia</option>
                            <option value="Arrendada" <%= "Arrendada".equals(persona.getTipoVivienda()) ? "selected" : ""%>>Arrendada</option>
                            <option value="Familiar" <%= "Familiar".equals(persona.getTipoVivienda()) ? "selected" : ""%>>Familiar</option>
                            <option value="Anticres" <%= "Anticres".equals(persona.getTipoVivienda().trim()) ? "selected" : ""%>>Anticres</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Dirección</th>
                    <td><input type="text" name="direccion" value="<%= persona.getDireccion()%>" size="50" maxlength="50"required></td>
                </tr>
                <tr>
                    <th>Barrio</th>
                    <td><input type="text" name="barrio" value="<%= persona.getBarrio()%>" size="50" maxlength="50"required></td>
                </tr>
                <tr>
                    <th>Celular</th>
                    <td>
                        <input type="text" name="celular" value="<%= persona.getCelular()%>" 
                               size="50" maxlength="10" pattern="\d{10}" 
                               title="Ingrese exactamente 10 números" required>
                    </td>
                </tr>
                <tr>
                    <th>Correo electrónico</th>
                    <td><input type="email" name="email" value="<%= persona.getEmail()%>" size="50" maxlength="50"required></td>
                </tr>
                <tr>
                    <th>Nivel educativo</th>
                    <td colspan="2">
                        <div class="campos-container">
                            <select name="nivelEducativoSelect" id="nivelEducativo" onchange="manejarOtro('nivelEducativo', 'otroNivelEducativo', 'nivelEducativoHidden')" required>
                                <option value="" <%= (persona.getNivelEducativo() == null || persona.getNivelEducativo().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                                <option value="Primaria" <%= "Primaria".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Primaria</option>
                                <option value="Secundaria" <%= "Secundaria".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Secundaria</option>
                                <option value="Técnico" <%= "Técnico".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Técnico</option>
                                <option value="Tecnológico" <%= "Tecnológico".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Tecnológico</option>
                                <option value="Universitario" <%= "Universitario".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Universitario</option>
                                <option value="Postgrado" <%= "Postgrado".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Postgrado</option>
                                <option value="Otro">Otro</option>
                            </select>
                            <input type="text" id="otroNivelEducativo" name="otroNivelEducativo"
                                   style="display: none;" placeholder="Especifique otro"
                                   value="">
                            <input type="hidden" id="nivelEducativoHidden" name="nivelEducativo"
                                   value="<%= persona.getNivelEducativo() != null ? persona.getNivelEducativo() : ""%>"required>      
                            <label for="profesion"><b>en</b></label>
                            <input type="text" name="profesion" value="<%= persona.getProfesion()%>" size="50" maxlength="50" required>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>Estado civil</th>
                    <td>
                        <select name="estadoCivil" required>
                            <option value="" <%= (persona.getEstadoCivil() == null || persona.getEstadoCivil().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="Soltero" <%= "Soltero".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Soltero</option>
                            <option value="Casado" <%= "Casado".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Casado</option>
                            <option value="Divorciado" <%= "Divorciado".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Divorciado</option>
                            <option value="Viudo" <%= "Viudo".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Viudo</option>
                            <option value="Unión Libre" <%= "Unión Libre".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Unión Libre</option>
                        </select>

                    </td>
                </tr>
                <tr>
                    <th colspan="2">¿El colaborador tiene hijos?</th>
                </tr>
                <tr> 
                    <td colspan="2">
                        <div class="radio-container">
                            <label>
                                <input type="radio" name="tieneHijos" value="S" onclick="mostrarHijos()" 
                                       <%= "S".equals(persona.getTieneHijos()) ? "checked" : ""%>> Sí
                            </label>
                            <label>
                                <input type="radio" name="tieneHijos" value="N" onclick="mostrarHijos()" 
                                       <%= "N".equals(persona.getTieneHijos()) ? "checked" : ""%>> No
                            </label>
                        </div>
                    </td>
                </tr>
            </table>
            <div id="familiaresSection" style="display: <%= persona.getTieneHijos().equals("S") ? "block" : "none"%>;">
                <h1>Información de Hijos</h1>
                <table border="0" id="tablaHijos">
                    <tr>
                        <th>Identificación</th>
                        <th>Nombre</th>
                        <th>Fecha de Nacimiento</th>
                        <th>Acción</th>
                    </tr>
                    <%
                        if (persona.obtenerHijos() != null && !persona.obtenerHijos().isEmpty()) {
                            for (Hijo hijo : persona.obtenerHijos()) {
                    %>
                    <tr>
                        <td><input type="text" name="identificacionHijo[]" value="<%= hijo.getIdentificacion()%>" size="10" maxlength="10"></td>
                        <td><input type="text" name="nombreHijo[]" value="<%= hijo.getNombres()%>" size="50" maxlength="50"></td>
                        <td><input type="date" name="fechaNacimientoHijo[]" value="<%= hijo.getFechaNacimiento()%>"></td>
                        <td><button type="button" onclick="eliminarFila(this)">Eliminar</button></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    <tr>
                        <td colspan="4"><button class ="submit" type="submit" onclick="agregarHijo()">Agregar Hijo</button></td>
                    </tr>
                </table>
            </div>
            <table>
                <tr>
                    <th colspan="2">¿El colaborador tiene medio de transporte?</th>
                </tr>
                <tr> 
                    <td colspan="2">
                        <div class="radio-container">
                            <label>
                                <input type="radio" name="tieneVehiculo" value="Sí" id="tieneVehiculoSi"
                                       <%= "Sí".equals(persona.getTieneVehiculo()) ? "checked" : ""%> 
                                       onchange="mostrarOcultarVehiculo()"> Sí
                            </label>
                            <label>    
                                <input type="radio" name="tieneVehiculo" value="No" id="tieneVehiculoNo"
                                       <%= "No".equals(persona.getTieneVehiculo()) ? "checked" : ""%> 
                                       onchange="mostrarOcultarVehiculo()"> No
                            </label>
                        </div>
                    </td>
                </tr>

            </table>
            <!-- Contenedor de la tabla de vehículos -->
            <div id="tablaVehiculo" style="display: none;">
                <h1>Información del vehículo</h1>
                <table border="1">       
                    <tr>
                        <th><label>Número de la placa</label></th>
                        <td><input type="text" name="numeroPlacaVehiculo" value="<%= persona.getNumeroPlacaVehiculo()%>" size="50" maxlength="50"></td>
                    </tr>
                    <tr>
                        <th><label>Seleccione el tipo de transporte</label></th>
                        <td>
                            <select name="tipoVehiculo">
                                <option value="" <%= (persona.getTipoVehiculo() == null || persona.getTipoVehiculo().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                                <option value="Motocicleta" <%= "Motocicleta".equals(persona.getTipoVehiculo()) ? "selected" : ""%>>Motocicleta</option>
                                <option value="Automovil" <%= "Automovil".equals(persona.getTipoVehiculo()) ? "selected" : ""%>>Automóvil</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th><label>Modelo</label></th>
                        <td><input type="text" name="modeloVehiculo" value="<%= persona.getModeloVehiculo()%>" size="50" maxlength="50"></td>
                    </tr>
                    <tr>
                        <th><label>Línea</label></th>
                        <td><input type="text" name="linea" value="<%= persona.getLinea()%>" size="50" maxlength="50"></td>
                    </tr>
                    <tr>
                        <th><label>Marca</label></th>
                        <td><input type="text" name="marca" value="<%= persona.getMarca()%>" size="50" maxlength="50"></td>
                    </tr>
                    <tr>
                        <th><label>Color</label></th>
                        <td><input type="text" name="color" value="<%= persona.getColor()%>" size="50" maxlength="50"></td>
                    </tr>
                    <tr>
                        <th><label>Cilindraje</label></th>
                        <td><input type="text" name="cilindraje" value="<%= persona.getCilindraje()%>" size="50" maxlength="50" placeholder="Campo numérico" ></td>
                    </tr>
                    <tr>
                        <th><label>Restricciones del conductor</label></th>
                        <td><input type="text" name="restricciones" value="<%= persona.getRestricciones()%>"></td>
                    </tr>
                    <tr>
                        <th><label>Número de la tarjeta de propiedad</label></th>
                        <td><input type="text" name="numLicenciaTransito" value="<%= persona.getNumLicenciaTransito()%>" size="50" maxlength="50" placeholder="Campo numérico" ></td>
                    </tr>
                    <tr>
                        <th><label>Fecha de expedición de la tarjeta de propiedad</label></th>
                        <td><input type="date" name="fechaExpLicenciaTransito" value="<%= persona.getFechaExpLicenciaTransito()%>"></td>
                    </tr>
                    <tr>
                        <th><label>Estado</label></th>
                        <td>
                            <select name="estado" required>
                                <option value="" <%= (persona.getEstado() == null || persona.getEstado().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                                <option value="Activo" <%= "Activo".equals(persona.getEstado()) ? "selected" : ""%>>Activo</option>
                                <option value="Inactivo" <%= "Inactivo".equals(persona.getEstado()) ? "selected" : ""%>>Inactivo</option>
                                <option value="Suspendido" <%= "Suspendido".equals(persona.getEstado()) ? "selected" : ""%>>Suspendido</option>
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <th><label>Fecha de expedición de la licencia de conducción</label></th>
                        <td><input type="date" name="fechaExpConduccion" value="<%= persona.getFechaExpConduccion()%>"></td>
                    </tr>
                    <tr>
                        <th><label>Fecha de vencimiento de la licencia de conducción</label></th>
                        <td><input type="date" name="fechaVencimiento" value="<%= persona.getFechaVencimiento()%>"></td>
                    </tr>
                    <tr>
                        <th><label>Número de la licencia de conducción</label></th>
                        <td>
                            <input type="text" name="numLicenciaConduccion" 
                                   value="<%= persona.getNumLicenciaConduccion() != null ? persona.getNumLicenciaConduccion() : ""%>" 
                                   size="50" maxlength="50" placeholder="Campo numérico">
                        </td>
                    </tr>
                </table>
            </div>
            <h1>Contactos personales</h1>
            <table border="1">
                <tr><th colspan="2">Primer contacto</th></tr>
                <tr>
                    <th>Nombre</th>
                    <td><input type="text" name="primerRefNombre" value="<%= persona.getPrimerRefNombre()%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>Parentesco</th>
                    <td><input type="text" name="primerRefParentezco" value="<%= persona.getPrimerRefParentezco()%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>Celular</th>
                    <td><input type="text" name="primerRefCelular" value="<%= persona.getPrimerRefCelular()%>" size="50" maxlength="10" pattern="\d{10}" title="Ingrese exactamente 10 números" required></td>
                </tr>

                <tr><th colspan="2">Segundo contacto</th></tr>
                <tr>
                    <th>Nombre</th>
                    <td><input type="text" name="segundaRefNombre" value="<%= persona.getSegundaRefNombre()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <th>Parentesco</th>
                    <td><input type="text" name="segundaRefParentezco" value="<%= persona.getSegundaRefParentezco()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <th>Celular</th>
                    <td><input type="text" name="segundaRefCelular" value="<%= persona.getSegundaRefCelular()%>" size="50" maxlength="10" pattern="\d{10}" title="Ingrese exactamente 10 números"></td>
                </tr>
            </table>

            <div class="botones-container">
                <button class="submit" type="submit" onclick="agregarReferencia()">Añadir otro contacto</button>
            </div>

            <table border="1">
                <!-- Oculto -->
                <tr class="referencia1" style="display: none;"><th colspan="2">Tercer contacto</th></tr>
                <tr class="referencia1" style="display: none;">
                    <th>Nombre</th>
                    <td><input type="text" name="terceraRefNombre" value="<%= persona.getTerceraRefNombre()%>" size="50" maxlength="50">
                        <button type="button" onclick="eliminarReferencia(1)">Eliminar</button>
                    </td>
                </tr>
                <tr class="referencia1" style="display: none;">
                    <th>Parentesco</th>
                    <td><input type="text" name="terceraRefParentezco" value="<%= persona.getTerceraRefParentezco()%>" size="50" maxlength="50"></td>
                </tr>
                <tr class="referencia1" style="display: none;">
                    <th>Celular</th>
                    <td><input type="text" name="terceraRefCelular" value="<%= persona.getTerceraRefCelular()%>" size="50" maxlength="10" pattern="\d{10}" title="Ingrese exactamente 10 números"></td>
                </tr>

                <!-- oculto -->
                <tr class="referencia2" style="display: none;"><th colspan="2">Cuarto contacto</th></tr>
                <tr class="referencia2" style="display: none;">
                    <th>Nombre</th>
                    <td><input type="text" name="cuartaRefNombre" value="<%= persona.getCuartaRefNombre()%>" size="50" maxlength="50">
                        <button type="button" onclick="eliminarReferencia(2)">Eliminar</button>
                    </td>
                </tr>
                <tr class="referencia2" style="display: none;">
                    <th>Parentesco</th>
                    <td><input type="text" name="cuartaRefParentezco" value="<%= persona.getCuartaRefParentezco()%>" size="50" maxlength="50"></td>
                </tr>
                <tr class="referencia2" style="display: none;">
                    <th>Celular</th>
                    <td><input type="text" name="cuartaRefCelular" value="<%= persona.getCuartaRefCelular()%>" size="50" maxlength="10" pattern="\d{10}" title="Ingrese exactamente 10 números"></td>
                </tr>
            </table>

            <h1>Información laboral</h1> <!-- Tabla de Información de Trabajo -->
            <table border="1">
                <tr>
                    <th>Fecha de termino del primer contrato</th>
                    <td><input type="date" name="fechaTerPriContrato" value="<%= persona.getFechaTerPriContrato()%>"></td>
                </tr>
                <tr>
                    <th>Establecimiento</th>
                    <td>
                        <select name="establecimiento" id="establecimiento" onchange="precargarUnidadNegocio()" required>
                            <option value="">Seleccione...</option>
                            <%
                                String[] establecimientos = {
                                    "Avenida", "Principal", "Centro", "Unicentro",
                                    "Centro de Procesos", "Teleoperaciones", "Juanambu",
                                    "Terminal Americano", "Puente", "Canobajo", "Greenfield"
                                };
                                for (String est : establecimientos) {
                            %>
                            <option value="<%= est%>" <%= est.equals(persona.getEstablecimiento()) ? "selected" : ""%>><%= est%></option>
                            <% }%>
                        </select>
                    </td>
                </tr>

                <!-- Unidad de negocio -->
                <tr>
                    <th>Unidad de negocio</th>
                    <td>
                        <input type="text" name="unidadNegocio" id="unidadNegocio" value="<%= persona.getUnidadNegocio() != null ? persona.getUnidadNegocio().trim() : ""%>" readonly>
                    </td>
                </tr>
                <tr>
                    <th>Centro de costos</th>
                    <td>
                        <select name="centroCostos" required>
                            <option value="" <%= (persona.getCentroCostos() == null || persona.getCentroCostos().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="23" <%= "23".equals(persona.getCentroCostos()) ? "selected" : ""%>>23</option>
                            <option value="33" <%= "33".equals(persona.getCentroCostos()) ? "selected" : ""%>>33</option>
                            <option value="43" <%= "43".equals(persona.getCentroCostos()) ? "selected" : ""%>>43</option>
                            <option value="53" <%= "53".equals(persona.getCentroCostos()) ? "selected" : ""%>>53</option>
                            <option value="63" <%= "63".equals(persona.getCentroCostos()) ? "selected" : ""%>>63</option>
                            <option value="214" <%= "214".equals(persona.getCentroCostos()) ? "selected" : ""%>>214</option>
                            <option value="224" <%= "224".equals(persona.getCentroCostos()) ? "selected" : ""%>>224</option>
                            <option value="243" <%= "243".equals(persona.getCentroCostos()) ? "selected" : ""%>>243</option>
                            <option value="244" <%= "244".equals(persona.getCentroCostos()) ? "selected" : ""%>>244</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Area</th>
                    <td>
                        <select name="area" id="area" onchange="manejarOtro('area', 'otraArea', 'areaFinal')" required>
                            <option value="" <%= (persona.getArea() == null || persona.getArea().trim().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="Linea Media" <%= "Linea Media".equalsIgnoreCase(persona.getArea()) ? "selected" : ""%>>Linea Media</option>
                            <option value="Linea Directiva" <%= "Linea Directiva".equalsIgnoreCase(persona.getArea()) ? "selected" : ""%>>Linea Directiva</option>
                            <option value="Administrativo" <%= "Administrativo".equalsIgnoreCase(persona.getArea()) ? "selected" : ""%>>Administrativo</option>
                            <option value="Operativo" <%= "Operativo".equalsIgnoreCase(persona.getArea()) ? "selected" : ""%>>Operativo</option>
                            <option value="Otro" <%= (persona.getArea() != null && !Persona.esAreaPredefinida(persona.getArea())) ? "selected" : ""%>>Otro</option>
                        </select>
                        <input type="text" id="otraArea" name="otraArea" style="display: none;" placeholder="Especifique otro"
                               value="<%= (persona.getArea() != null && !Persona.esAreaPredefinida(persona.getArea().trim())) ? persona.getArea().trim() : ""%>">
                        <input type="hidden" name="areaFinal" id="areaFinal" value="<%= persona.getArea() != null ? persona.getArea().trim() : ""%>">
                    </td>
                </tr>
                <tr>
                <tr>
                    <th>Cargos</th>
                    <td>
                        <input type="text" name="idCargo" id="idCargo" list="cargosList" required />
                        <datalist id="cargosList">
                            <%= opcionesCargos%> <!-- Aquí se insertan las opciones dinámicamente -->
                        </datalist>
                    </td>
                </tr>
                <tr>
                    <th>Centro costos por nomina</th>
                    <td>
                        <input type="text" name="cctn" id="cctn" value="<%= persona.getCctn()%>" size="50" maxlength="50" autocomplete="off" onkeyup="filtrarCargos()"required>
                        <div id="sugerenciasCargo"></div>
                    </td>
                </tr>
                <tr>
                    <th>EPS</th>
                    <td>
                        <select name="eps" id="eps" onchange="manejarOtro('eps', 'otroEps', 'epsFinal')" required>
                            <option value="" <%= (persona.getEps() == null || persona.getEps().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="Emssanar" <%= "Emssanar".equals(persona.getEps()) ? "selected" : ""%>>Emssanar</option>
                            <option value="Sanitas" <%= "Sanitas".equals(persona.getEps()) ? "selected" : ""%>>Sanitas</option>
                            <option value="Nueva EPS" <%= "Nueva EPS".equals(persona.getEps()) ? "selected" : ""%>>Nueva EPS</option>
                            <option value="Compensar" <%= "Compensar".equals(persona.getEps()) ? "selected" : ""%>>Compensar</option>
                            <option value="Salud total" <%= "Salud total".equals(persona.getEps()) ? "selected" : ""%>>Salud total</option>
                            <option value="Mallamas" <%= "Mallamas".equals(persona.getEps()) ? "selected" : ""%>>Mallamas</option>
                            <option value="Asmet Salud" <%= "Asmet Salud".equals(persona.getEps()) ? "selected" : ""%>>Asmet Salud</option>
                            <option value="Otro">Otro</option>
                        </select>
                        <!-- Campo de entrada oculto para "Otro" -->
                        <input type="text" id="otroEps" name="otroEps" style="display: none;" placeholder="Especifique otro"
                               value="<%= (persona.getEps() != null && !Persona.esEpsPredefinida(persona.getEps())) ? persona.getEps() : ""%>">
                        <!-- Campo oculto para almacenar el valor final -->
                        <input type="hidden" name="epsFinal" id="epsFinal" value="<%= persona.getEps() != null ? persona.getEps() : ""%>">
                    </td>
                </tr>
                <tr>
                    <th>Fondo de cesantías</th>
                    <td>
                        <select name="fondoCesantias" id="fondoCesantias" onchange="manejarOtro('fondoCesantias', 'otroFondoCesantias', 'fondoCesantiasFinal')">
                            <option value="" <%= (persona.getFondoCesantias() == null || persona.getFondoCesantias().trim().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="Porvenir" <%= "Porvenir".equals(persona.getFondoCesantias()) ? "selected" : ""%>>Porvenir</option>
                            <option value="Proteccion" <%= "Proteccion".equals(persona.getFondoCesantias()) ? "selected" : ""%>>Protección</option>
                            <option value="Fondo nacional de ahorro" <%= "Fondo nacional de ahorro".equals(persona.getFondoCesantias()) ? "selected" : ""%>>Fondo Nacional de Ahorro</option>
                            <option value="Otro" <%= (persona.getFondoCesantias() != null && !Persona.esFondoCesantiasPredefinida(persona.getFondoCesantias())) ? "selected" : ""%>>Otro</option>
                        </select>
                        <!-- Campo de entrada oculto para "Otro" -->
                        <input type="text" id="otroFondoCesantias" name="otroFondoCesantias" style="display: none;" placeholder="Especifique otro"
                               value="<%= (persona.getFondoCesantias() != null && !Persona.esFondoCesantiasPredefinida(persona.getFondoCesantias())) ? persona.getFondoCesantias() : ""%>">

                        <!-- Campo oculto para almacenar el valor final -->
                        <input type="hidden" name="fondoCesantiasFinal" id="fondoCesantiasFinal" value="<%= persona.getFondoCesantias() != null ? persona.getFondoCesantias() : ""%>">
                    </td>
                </tr>
                <tr>
                    <th>Fondo de pensiones</th>
                    <td>
                        <select name="fondoPensiones" id="fondoPensiones" onchange="manejarOtro('fondoPensiones', 'otroFondoPensiones', 'fondoPensionesFinal')">
                            <option value="" <%= (persona.getFondoPensiones() == null || persona.getFondoPensiones().trim().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="Porvenir" <%= "Porvenir".equalsIgnoreCase(persona.getFondoPensiones()) ? "selected" : ""%>>Porvenir</option>
                            <option value="Proteccion" <%= "Proteccion".equalsIgnoreCase(persona.getFondoPensiones()) ? "selected" : ""%>>Protección</option>
                            <option value="Colpensiones" <%= "Colpensiones".equalsIgnoreCase(persona.getFondoPensiones()) ? "selected" : ""%>>Colpensiones</option>
                            <option value="Otro" <%= (persona.getFondoPensiones() != null && !Persona.esFondoPensionesPredefinido(persona.getFondoPensiones())) ? "selected" : ""%>>Otro</option>
                        </select>
                        <input type="text" id="otroFondoPensiones" name="otroFondoPensiones" style="display: none;" placeholder="Especifique otro"
                               value="<%= (persona.getFondoPensiones() != null && !Persona.esFondoPensionesPredefinido(persona.getFondoPensiones().trim())) ? persona.getFondoPensiones().trim() : ""%>">
                        <input type="hidden" name="fondoPensionesFinal" id="fondoPensionesFinal" value="<%= persona.getFondoPensiones() != null ? persona.getFondoPensiones().trim() : ""%>">
                    </td>
                </tr>
                <tr>
                    <th>Arl</th>
                    <td><input type="text" name="arl" value="<%= persona.getArl()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <th>Banco</th>
                    <td><input type="text" name="cuentaBancaria" value="<%= persona.getCuentaBancaria()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <th>Número de cuenta</th>
                    <td><input type="text" name="numeroCuenta" value="<%= persona.getNumeroCuenta()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <th>Salario</th>
                    <td><input type="text" name="salario" value="<%= persona.getSalario()%>" size="50" maxlength="50"></td>
                </tr>
            </table>

            <h1>Informacion de dotación</h1> <!-- Formulario para Dotaciones -->
            <table border="1">
                <tr>
                    <th>Fecha de la próxima entrega</th>
                    <td><input type="date" name="fechaProEntrega" value="<%= persona.getFechaProEntrega()%>"></td>
                </tr>
                <tr>
                    <th>Fecha de la última entrega</th>
                    <td><input type="date" name="fechaUltiEntrega" value="<%= persona.getFechaUltiEntrega()%>"></td>
                </tr>
                <tr>
                    <th>Tipo de dotación</th>
                    <td>
                        <select name="tipoDotacion" required>
                            <option value="" <%= persona.getTipoDotacion() == null || persona.getTipoDotacion().trim().isEmpty() ? "selected" : ""%>>Seleccione...</option>
                            <option value="Parcial" <%= "Parcial".equals(persona.getTipoDotacion()) ? "selected" : ""%>>Parcial</option>
                            <option value="Completa" <%= "Completa".equals(persona.getTipoDotacion()) ? "selected" : ""%>>Completa</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Talla de camisa</th>
                    <td>
                        <select name="tallaCamisa" required>
                            <option value="" <%= persona.getTallaCamisa() == null || persona.getTallaCamisa().trim().isEmpty() ? "selected" : ""%>>Seleccione...</option>
                            <option value="XS" <%= "XS".equals(persona.getTallaCamisa()) ? "selected" : ""%>>XS</option>
                            <option value="S" <%= "S".equals(persona.getTallaCamisa()) ? "selected" : ""%>>S</option>
                            <option value="M" <%= "M".equals(persona.getTallaCamisa()) ? "selected" : ""%>>M</option>
                            <option value="L" <%= "L".equals(persona.getTallaCamisa()) ? "selected" : ""%>>L</option>
                            <option value="XL" <%= "XL".equals(persona.getTallaCamisa()) ? "selected" : ""%>>XL</option>
                            <option value="XXL" <%= "XXL".equals(persona.getTallaCamisa()) ? "selected" : ""%>>XXL</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Talla de chaqueta</th>
                    <td>
                        <select name="tallaChaqueta" required>
                            <option value="" <%= persona.getTallaChaqueta() == null || persona.getTallaChaqueta().trim().isEmpty() ? "selected" : ""%>>Seleccione...</option>
                            <option value="XS" <%= "XS".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>XS</option>
                            <option value="S" <%= "S".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>S</option>
                            <option value="M" <%= "M".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>M</option>
                            <option value="L" <%= "L".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>L</option>
                            <option value="XL" <%= "XL".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>XL</option>
                            <option value="XXL" <%= "XXL".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>XXL</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Talla de guantes</th>
                    <td>
                        <select name="tallaGuantes" required>
                            <option value="" <%= (persona.getTallaGuantes() == null || persona.getTallaGuantes().trim().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="XS" <%= "XS".equals(persona.getTallaGuantes()) ? "selected" : ""%>>XS</option>
                            <option value="S" <%= "S".equals(persona.getTallaGuantes()) ? "selected" : ""%>>S</option>
                            <option value="M" <%= "M".equals(persona.getTallaGuantes()) ? "selected" : ""%>>M</option>
                            <option value="L" <%= "L".equals(persona.getTallaGuantes()) ? "selected" : ""%>>L</option>
                            <option value="XL" <%= "XL".equals(persona.getTallaGuantes()) ? "selected" : ""%>>XL</option>
                            <option value="XXL" <%= "XXL".equals(persona.getTallaGuantes()) ? "selected" : ""%>>XXL</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Talla de buzo</th>
                    <td>
                        <select name="tallaBuzo" required>
                            <option value="" <%= (persona.getTallaBuzo() == null || persona.getTallaBuzo().trim().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="XS" <%= "XS".equals(persona.getTallaBuzo()) ? "selected" : ""%>>XS</option>
                            <option value="S" <%= "S".equals(persona.getTallaBuzo()) ? "selected" : ""%>>S</option>
                            <option value="M" <%= "M".equals(persona.getTallaBuzo()) ? "selected" : ""%>>M</option>
                            <option value="L" <%= "L".equals(persona.getTallaBuzo()) ? "selected" : ""%>>L</option>
                            <option value="XL" <%= "XL".equals(persona.getTallaBuzo()) ? "selected" : ""%>>XL</option>
                            <option value="XXL" <%= "XXL".equals(persona.getTallaBuzo()) ? "selected" : ""%>>XXL</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Talla de overol</th>
                    <td>
                        <select name="tallaOverol" required>
                            <option value="" <%= (persona.getTallaOverol()== null || persona.getTallaOverol().trim().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <option value="XS" <%= "XS".equals(persona.getTallaOverol()) ? "selected" : ""%>>XS</option>
                            <option value="S" <%= "S".equals(persona.getTallaOverol()) ? "selected" : ""%>>S</option>
                            <option value="M" <%= "M".equals(persona.getTallaOverol()) ? "selected" : ""%>>M</option>
                            <option value="L" <%= "L".equals(persona.getTallaOverol()) ? "selected" : ""%>>L</option>
                            <option value="XL" <%= "XL".equals(persona.getTallaOverol()) ? "selected" : ""%>>XL</option>
                            <option value="XXL" <%= "XXL".equals(persona.getTallaOverol()) ? "selected" : ""%>>XXL</option>
                        </select>
                    </td>
                </tr>
                </tr>
                <tr>
                    <th>Talla de pantalón</th>
                    <td>
                        <select name="tallaPantalon" required>
                            <option value="" <%= (persona.getTallaPantalon() == null || persona.getTallaPantalon().trim().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <% for (int i = 28; i <= 44; i += 2) {%>
                            <option value="<%= i%>" <%= Integer.toString(i).equals(persona.getTallaPantalon()) ? "selected" : ""%>><%= i%></option>
                            <% }%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Talla de calzado</th>
                    <td>
                        <select name="tallaCalzado" required>
                            <option value="" <%= (persona.getTallaCalzado() == null || persona.getTallaCalzado().trim().isEmpty()) ? "selected" : ""%>>Seleccione...</option>
                            <% for (int i = 34; i <= 46; i++) {%>
                            <option value="<%= i%>" <%= Integer.toString(i).equals(persona.getTallaCalzado()) ? "selected" : ""%>><%= i%></option>
                            <% }%>
                        </select>
                    </td>
                </tr>
            </table>
            <div class="botones-container">
                <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>">
                <input type="submit" name="accion" value="<%=accion%>">
                <input type="button" value="Cancelar" onClick="window.history.back()">
            </div>
    </div>
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
        //////////////////////////////////////////////////////////////////////////////////////////////
        function manejarOtro(selectId, inputId, hiddenId) {
            var select = document.getElementById(selectId);
            var input = document.getElementById(inputId);
            var hiddenInput = document.getElementById(hiddenId);

            if (select.value === "Otro") {
                input.style.display = "block";
                input.required = true;
                input.focus();
                input.addEventListener("input", function () {
                    hiddenInput.value = input.value;  // Guardar el valor ingresado en el campo oculto
                });
            } else {
                input.style.display = "none";
                input.required = false;
                input.value = "";
                hiddenInput.value = select.value;  // Guardar la opción seleccionada en el campo oculto
            }

            // Obtener las opciones del select y guardarlas en un array
            const listaCargos = [];
            document.querySelectorAll("#idCargo option").forEach(option => {
                if (option.value.trim() !== "") {
                    listaCargos.push(option.textContent.trim());
                }
            });

            function filtrarCargos() {
                let input = document.getElementById("tipoCargo");
                let sugerenciasDiv = document.getElementById("sugerenciasCargo");
                let texto = input.value.toLowerCase();

                // Limpiar sugerencias previas
                sugerenciasDiv.innerHTML = "";

                if (texto === "") {
                    sugerenciasDiv.style.display = "none";
                    return;
                }

                // Filtrar opciones que comiencen con lo escrito
                let sugerencia = listaCargos.find(cargo => cargo.toLowerCase().startsWith(texto));

                if (sugerencia) {
                    input.value = sugerencia; // Autocompleta el input
                }

                sugerenciasDiv.style.display = "none";
            }

        }

        // Función para precargar la unidad de negocio al seleccionar un establecimiento
        function precargarUnidadNegocio() {
            var establecimiento = document.getElementById("establecimiento").value;
            var unidadNegocio = document.getElementById("unidadNegocio");

            // Mapeo de establecimientos a unidades de negocio
            var unidades = {
                "Avenida": "Green S.A.S. RPS",
                "Principal": "Green S.A.S. RPS",
                "Centro": "Green S.A.S. RPS",
                "Unicentro": "Green S.A.S. RPS",
                "Centro de Procesos": "Green S.A.S. RPS",
                "Teleoperaciones": "Green S.A.S. RPS",
                "Juanambu": "Green S.A.S. EDS",
                "Terminal Americano": "Green S.A.S. EDS",
                "Puente": "Green S.A.S. EDS",
                "Canobajo": "Green S.A.S. EDS",
                "Greenfield": "Green S.A.S."
            };

            // Asignar unidad de negocio basada en el establecimiento seleccionado
            unidadNegocio.value = unidades[establecimiento] || "";
        }

        // Precargar la unidad de negocio al cargar la página
        document.addEventListener("DOMContentLoaded", precargarUnidadNegocio);


        window.onload = function () {

            cargarUnidadNegocio();

            let departamentoNacimientoSelect = document.getElementById("departamentoNacimiento");
            let departamentoExpedicionSelect = document.getElementById("departamentoExpedicion");
            let municipioNacimientoSelect = document.getElementById("municipioNacimiento");
            let municipioExpedicionSelect = document.getElementById("municipioExpedicion");

            if (departamentoNacimientoSelect.value !== "") {
                cargarMunicipios(departamentoNacimientoSelect, "municipioNacimiento", "<%= persona.getIdMunicipioNacimiento()%>");
            }
            if (departamentoExpedicionSelect.value !== "") {
                cargarMunicipios(departamentoExpedicionSelect, "municipioExpedicion", "<%= persona.getIdMunicipioExpedicion()%>");
            }
        };

        function cargarMunicipios(idDepartamento, tipoLugar) {
            var municipioSelect = document.getElementById(tipoLugar === 'expedicion' ? 'municipioExpedicion' : 'municipioNacimiento');
            municipioSelect.innerHTML = '<option value="">Cargando...</option>';

            fetch("cargarMunicipios.jsp?idDepartamento=" + idDepartamento + "&tipoLugar=" + tipoLugar)
                    .then(response => response.text())
                    .then(data => {
                        municipioSelect.innerHTML = data;
                    });
        }

        let referenciaCount = 0; //referencias Personales añadir es la variable para contar las referencias que muestro

        function agregarReferencia() {
            if (referenciaCount < 2) {
                referenciaCount++;
                document.querySelectorAll(".referencia" + referenciaCount).forEach(el => el.style.display = "table-row");
            }
        }

        function eliminarReferencia(ref) {
            document.querySelectorAll(".referencia" + ref).forEach(el => el.style.display = "none");
            if (referenciaCount === ref) {
                referenciaCount--;
            }
        }
        function mostrarOcultarVehiculo() {
            var tieneVehiculo = document.querySelector('input[name="tieneVehiculo"]:checked').value;

            // Si la opción seleccionada es "No"
            if (tieneVehiculo === "No") {
                // Establecer los campos del vehículo a null (vacío en el formulario)
                document.getElementsByName("numeroPlacaVehiculo")[0].value = "";
                document.getElementsByName("tipoVehiculo")[0].value = "";
                document.getElementsByName("modeloVehiculo")[0].value = "";
                document.getElementsByName("linea")[0].value = "";
                document.getElementsByName("marca")[0].value = "";
                document.getElementsByName("color")[0].value = "";
                document.getElementsByName("cilindraje")[0].value = "";
                document.getElementsByName("restricciones")[0].value = "";
                document.getElementsByName("numLicenciaTransito")[0].value = "";
                document.getElementsByName("fechaExpLicenciaTransito")[0].value = "";
                document.getElementsByName("estado")[0].value = "Inactivo";  // Establecer estado a "Inactivo"
                document.getElementsByName("fechaExpConduccion")[0].value = "";
                document.getElementsByName("fechaVencimiento")[0].value = "";
                document.getElementsByName("numLicenciaConduccion")[0].value = "";

                // Ocultar los campos de vehículo
                document.getElementById("tablaVehiculo").style.display = "none";
            } else {
                // Si la opción seleccionada es "Sí", mostrar los campos de vehículo
                document.getElementById("tablaVehiculo").style.display = "block";
            }
        }

        // Ejecutar la función al cargar la página para mostrar u ocultar correctamente
        window.onload = function () {
            mostrarOcultarVehiculo();
        };
    </script>