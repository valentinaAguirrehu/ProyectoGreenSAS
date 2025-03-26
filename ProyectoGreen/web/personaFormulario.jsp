<%-- 
    Document   : persona
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
<link rel="stylesheet" type="text/css" href="presentacion/estiloTablas.css">

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


<table border="1">




    <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADORES</h3>


    <form name="formulario" method="post" action="personaActualizar.jsp">

        <h1>Datos personales</h1>

        <table border="1">

            <tr>
                <th>Nombres</th>
                <td><input type="text" name="nombres" value="<%= persona.getNombres()%>" size="50" maxlength="50"></td>
            </tr>
            <tr>
                <th>Apellidos</th>
                <td><input type="text" name="apellidos" value="<%= persona.getApellidos()%>" size="50" maxlength="50"></td>
            </tr>
            <tr>
                <th>Fecha de Ingreso</th>
                <td><input type="date" name="fechaIngreso" value="<%= persona.getFechaIngreso()%>"></td>
            </tr>
            <tr>
                <th>Fecha de Retiro</th>
                <td><input type="date" name="fechaRetiro" value="<%= persona.getFechaRetiro()%>"></td>     
            <tr>
                <th>Tipo Documento</th>
                <td>
                    <select name="tipoDocumentoSelect" id="tipoDocumento" onchange="manejarOtro('tipoDocumento', 'otroTipoDocumento', 'tipoDocumentoHidden')">
                        <option value="">Seleccione...</option>
                        <option value="CC" <%= (persona.getTipoDocumento() == null || persona.getTipoDocumento().isEmpty() || "CC".equals(persona.getTipoDocumento())) ? "selected" : ""%>>Cédula de Ciudadanía</option>
                        <option value="TI" <%= "TI".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Tarjeta de Identidad</option>
                        <option value="CE" <%= "CE".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Cédula de Extranjería</option>
                        <option value="PA" <%= "PA".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Pasaporte</option>
                        <option value="EXT" <%= "EXT".equals(persona.getTipoDocumento()) ? "selected" : ""%>>Permiso Temporal</option>
                        <option value="Otro">Otro</option>
                    </select>
                    <!-- Campo de entrada oculto para "Otro" -->
                    <input type="text" id="otroTipoDocumento" name="otroTipoDocumento"
                           style="display: none;" placeholder="Especifique otro"
                           value="">
                    <!-- Campo oculto para almacenar el valor final -->
                    <input type="hidden" id="tipoDocumentoHidden" name="tipoDocumento"
                           value="<%= persona.getTipoDocumento() != null ? persona.getTipoDocumento() : ""%>">
                </td>
            </tr>
            <tr>
                <th>Identificación</th>
                <td><input type="text" name="identificacion" value="<%= persona.getIdentificacion()%>" </td>
            </tr>
            <tr>
                <th>Fecha de Expedición</th>
                <td><input type="date" name="fechaExpedicion" value="<%= persona.getFechaExpedicion()%>"></td>
            </tr>
            
            <tr>
    <th colspan="2">Lugar de Expedición</th>
</tr>
<tr>
    <td colspan="2">
        <label for="departamentoExpedicion"><b>Departamento:</b></label>
        <select name="departamentoExpedicion" id="departamentoExpedicion" onchange="cargarMunicipios(this, 'municipioExpedicion')">
            <option value="">Seleccione un Departamento</option>
            <%
                List<Departamento> departamentos = Departamento.getListaEnObjetos(null, "nombre ASC");
                String idDepartamentoExpedicion = persona.getIdDepartamento();
                for (Departamento departamento : departamentos) {
                    String selected = (idDepartamentoExpedicion != null && idDepartamentoExpedicion.equals(departamento.getId())) ? "selected" : "";
            %>
            <option value="<%= departamento.getId()%>" <%= selected%>><%= departamento.getNombre()%></option>
            <% }%>
        </select>

        <label for="municipioExpedicion"><b>Municipio:</b></label>
        <select name="lugarExpedicion" id="municipioExpedicion">
            <option value="">Seleccione un municipio</option>
        </select>
    </td>
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
    <th colspan="2">Lugar de Nacimiento</th>
