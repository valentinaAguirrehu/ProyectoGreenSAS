<%-- 
    Document   : personaAFormulario
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

<%
   
    String accion = request.getParameter("accion");
    String identificacion = request.getParameter("identificacion");
    Persona persona = new Persona();

    if ("Modificar".equals(accion)) {
        persona = new Persona(identificacion);

    }
    
    // Validar que la identificación no sea nula o vacía
    if (identificacion != null && !identificacion.isEmpty()) {
        session.setAttribute("identificacion", identificacion);  // Almacenar en sesión
    }
   
    // Obtener los parámetros del formulario y evitar valores nulos
    String idDepartamento = request.getParameter("departamento") != null ? request.getParameter("departamento") : "";
    String idMunicipio = request.getParameter("lugarExpedicion") != null ? request.getParameter("lugarExpedicion") : "";

    // Concatenar los valores de forma segura
    String lugarExpedicion = idDepartamento + "-" + idMunicipio;


    // Supongamos que persona.getHijos() devuelve List<Hijo> o similar
    boolean tieneHijos = persona.getHijos() != null && !persona.getHijos().isEmpty();


%>

<%@ include file="../menu.jsp" %>

<link rel="stylesheet" href="../presentacion/style-FormularioColaboradores.css">
</head>
<body>
    <div class="content"> 
        <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> APRENDIZ</h3>
        <form name="formulario" method="post" action="aprendizActualizar.jsp" onsubmit="obtenerDatosHijos(); pasarIdentificacion(); enviarDatos(); return false; redirigirDespuesGuardar();">
            <h1>Datos personales</h1>
            <table border="1">
                <tr>
                    <th>Nombres<span style="color: red;">*</span></th>
                    <td><input type="text" name="nombres" value="<%= persona.getNombres()%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>Apellidos<span style="color: red;">*</span></th>
                    <td><input type="text" name="apellidos" value="<%= persona.getApellidos()%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th colspan="2">Sexo<span style="color: red;">*</span></th>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="radio-container">
                            <%= persona.getGeneroPersona().getRadioButtons()%>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>Documento de identidad<span style="color: red;">*</span></th>
                    <td colspan="2">
                        <%= persona.getTipoDocumento().getSelectTipoDocumento("tipoDocumento") %>
                    </td>
                </tr>
                <tr>
                    <th>Número de documento<span style="color: red;">*</span></th>
