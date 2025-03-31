<%-- 
   Document   : aprendizFormulario
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <div class="search-container">
            <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> APRENDIZ</h3>
            <form name="formulario" method="post" action="aprendizActualizar.jsp"></form>
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
                        <th>Sexo</th>
                        <th><%=persona.getGeneroPersona().getRadioButtons()%></th>   
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
                        <th>Fecha etapa lectiva</th>
                        <td><input type="date" name="fechaEtapaLectiva" value="<%= persona.getFechaEtapaLectiva()%>"required></td>
                    </tr>
                    <tr>
                        <th>Fecha etapa productiva</th>
                        <td>
                            <input type="date" name="fechaEtapaProductiva" value="<%= (persona.getFechaEtapaProductiva() != null && !persona.getFechaEtapaProductiva().isEmpty()) ? persona.getFechaEtapaProductiva() : "0000-00-00"%>"required>
                        </td>     
                    </tr>
                    <tr>
                        <th>Documento de identidad</th>
                        <td>
                            <select name="tipoDocumentoSelect" id="tipoDocumento" onchange="manejarOtro('tipoDocumento', 'otroTipoDocumento', 'tipoDocumentoHidden')"required>
                                <option value="">Seleccione...</option>
                                <option value="CC" <%= (persona.getTipoDocumento() == null || persona.getTipoDocumento().isEmpty() || "CC".equals(persona.getTipoDocumento())) ? "selected" : ""%>>Cédula de Ciudadanía</option>
                                <option value="TI" <%= "TI".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Tarjeta de Identidad</option>
                                <option value="CE" <%= "CE".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Cédula de Extranjería</option>
                                <option value="EXT" <%= "EXT".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Permiso Temporal</option>
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
                        <th>Numero de documento</th>
                        <td><input type="text" name="identificacion" value="<%= persona.getIdentificacion()%>" required></td>
                    </tr>
                    <tr>
                        <th>Fecha de expedición</th>
                        <td><input type="date" name="fechaExpedicion" value="<%= persona.getFechaExpedicion()%>"required></td>
                    </tr>

                    <tr>
                        <th colspan="2" >Lugar de expedicion</th>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label for="departamentoExpedicion"><b>Departamento:</b></label>
                            <select name="departamentoExpedicion" id="departamentoExpedicion" onchange="cargarMunicipios(this, 'municipioExpedicion')" required>
                                <option value="">Seleccione un Departamento</option>
                                <%
                                    List<Departamento> departamentos = Departamento.getListaEnObjetos(null, "nombre ASC");
                                    String idDepartamentoExpedicion = persona.getIdDepartamento();  // Esto causa problemas
                                    for (Departamento departamento : departamentos) {
                                        String selected = (idDepartamentoExpedicion != null && idDepartamentoExpedicion.equals(departamento.getId())) ? "selected" : "";
                                %>
                                <option value="<%= departamento.getId()%>" <%= selected%>><%= departamento.getNombre()%></option>
                                <% }%>
                            </select>
                            <label for="municipioExpedicion"><b>Municipio:</b></label>
                            <select name="lugarExpedicion" id="municipioExpedicion" required>
                                <option value="">Seleccione un municipio</option>
                            </select>
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
                            <label for="departamentoNacimiento"><b>Departamento:</b></label>
                            <select name="departamentoNacimiento" id="departamentoNacimiento" onchange="cargarMunicipios(this, 'municipioNacimiento')" required>
                                <option value="">Seleccione un departamento</option>
                                <%
                                    List<Departamento> departamentos2 = Departamento.getListaEnObjetos(null, "nombre ASC");
                                    String idDepartamentoNacimiento = persona.getIdDepartamento();  // ❌ Esto también causaba problemas
                                    for (Departamento departamento : departamentos2) {
                                        String selected = (idDepartamentoNacimiento != null && idDepartamentoNacimiento.equals(departamento.getId())) ? "selected" : "";
                                %>
                                <option value="<%= departamento.getId()%>" <%= selected%>><%= departamento.getNombre()%></option>
                                <% }%>
                            </select>
                            <label for="municipioNacimiento"><b>Municipio:</b></label>
                            <select name="lugarNacimiento" id="municipioNacimiento" required>
                                <option value="">Seleccione un municipio</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>Tipo de sangre</th>
                        <td>
                            <select name="tipoSangre" required>
                                <option value="O+" <%= persona.getTipoSangre() == null || persona.getTipoSangre().isEmpty() || "O+".equals(persona.getTipoSangre()) ? "selected" : ""%>>O+</option>
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
                                <option value="Propia" <%= persona.getTipoVivienda() == null || persona.getTipoVivienda().isEmpty() || "Propia".equals(persona.getTipoVivienda()) ? "selected" : ""%>>Propia</option>
                                <option value="Arrendada" <%= "Arrendada".equals(persona.getTipoVivienda()) ? "selected" : ""%>>Arrendada</option>
                                <option value="Familiar" <%= "Familiar".equals(persona.getTipoVivienda()) ? "selected" : ""%>>Familiar</option>
                                <option value="Anticres " <%= "Anticres ".equals(persona.getTipoVivienda()) ? "selected" : ""%>>Anticres </option>
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
                        <th>Correo electronico</th>
                        <td><input type="email" name="email" value="<%= persona.getEmail()%>" size="50" maxlength="50"required></td>
                    </tr>
                    <tr>
                        <th colspan="2">Nivel educativo</th>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <select name="nivelEducativoSelect" id="nivelEducativo" onchange="manejarOtro('nivelEducativo', 'otroNivelEducativo', 'nivelEducativoHidden')"required>
                                <option value="">Seleccione...</option>
                                <option value="Primaria" <%= "Primaria".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Primaria</option>
                                <option value="Secundaria" <%= "Secundaria".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Secundaria</option>
                                <option value="Técnico" <%= "Técnico".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Técnico</option>
                                <option value="Tecnológico" <%= "Tecnológico".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Tecnológico</option>
                                <option value="Universitario" <%= (persona.getNivelEducativo() == null || persona.getNivelEducativo().isEmpty() || "Universitario".equals(persona.getNivelEducativo())) ? "selected" : ""%>>Universitario</option>
                                <option value="Postgrado" <%= "Postgrado".equals(persona.getNivelEducativo()) ? "selected" : ""%>>Postgrado</option>
                                <option value="Otro">Otro</option>
                            </select>
                            <input type="text" id="otroNivelEducativo" name="otroNivelEducativo"
                                   style="display: none;" placeholder="Especifique otro"
                                   value="">
                            <input type="hidden" id="nivelEducativoHidden" name="nivelEducativo"
                                   value="<%= persona.getNivelEducativo() != null ? persona.getNivelEducativo() : ""%>"required>      
                            <label for="profesion"><b>En</b></label>
                            <input type="text" name="profesion" value="<%= persona.getProfesion()%>" size="50" maxlength="50" required>
                        </td>
                    </tr>
                    <tr>
                        <th>Estado civil</th>
                        <td>
                            <select name="estadoCivil"required>
                                <option value="Soltero" <%= (persona.getEstadoCivil() == null || persona.getEstadoCivil().isEmpty() || persona.getEstadoCivil().equals("Soltero")) ? "selected" : ""%>>Soltero</option>
                                <option value="Casado" <%= "Casado".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Casado</option>
                                <option value="Divorciado" <%= "Divorciado".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Divorciado</option>
                                <option value="Viudo" <%= "Viudo".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Viudo</option>
                                <option value="Unión Libre" <%= "Unión Libre".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Unión Libre</option>
                            </select>
                        </td>
                    </tr>

                </table>
        </div>  

        <h1><label>¿Tiene hijos?</label></h1>
        <input type="radio" name="tieneHijos" value="S" onclick="mostrarHijos()" <%= persona.getTieneHijos().equals("S") ? "checked" : ""%>> Sí
        <input type="radio" name="tieneHijos" value="N" onclick="mostrarHijos()" <%= persona.getTieneHijos().equals("N") ? "checked" : ""%>> No

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
                    <td colspan="4"><button type="button" onclick="agregarHijo()">Agregar Hijo</button></td>
                </tr>
            </table>
        </div>


        <h1>Tiene medio de transporte</h1>
        <input type="radio" name="tieneVehiculo" value="Sí" id="tieneVehiculoSi" 
               <%= "Sí".equals(persona.getTieneVehiculo()) ? "checked" : ""%> 
               onchange="mostrarOcultarVehiculo()"> Sí
        <input type="radio" name="tieneVehiculo" value="No" id="tieneVehiculoNo" 
               <%= persona.getTieneVehiculo() == null || persona.getTieneVehiculo().equals("No") ? "checked" : ""%> 
               onchange="mostrarOcultarVehiculo()"> No




        <!-- Contenedor de la tabla de vehículos -->
        <div id="tablaVehiculo" style="display: none;">
            <h1>Información vehículos</h1>
            <table border="1">       
                <tr>
                    <td><label>Número de placa:</label></td>
                    <td><input type="text" name="numeroPlacaVehiculo" value="<%= persona.getNumeroPlacaVehiculo()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <td><label>Tipo medio de transporte:</label></td>
                    <td>
                        <select name="tipoVehiculo">
                            <option value="Motocicleta" <%= persona.getTipoVehiculo() == null || persona.getTipoVehiculo().isEmpty() || "Motocicleta".equals(persona.getTipoVehiculo()) ? "selected" : ""%>>Motocicleta</option>
                            <option value="Automovil" <%= "Automovil".equals(persona.getTipoVehiculo()) ? "selected" : ""%>>Automovil</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label>Modelo:</label></td>
                    <td><input type="text" name="modeloVehiculo" value="<%= persona.getModeloVehiculo()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <td><label>Línea:</label></td>
                    <td><input type="text" name="linea" value="<%= persona.getLinea()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <td><label>Marca:</label></td>
                    <td><input type="text" name="marca" value="<%= persona.getMarca()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <td><label>Color:</label></td>
                    <td><input type="text" name="color" value="<%= persona.getColor()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <td><label>Cilindraje:</label></td>
                    <td><input type="text" name="cilindraje" value="<%= persona.getCilindraje()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <td><label>Restricciones del conductor:</label></td>
                    <td><input type="text" name="restricciones" value="<%= persona.getRestricciones()%>"></td>
                </tr>
                <tr>
                    <td><label>Número tarjeta de propiedad</label></td>
                    <td><input type="text" name="numLicenciaTransito" value="<%= persona.getNumLicenciaTransito()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <td><label>Fecha exp. tarjeta de propiedad</label></td>
                    <td><input type="date" name="fechaExpLicenciaTransito" value="<%= persona.getFechaExpLicenciaTransito()%>"></td>
                </tr>
                <tr>
                    <td><label>Estado:</label></td>
                    <td>
                        <select name="estado" required>
                            <option value="">Seleccione...</option>
                            <option value="Activo" <%= "Activo".equals(persona.getEstado()) && (persona.getTieneVehiculo() == null || persona.getTieneVehiculo().equals("Sí")) ? "selected" : ""%>>Activo</option>
                            <option value="Inactivo" <%= "Inactivo".equals(persona.getEstado()) || (persona.getTieneVehiculo() != null && persona.getTieneVehiculo().equals("No")) ? "selected" : ""%>>Inactivo</option>
                            <option value="Suspendido" <%= "Suspendido".equals(persona.getEstado()) ? "selected" : ""%>>Suspendido</option>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td><label>Fecha exp. licencia de conducción:</label></td>
                    <td><input type="date" name="fechaExpConduccion" value="<%= persona.getFechaExpConduccion()%>"></td>
                </tr>
                <tr>
                    <td><label>Fecha de vencimiento:</label></td>
                    <td><input type="date" name="fechaVencimiento" value="<%= persona.getFechaVencimiento()%>"></td>
                </tr>
                <tr>
                    <td><label>Número licencia de conducción:</label></td>
                    <td>
                        <input type="text" name="numLicenciaConduccion" 
                               value="<%= persona.getNumLicenciaConduccion() != null ? persona.getNumLicenciaConduccion() : ""%>" 
                               size="50" maxlength="50">
                    </td>
                </tr>
            </table>
        </div>


        <h1>Referencias familiares</h1>

        <table border="1">
            <tr><th colspan="2">Referencia familiar 1</th></tr>
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

            <tr><th colspan="2">Referencia familiar 2</th></tr>
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

        <button type="button" onclick="agregarReferencia()">Añadir referencias personales</button>

        <table border="1">
            <!-- Oculto -->
            <tr class="referencia1" style="display: none;"><th colspan="2">Referencia familiar 3</th></tr>
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
            <tr class="referencia2" style="display: none;"><th colspan="2">Referencia familiar 4</th></tr>
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


        <h1>Información de trabajo</h1> <!-- Tabla de Información de Trabajo -->
        <table border="1">

            <tr>
                <th>Fecha termino primer contrato</th>
                <td><input type="date" name="fechaTerPriContrato" value="<%= persona.getFechaTerPriContrato()%>"></td>
            </tr>
            <tr>
                <th>Establecimiento</th>
                <td>
                    <select name="establecimiento" id="establecimiento" onchange="cargarUnidadNegocio()" required>
                        <option value="Avenida" <%= "Avenida".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Avenida</option>
                        <option value="Principal" <%= "Principal".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Principal</option>
                        <option value="Centro de Procesos" <%= "Centro de Procesos".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Centro de Procesos</option>
                        <option value="Unicentro" <%= "Unicentro".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Unicentro</option>
                        <option value="Teleoperaciones" <%= "Teleoperaciones".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Teleoperaciones</option>
                        <option value="Juanambu" <%= "Juanambu".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Juanambu</option>
                        <option value="Terminal Americano" <%= "Terminal Americano".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Terminal Americano</option>
                        <option value="Puente" <%= "Puente".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Puente</option>
                        <option value="Canobajo" <%= "Canobajo".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Canobajo</option>
                        <option value="Greenfield" <%= "Greenfield".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Greenfield</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>Unidad de negocio</th>
                <td>
                    <select name="unidadNegocio" id="unidadNegocio">
                        <!-- Las opciones se cargarán dinámicamente según el establecimiento seleccionado -->
                    </select>
                </td>
            </tr>

            <tr>
                <th>Centro de Costos</th>
                <td>
                    <select name="centroCostos" required>
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
                <th>Tipo de cargo</th>
                <td>
                    <input type="text" name="tipoCargo" id="tipoCargo" value="<%= persona.getTipoCargo()%>" size="50" maxlength="50" autocomplete="off" onkeyup="filtrarCargos()"required>
                    <div id="sugerenciasCargo"></div>
                </td>
            </tr>
            <tr>
                <th>EPS</th>
                <td>
                    <select name="eps" id="eps" onchange="manejarOtro('eps', 'otroEps', 'epsFinal')"required>
                        <option value="">Seleccione...</option>
                        <option value="Emssanar" <%= (persona.getEps() == null || persona.getEps().isEmpty() || "Emssanar".equals(persona.getEps())) ? "selected" : ""%>>Emssanar</option>
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
        <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>"><p>
            <input class="submit" type="submit" name="accion" value="<%=accion%>">
            <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
    </div> 
    <script>

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
        hiddenInput.value = input.value; // Guardar el valor ingresado en el campo oculto
        });
        } else {
        input.style.display = "none";
        input.required = false;
        input.value = "";
        hiddenInput.value = select.value; // Guardar la opción seleccionada en el campo oculto
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
                    function cargarUnidadNegocio() {
                var establecimiento = document.getElementById("establecimiento").value;
        var unidadNegocio = document.getElementById("unidadNegocio");
        // Limpiar opciones previas
        unidadNegocio.innerHTML = '';
        // Definir relaciones entre establecimientos y unidades de negocio
        var opciones = {
        "Avenida": [{value: "RPS", text: "Green S.A.S. RPS"}],
                "Principal": [{value: "RPS", text: "Green S.A.S. RPS"}],
                "Centro de Procesos": [{value: "RPS", text: "Green S.A.S. RPS"}],
                "Unicentro": [{value: "RPS", text: "Green S.A.S. RPS"}],
                "Teleoperaciones": [{value: "RPS", text: "Green S.A.S. RPS"}],
                "Juanambu": [{value: "EDS", text: "Green S.A.S. EDS"}],
                "Terminal Americano": [{value: "EDS", text: "Green S.A.S. EDS"}],
                "Puente": [{value: "EDS", text: "Green S.A.S. EDS"}],
                "Canobajo": [{value: "EDS", text: "Green S.A.S. EDS"}],
                "Greenfield": [{value: "Green S.A.S.", text: "Green S.A.S. "}]
        };
        // Si hay opciones para el establecimiento seleccionado, cargarlas
        if (opciones[establecimiento]) {
        opciones[establecimiento].forEach(function (opcion) {
        var nuevaOpcion = document.createElement("option");
        nuevaOpcion.value = opcion.value;
        nuevaOpcion.text = opcion.text;
        // Preseleccionar si coincide con el valor guardado en JSP
        if (opcion.value === "<%= persona.getUnidadNegocio()%>") {
        nuevaOpcion.selected = true;
        }

        unidadNegocio.appendChild(nuevaOpcion);
        });
        }
    }
            
                        
            // Precargar la Unidad de Negocio si ya hay un establecimiento seleccionado
                            window.onload = function () {
            cargarUnidadNegocio();
                    };
                    
                    
                    function cargarMunicipios(departamentoSelect, municipioId) {
                var idDepartamento = departamentoSelect.value;
        var municipioSelect = document.getElementById(municipioId);
        municipioSelect.innerHTML = '<option value="">Cargando...</option>';
        fetch("cargarMunicipios.jsp?idDepartamento=" + idDepartamento)
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
        document.getElementsByName("estado")[0].value = "Inactivo"; // Establecer estado a "Inactivo"
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