</tr>
<tr>
    <td colspan="2">
        <label for="departamentoNacimiento"><b>Departamento:</b></label>
        <select name="departamentoNacimiento" id="departamentoNacimiento" onchange="cargarMunicipios(this, 'municipioNacimiento')">
            <option value="">Seleccione un Departamento</option>
            <%
                List<Departamento> departamentosNacimiento = Departamento.getListaEnObjetos(null, "nombre ASC");
                String idDepartamentoNacimiento = persona.getIdDepartamento();
                for (Departamento departamento : departamentosNacimiento) {
                    String selected = (idDepartamentoNacimiento != null && idDepartamentoNacimiento.equals(departamento.getId())) ? "selected" : "";
            %>
            <option value="<%= departamento.getId()%>" <%= selected%>><%= departamento.getNombre()%></option>
            <% }%>
        </select>

        <label for="municipioNacimiento"><b>Municipio:</b></label>
        <select name="lugarNacimiento" id="municipioNacimiento">
            <option value="">Seleccione un municipio</option>
        </select>
    </td>
</tr>
            
            
            
            
            
            
            
            <tr>
                <th>Tipo de Sangre</th>
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
                <th>Tipo de Vivienda</th>
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
                <td><input type="text" name="direccion" value="<%= persona.getDireccion()%>" size="50" maxlength="50"></td>
            </tr>
            <tr>
                <th>Barrio</th>
                <td><input type="text" name="barrio" value="<%= persona.getBarrio()%>" size="50" maxlength="50"></td>
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
                <th>Email</th>
                <td><input type="email" name="email" value="<%= persona.getEmail()%>" size="50" maxlength="50"></td>
            </tr>
            <tr>
                <th>Nivel Educativo</th>
                <td>
                    <select name="nivelEducativoSelect" id="nivelEducativo" onchange="manejarOtro('nivelEducativo', 'otroNivelEducativo', 'nivelEducativoHidden')">
                        <option value="">Seleccione...</option>
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
                           value="<%= persona.getNivelEducativo() != null ? persona.getNivelEducativo() : ""%>">
                </td>
            </tr>
            <tr>
                <th>Profesion</th>
                <td><input type="text" name="profesion" value="<%= persona.getProfesion()%>" size="50" maxlength="50"></td>
            </tr>
            <tr>
                <th>Estado Civil</th>
                <td>
                    <select name="estadoCivil">
                        <option value="Soltero" <%= (persona.getEstadoCivil() == null || persona.getEstadoCivil().isEmpty() || persona.getEstadoCivil().equals("Soltero")) ? "selected" : ""%>>Soltero</option>
                        <option value="Casado" <%= "Casado".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Casado</option>
                        <option value="Divorciado" <%= "Divorciado".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Divorciado</option>
                        <option value="Viudo" <%= "Viudo".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Viudo</option>
                        <option value="Unión Libre" <%= "Unión Libre".equals(persona.getEstadoCivil()) ? "selected" : ""%>>Unión Libre</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>EPS</th>
                <td>
                    <select name="eps" id="eps" onchange="manejarOtro('eps', 'otroEps', 'epsFinal')">
                        <option value="">Seleccione...</option>
                        <option value="Emssanar" <%= (persona.getEps() == null || persona.getEps().isEmpty() || "Emssanar".equals(persona.getEps())) ? "selected" : ""%>>Emssanar</option>
                        <option value="Sanitas" <%= "Sanitas".equals(persona.getEps()) ? "selected" : ""%>>Sanitas</option>
                        <option value="Nueva EPS" <%= "Nueva EPS".equals(persona.getEps()) ? "selected" : ""%>>Nueva EPS</option>
                        <option value="Compensar" <%= "Compensar".equals(persona.getEps()) ? "selected" : ""%>>Compensar</option>
                        <option value="Famisanar" <%= "Famisanar".equals(persona.getEps()) ? "selected" : ""%>>Famisanar</option>
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
                <th>Fondo Cesantias</th>
                <td><input type="text" name="fondoCesantias" value="<%= persona.getFondoCesantias()%>" size="50" maxlength="50"></td>
            </tr>
            <tr>
                <th>Fondo Pensiones</th>
                <td><input type="text" name="fondoPensiones" value="<%= persona.getFondoPensiones()%>" size="50" maxlength="50"></td>
            </tr>
        </table>

        <h2>Registro de hijos</h2>
        <table border="1" id="tablaHijos">
            <div id="familiaresSection" style="display: <%= persona.getTieneHijos().equals("S") ? "block" : "none"%>;">
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
            </div>
        </table>
        <h1>Informacion Vehiculos</h1> <!-- Formulario para vehiculos -->
        <table border="1">       
            <tr>
                <td><label>Número de Placa:</label></td>
                <td><input type="text" name="numeroPlacaVehiculo" value="<%= persona.getNumeroPlacaVehiculo()%>"size="50" maxlength="50"></td>
            </tr>
            <tr>
                <td><label>Tipo de Vehículo:</label></td>
                <td>
                    <select name="tipoVehiculo" required>
                        <option value="Moto" <%= persona.getTipoVehiculo() == null || persona.getTipoVehiculo().isEmpty() || "Moto".equals(persona.getTipoVehiculo()) ? "selected" : ""%>>Moto</option>
                        <option value="Carro" <%= "Carro".equals(persona.getTipoVehiculo()) ? "selected" : ""%>>Carro</option>
                        <option value="NoAplica" <%= "NoAplica".equals(persona.getTipoVehiculo()) ? "selected" : ""%>>No aplica</option>
                    </select>
                </td>
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
                <td><label>Marca:</label></td>
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


        <h1>Referencias Personales</h1> <!-- Tabla de Referencias Personales -->
        <table border="1">
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
                <td>
                    <input type="text" name="primerRefCelular" value="<%= persona.getPrimerRefCelular()%>" 
                           size="50" maxlength="10" pattern="\d{10}" 
                           title="Ingrese exactamente 10 números" required>
                </td>
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
                <td>
                    <input type="text" name="segundaRefCelular" value="<%= persona.getSegundaRefCelular()%>" 
                           size="50" maxlength="10" pattern="\d{10}" 
                           title="Ingrese exactamente 10 números" required>
                </td>
            </tr>

        </table>

        <h1>Información de Trabajo</h1> <!-- Tabla de Información de Trabajo -->
        <table border="1">

            <tr>
                <th>Fecha Termino Primer Contrato</th>
                <td><input type="date" name="fechaTerPriContrato" value="<%= persona.getFechaTerPriContrato()%>"></td>
            </tr>
            <tr>
                <th>Establecimiento</th>
                <td>
                    <select name="establecimiento" id="establecimiento" onchange="cargarUnidadNegocio()">
                        <option value="1" <%= "1".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Establecimiento 1</option>
                        <option value="2" <%= "2".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Establecimiento 2</option>
                        <option value="3" <%= "3".equals(persona.getEstablecimiento()) ? "selected" : ""%>>Establecimiento 3</option>
                    </select>
                </td>
            </tr>

            <tr>
                <th>Unidad de Negocio</th>
                <td>
                    <select name="unidadNegocio" id="unidadNegocio">
                        <!-- Las opciones se cargarán dinámicamente según el establecimiento seleccionado -->
                    </select>
                </td>
            </tr>

            <tr>
                <th>Centro de Costos</th>
                <td><input type="text" name="centroCostos" value="<%= persona.getCentroCostos()%>" size="50" maxlength="50"></td>
            </tr>

            <tr>
                <th>Área</th>
                <td>
                    <select name="area" id="area">
                        <option value="">Seleccione...</option>
                        <option value="Línea Media" <%= "Línea Media".equals(persona.getArea()) ? "selected" : ""%>>Línea Media</option>
                        <option value="Línea Directiva" <%= "Línea Directiva".equals(persona.getArea()) ? "selected" : ""%>>Línea Directiva</option>
                        <option value="Administrativo" <%= "Administrativo".equals(persona.getArea()) ? "selected" : ""%>>Administrativo</option>
                        <option value="Operativo" <%= "Operativo".equals(persona.getArea()) ? "selected" : ""%>>Operativo</option>
                    </select>
                </td>
            </tr>

            <tr>
            <tr>
                <th>Cargos</th>
                <td>
                    <select name="idCargo" id="idCargo" required>
                        <%= opcionesCargos%>
                    </select>
                </td>
            </tr>

            <tr>
                <th>Tipo de Cargo</th>
                <td>
                    <input type="text" name="tipoCargo" id="tipoCargo" value="<%= persona.getTipoCargo()%>" size="50" maxlength="50" autocomplete="off" onkeyup="filtrarCargos()">
                    <div id="sugerenciasCargo"></div>
                </td>
            </tr>

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

        <h1>Informacion Dotaciones</h1> <!-- Formulario para Dotaciones -->
        <table border="1">

            <tr>
                <th>Fecha Proxima Entrega</th>
                <td><input type="date" name="fechaProEntrega" value="<%= persona.getFechaProEntrega()%>"></td>
            </tr>
            <tr>
                <th>Fecha Ultima Entrega</th>
                <td><input type="date" name="fechaUltiEntrega" value="<%= persona.getFechaUltiEntrega()%>"></td>
            </tr>
            <tr>
                <th>Talla Camisa</th>
                <td>
                    <select name="tallaCamisa">
                        <option value="L" <%= (persona.getTallaCamisa() == null || persona.getTallaCamisa().isEmpty()) ? "selected" : ""%>>L</option>
                        <option value="XS" <%= "XS".equals(persona.getTallaCamisa()) ? "selected" : ""%>>XS</option>
                        <option value="S" <%= "S".equals(persona.getTallaCamisa()) ? "selected" : ""%>>S</option>
                        <option value="M" <%= "M".equals(persona.getTallaCamisa()) ? "selected" : ""%>>M</option>
                        <option value="XL" <%= "XL".equals(persona.getTallaCamisa()) ? "selected" : ""%>>XL</option>
                        <option value="XXL" <%= "XXL".equals(persona.getTallaCamisa()) ? "selected" : ""%>>XXL</option>
                    </select>
                </td>
            </tr>

            <tr>
                <th>Talla Chaqueta</th>
                <td>
                    <select name="tallaChaqueta">
                        <option value="L" <%= (persona.getTallaChaqueta() == null || persona.getTallaChaqueta().isEmpty()) ? "selected" : ""%>>L</option>
                        <option value="XS" <%= "XS".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>XS</option>
                        <option value="S" <%= "S".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>S</option>
                        <option value="M" <%= "M".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>M</option>
                        <option value="XL" <%= "XL".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>XL</option>
                        <option value="XXL" <%= "XXL".equals(persona.getTallaChaqueta()) ? "selected" : ""%>>XXL</option>
                    </select>
                </td>
            </tr>

            <tr>
                <th>Talla Pantalón</th>
                <td>
                    <select name="tallaPantalon">
                        <option value="32" <%= (persona.getTallaPantalon() == null || persona.getTallaPantalon().isEmpty()) ? "selected" : ""%>>32</option>
                        <% for (int i = 28; i <= 44; i += 2) {%>
                        <option value="<%= i%>" <%= Integer.toString(i).equals(persona.getTallaPantalon()) ? "selected" : ""%>><%= i%></option>
                        <% }%>
                    </select>
                </td>
            </tr>
            <tr>
                <th>Talla Calzado</th>
                <td>
                    <select name="tallaCalzado">
                        <option value="36" <%= (persona.getTallaCalzado() == null || persona.getTallaCalzado().isEmpty()) ? "selected" : ""%>>36</option>
                        <% for (int i = 34; i <= 46; i++) {
                                if (i != 36) { // Evita duplicar el 36 en la lista
                        %>
                        <option value="<%= i%>" <%= Integer.toString(i).equals(persona.getTallaCalzado()) ? "selected" : ""%>><%= i%></option>
                        <%
                        }
                    }%>
                    </select>
                </td>
            </tr>
        </table>



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
        function cargarUnidadNegocio() {
            var establecimiento = document.getElementById("establecimiento").value;
            var unidadNegocio = document.getElementById("unidadNegocio");

            // Limpiar las opciones de Unidad de Negocio
            unidadNegocio.innerHTML = '';

            // Definir relaciones entre establecimientos y unidades de negocio (con 2 opciones cada uno)
            var opciones = {
                "1": [{value: "A", text: "Unidad de Negocio A"}, {value: "B", text: "Unidad de Negocio B"}],
                "2": [{value: "C", text: "Unidad de Negocio C"}, {value: "D", text: "Unidad de Negocio D"}],
                "3": [{value: "E", text: "Unidad de Negocio E"}, {value: "F", text: "Unidad de Negocio F"}]
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

    </script>