<!--                        <input type="text" name="identificacion" id="identificacion" value="<%= persona.getIdentificacion() %>" -->
                    <td><input type="text" id="identificacion" name="identificacion" value="<%=persona.getIdentificacion()%>" 
                               size="50" maxlength="50" 
                               onkeypress="return soloNumeros(event)" 
                               onblur="validarNumerico('identificacion')" placeholder="Campo numérico" required>
                        <input type="hidden" id="accion" name="accion" value="<%=accion%>">

                    </td>
                </tr>
                <tr>
                    <th>Fecha de expedición<span style="color: red;">*</span></th>
                    <td><input type="date" name="fechaExpedicion" value="<%= persona.getFechaExpedicion()%>"required></td>
                </tr>
                <tr>
                    <th colspan="2" >Lugar de expedición<span style="color: red;">*</span></th>
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
                    <th>Fecha de nacimiento<span style="color: red;">*</span></th>
                    <td><input type="date" name="fechaNacimiento" value="<%= persona.getFechaNacimiento()%>" required></td>
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
                    <th>Tipo de sangre<span style="color: red;">*</span></th>
                    <td colspan="2">
                        <%= persona.getTipoSangre().getSelectTipoSangre("tipoSangre") %>
                    </td>
                </tr>

                <tr>
                    <th>Tipo de vivienda<span style="color: red;">*</span></th>
                    <td colspan="2">
                        <%= persona.getTipoVivienda().getSelectTipoVivienda("tipoVivienda") %>
                    </td>
                </tr>

                <tr>
                    <th>Dirección<span style="color: red;">*</span></th>
                    <td><input type="text" name="direccion" value="<%= persona.getDireccion()%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>Barrio<span style="color: red;">*</span></th>
                    <td><input type="text" name="barrio" value="<%= persona.getBarrio()%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>Celular<span style="color: red;">*</span></th>
                    <td>
                        <input type="text" name="celular" value="<%= persona.getCelular()%>" 
                               size="50" maxlength="10" pattern="\d{10}" 
                               title="Ingrese exactamente 10 números"
                               onkeypress="return soloNumeros(event)" 
                               onblur="validarNumerico('celular')
                               " placeholder="Campo numérico"
                               required>
                    </td>
                </tr>
                <tr>
                    <th>Correo electrónico<span style="color: red;">*</span></th>
                    <td><input type="email" name="email" value="<%= persona.getEmail()%>" size="50" maxlength="50" required></td>
                </tr>

                <tr>
                    <th>Estado civil<span style="color: red;">*</span></th>
                    <td colspan="2">
                        <%= persona.getEstadoCivil().getSelectEstadoCivil("estadoCivil") %>
                    </td>
                </tr>
                <tr>
                    <th>Nivel educativo<span style="color: red;">*</span></th>
                    <td><input type="text" name="nivelEdu" value="<%= persona.getNivelEdu()%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>Profesion</th>
                    <td><input type="text" name="profesion" value="<%= persona.getProfesion()%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <th>Cuenta bancaria<span style="color: red;">*</span></th>
                    <td><input type="text" name="cuentaBancaria" value="<%= persona.getCuentaBancaria()%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>Número de cuenta<span style="color: red;">*</span></th>
                    <td><input type="text" name="numeroCuenta" value="<%= persona.getNumeroCuenta()%>" size="50" maxlength="50"
                               onkeypress="return soloNumeros(event)" 
                               onblur="validarNumerico('numeroCuenta')
                               " placeholder="Campo numérico"></td>
                </tr>
                <tr>
                    <th colspan="2">¿El colaborador tiene hijos?<span style="color: red;">*</span></th>
                </tr>
                <tr>  
                    <td colspan="2">
                        <div class="radio-container">
                            <label>
                                <input type="radio" name="tieneHijos" value="S" onclick="mostrarHijos()" 
                                       <%= tieneHijos ? "checked" : "" %>> Sí
                            </label>
                            <label>
                                <input type="radio" name="tieneHijos" value="N" onclick="mostrarHijos()" 
                                       <%= !tieneHijos ? "checked" : "" %>> No
                            </label>
                        </div>
                    </td>

                </tr>


            </table>
            <div id="familiaresSection" style="display: <%= "S".equals(persona.getTieneHijos()) ? "block" : "none" %>;">
                <h1>Información de Hijos</h1>
                <table border="0" id="tablaHijos">
                    <tr>
                        <th>Número de documento</th>
                        <th>Tipo de documento</th>
                        <th>Nombres completos</th>
                        <th>Fecha de Nacimiento</th>
                        <th>Nivel educativo</th>
                        <th>Acción</th>
                    </tr>
                    <%
                        if (persona.obtenerHijos() != null && !persona.obtenerHijos().isEmpty()) {
                            for (Hijo hijo : persona.obtenerHijos()) {
                    %>
                    <tr>
                        <td><input type="text" name="identificacionHijo[]" value="<%= hijo.getIdentificacion() %>" size="10" maxlength="10" required></td>
                        <td><input type="text" name="tipoIdenHijo[]" value="<%= hijo.getTipoIden() %>" size="10" maxlength="10" required></td>
                        <td><input type="text" name="nombreHijo[]" value="<%= hijo.getNombres() %>" size="50" maxlength="50" required></td>
                        <td><input type="date" name="fechaNacimientoHijo[]" value="<%= hijo.getFechaNacimiento() %>" required></td>
                        <td><input type="text" name="nivelEscolarHijo[]" value="<%= hijo.getNivelEscolar() %>" size="20" maxlength="20" required></td>
                        <td><button type="button" onclick="eliminarFila(this)">Eliminar</button></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    <tr>
                        <td colspan="6">
                            <button type="button" onclick="agregarHijo()">Agregar Hijo</button>
                        </td>
                    </tr>
                </table>
            </div>



            <div class="botones-container">
                <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>">
                <input type="submit" name="accion" value="<%=accion%>">
                <input type="button" value="Regresar" onClick="window.history.back()" />
                <input type="button" value="Cancelar" onclick="window.location.href = 'aprendiz.jsp'" />
                <!-- Nuevo botón de cambio de estado -->
                <!--<input type="button" value="Cambiar a Temporal" onclick="cambiarAEstadoTemporal()">-->
            </div>

            <% if ("Modificar".equals(accion)) { %>
            <input type="hidden" id="identificacionHidden" name="identificacionHidden">
            <button type="button" onclick="irASiguiente()">Siguiente: Seguridad social</button>
            <% } %>

    </div>


    <script>


        function irASiguiente() {
            var identificacionVisible = document.getElementById("identificacion").value;
            var accion = document.getElementById("accion").value;

            var url = 'seguridadSocialAFormulario.jsp?irASiguiente=true'
                    + '&identificacion=' + encodeURIComponent(identificacionVisible)
                    + '&accion=' + encodeURIComponent(accion);

            window.location.href = url;
        }


        // Función para mostrar/ocultar la sección de hijos
        function mostrarHijos() {
            var tieneHijosRadio = document.querySelector('input[name="tieneHijos"]:checked');
            var familiaresSection = document.getElementById("familiaresSection");
            if (tieneHijosRadio && tieneHijosRadio.value === "S") {
                familiaresSection.style.display = "block";
            } else {
                familiaresSection.style.display = "none";
            }
        }

        // Función para agregar un nuevo hijo a la tabla
        function agregarHijo() {
            var tabla = document.getElementById("tablaHijos");
            var fila = tabla.insertRow(tabla.rows.length - 1);
            fila.innerHTML = `<td><input type="text" name="identificacionHijo[]" size="10" maxlength="10" required></td>
                              <td><input type="text" name="tipoIdenHijo[]" size="50" maxlength="50" required></td>
                              <td><input type="text" name="nombreHijo[]" size="50" maxlength="50" required></td>
                              <td><input type="date" name="fechaNacimientoHijo[]" required></td>
                              <td><input type="text" name="nivelEscolarHijo[]" size="50" maxlength="50" required></td>
                              <td><button type="button" onclick="eliminarFila(this)">Eliminar</button></td>
                              `;
        }

        // Función para eliminar una fila de la tabla de hijos
        function eliminarFila(boton) {
            var fila = boton.parentNode.parentNode;
            fila.parentNode.removeChild(fila);
        }
        document.addEventListener("DOMContentLoaded", function () {
            mostrarHijos();

            // Además, asignar evento a los radio buttons para que cambien visibilidad al clic
            document.querySelectorAll('input[name="tieneHijos"]').forEach(function (radio) {
                radio.addEventListener("change", mostrarHijos);
            });
        });


        //FUNCION MUNICIPIOS
        function cargarMunicipios(idDepartamento, tipoLugar) {
            var municipioSelect = document.getElementById(tipoLugar === 'expedicion' ? 'municipioExpedicion' : 'municipioNacimiento');
            municipioSelect.innerHTML = '<option value="">Cargando...</option>';
            fetch("cargarMunicipios.jsp?idDepartamento=" + idDepartamento + "&tipoLugar=" + tipoLugar)
                    .then(response => response.text())
                    .then(data => {
                        municipioSelect.innerHTML = data;
                    });
        }


        function manejarOtro(selectId, inputId, hiddenId) {
            var select = document.getElementById(selectId);
            var input = document.getElementById(inputId);
            var hiddenInput = document.getElementById(hiddenId);

            function actualizarHidden() {
                if (select.value === "O") {
                    hiddenInput.value = input.value;
                } else {
                    hiddenInput.value = select.value;
                }
            }

            if (select.value === "O") {
                input.style.display = "inline-block";
                input.required = true;
                actualizarHidden(); // Actualiza el hidden al momento

                input.removeEventListener("input", actualizarHidden);
                input.addEventListener("input", actualizarHidden);
            } else {
                input.style.display = "none";
                input.required = false;
                input.value = "";
                actualizarHidden();
            }
        }

        window.addEventListener('DOMContentLoaded', function () {
            manejarOtro('tipoSangre', 'tipoSangreOtro', 'tipoSangreFinal');
            manejarOtro('tipoVivienda', 'tipoViviendaOtro', 'tipoViviendaFinal');
            manejarOtro('tipoDocumento', 'tipoDocumentoOtro', 'tipoDocumentoFinal');
        });



        // Función que se ejecuta al hacer clic en el botón para cambiar el estado a "Temporal"
        function cambiarAEstadoTemporal() {
            var identificacion = document.getElementById("identificacion").value;
            var accion = 'Temporal'; // Este es el nuevo estado

            // Creación de un formulario dinámico que envíe los datos al servidor
            var form = document.createElement("form");
            form.method = "POST";
            form.action = ""; // Esto enviará los datos a la misma página

            // Crear los campos para el identificador y la acción
            var inputIdentificacion = document.createElement("input");
            inputIdentificacion.type = "hidden";
            inputIdentificacion.name = "identificacion";
            inputIdentificacion.value = identificacion;
            form.appendChild(inputIdentificacion);

            var inputAccion = document.createElement("input");
            inputAccion.type = "hidden";
            inputAccion.name = "accion";
            inputAccion.value = accion;
            form.appendChild(inputAccion);

            // Enviar el formulario de forma automática
            document.body.appendChild(form);
            form.submit();
        }
        function cambiarAEstadoTemporal() {
            var identificacion = document.getElementById("identificacion").value;
            var accion = 'colaborador'; // Este es el nuevo estado

            // Creación de un formulario dinámico que envíe los datos al servidor
            var form = document.createElement("form");
            form.method = "POST";
            form.action = ""; // Esto enviará los datos a la misma página

            // Crear los campos para el identificador y la acción
            var inputIdentificacion = document.createElement("input");
            inputIdentificacion.type = "hidden";
            inputIdentificacion.name = "identificacion";
            inputIdentificacion.value = identificacion;
            form.appendChild(inputIdentificacion);

            var inputAccion = document.createElement("input");
            inputAccion.type = "hidden";
            inputAccion.name = "accion";
            inputAccion.value = accion;
            form.appendChild(inputAccion);

            // Enviar el formulario de forma automática
            document.body.appendChild(form);
            form.submit();
        }
    </script>