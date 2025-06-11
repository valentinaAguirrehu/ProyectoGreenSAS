<%-- 
    Document   : vahiculoFormulario
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>

<%@page import="clases.InformacionLaboral"%>
<%@page import="clases.Vehiculo"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="presentacion/style-PersonaFormulario.css">

<%

    String accion = request.getParameter("accion");
    // Recuperar la identificación desde la URL o el formulario anterior
    String identificacion = request.getParameter("identificacion");
    // Instancia vacía con la identificación por si no se encuentra en BD
    System.out.println(" Entrando a vehiculoFormulario.jsp con identificacion=" + identificacion + " y accion=" + accion);
    Vehiculo vehiculo = new Vehiculo(identificacion);

    if (accion == null) {
        accion = "Adicionar";
    }

    // Validar que la identificación no sea nula o vacía
    if (identificacion != null && !identificacion.isEmpty()) {
        session.setAttribute("identificacion", identificacion);  // Almacenar en sesión
    }
    // Solo intenta obtener de la BD si la acción es "Modificar"
    // Verifica si la acción a realizar es "Modificar"
    InformacionLaboral informacionLaboral = new InformacionLaboral(identificacion);

    if ("Modificar".equals(accion)) {
        // Llama al método estático getInformacionPorIdentificacion de la clase InformacionLaboral
        // para obtener los datos laborales de la persona identificada por 'identificacion'
        Vehiculo tmp = Vehiculo.getVehiculoPorIdentificacion(identificacion);
        // Si la información laboral se encontró (es decir, 'tmp' no es null)
        if (tmp != null) {
            // Asigna los datos obtenidos a la variable 'informacionLaboral'
            // Esto permite trabajar con la información laboral de la persona para modificarla
            vehiculo = tmp;
        }
    }

%>

<%@ include file="menu.jsp" %>

<link rel="stylesheet" href="presentacion/style-FormularioColaboradores.css">
</head>
<body>
    <div class="content">
        <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADOR</h3>
        <form name="formularioInfLaboral" method="post" action="vehiculoActualizar.jsp" onsubmit=" pasarIdentificacion(); enviarDatos(); return false; redirigirDespuesGuardar();">

            <h1>Información del vehículo</h1>
            <table border="1">
                <tr>
                    <td><label for="identificacion">Identificación:</label></td>
                    <td>
                        <input type="text" name="identificacion" id="identificacion" value="<%= identificacion%>" readonly />
                        <input type="hidden" name="identificacionAnterior" value="<%= vehiculo.getIdentificacion()%>">
                        <input type="hidden" name="accion" id="accionHidden" value="<%= accion%>">
                    </td>
                </tr>
                <!-- Contenedor de la tabla de vehículos -->
                <div id="tablaVehiculo" style="display: none;">
                    <table border="1">       

                        <tr>
                            <th><label>Número de la placa</label></th>
                            <td><input type="text" name="numeroPlacaVehiculo" value="<%= vehiculo.getNumeroPlacaVehiculo()%>" size="50" maxlength="50"></td>
                        </tr>
                        <tr>
                            <th><label>Seleccione el tipo de transporte</label></th>
                            <td colspan="2">
                                <%= vehiculo.getTipoVehiculo().getSelectTipoVehiculo("tipoVehiculo")%>
                            </td>
                        </tr>

                        <tr>
                            <th><label>Modelo</label></th>
                            <td><input type="text" name="modeloVehiculo" value="<%= vehiculo.getModeloVehiculo()%>" size="50" maxlength="50"
                                       onkeypress="return soloNumeros(event)" 
                                       onblur="validarNumerico('modeloVehiculo')" placeholder="Campo numérico">
                            </td>
                        </tr>
                        <tr>

                        <tr>
                            <th><label>Línea</label></th>
                            <td><input type="text" name="linea" value="<%= vehiculo.getLinea()%>" size="50" maxlength="50"></td>
                        </tr>
                        <tr>
                            <th><label>Marca</label></th>
                            <td><input type="text" name="marca" value="<%= vehiculo.getMarca()%>" size="50" maxlength="50"></td>
                        </tr>
                        <tr>
                            <th><label>Color</label></th>
                            <td><input type="text" name="color" value="<%= vehiculo.getColor()%>" size="50" maxlength="50"></td>
                        </tr>
                        <tr>
                            <th><label>Cilindraje</label></th>
                            <td><input type="text" name="cilindraje" value="<%= vehiculo.getCilindraje()%>" size="50" maxlength="50" 
                                       onkeypress="return soloNumeros(event)" 
                                       onblur="validarNumerico('cilindraje')" placeholder="Campo numérico" ></td>
                        </tr>
                        <tr>
                            <th><label>Restricciones del conductor</label></th>
                            <td><input type="text" name="restricciones" value="<%= vehiculo.getRestricciones()%>"></td>
                        </tr>
                        <tr>
                            <th><label>Titular de la tarjeta de propiedad</label></th>
                            <td><input type="text" name="titularTrjPro" value="<%= vehiculo.getTitularTrjPro()%>"></td>
                        </tr>
                        <tr>
                            <th><label>Número de la tarjeta de propiedad</label></th>
                            <td><input type="text" name="numLicenciaTransito" value="<%= vehiculo.getNumLicenciaTransito()%>" size="50" maxlength="50" 
                                       onkeypress="return soloNumeros(event)" 
                                       onblur="validarNumerico('numLicenciaTransito')" placeholder="Campo numérico" 
                                       placeholder="Campo numérico" ></td>
                        </tr>
                        <tr>
                            <th><label>Fecha de expedición de la tarjeta de propiedad</label></th>
                            <td><input type="date" name="fechaExpLicenciaTransito" value="<%= vehiculo.getFechaExpLicenciaTransito()%>"></td>
                        </tr>
                        <tr>
                            <th><label>Estado</label></th> 
                            <td colspan="2">
                                <%= vehiculo.getEstadoV().getSelectEstadoV("estado")%>
                            </td>
                        </tr>
                        </tr>
                        <tr>
                            <th><label>Fecha de expedición de la licencia de conducción</label></th>
                            <td><input type="date" name="fechaExpConduccion" value="<%= vehiculo.getFechaExpConduccion()%>"></td>
                        </tr>
                        <tr>
                            <th><label>Fecha de vencimiento de la licencia de conducción</label></th>
                            <td><input type="date" name="fechaVencimiento" value="<%= vehiculo.getFechaVencimiento()%>"></td>
                        </tr>
                        <tr>
                            <th><label>Número de la licencia de conducción</label></th>
                            <td>
                                <input type="text" name="numLicenciaConduccion" 
                                       value="<%= vehiculo.getNumLicenciaConduccion() != null ? vehiculo.getNumLicenciaConduccion() : ""%>" 
                                       size="50" maxlength="50" 
                                       onkeypress="return soloNumeros(event)" 
                                       onblur="validarNumerico('numLicenciaConduccion')"placeholder="Campo numérico">
                            </td>
                        </tr>
                    </table>

                    <div class="botones-container">
                        <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>">
                        <input type="submit" name="accion" value="<%=accion%>">
                        <input type="button" value="Regresar" onClick="window.history.back()" />
                        <input type="button" value="Cancelar" onclick="window.location.href = 'persona.jsp'" />
                    </div>

                    <input type="hidden" id="identificacionHidden" name="identificacionHidden">
                    <button type="button" onclick="irASiguiente()">Siguiente: Información Laboral</button>


                    </form>
                </div>
                </body>
                </html>


                </div>
                <script>
                    function irASiguiente() {
                        var identificacionVisible = document.getElementById("identificacion").value;
                        var accion = document.getElementById("accionHidden").value; // Obtener la acción
                        document.getElementById("identificacionHidden").value = identificacionVisible;

                        // Redirigir a la siguiente página pasando los parámetros correctos
                        window.location.href = "infLaboralFormulario.jsp?identificacion=" + encodeURIComponent(identificacionVisible) + "&accion=" + encodeURIComponent(accion);
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
                            document.getElementsByName("titularTrjPro")[0].value = "";
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

                    function validarNumerico(inputName) {
                        let input = document.getElementsByName(inputName)[0];
                        if (!/^\d*$/.test(input.value)) { // Permite solo números
                            alert("Por favor, ingrese solo números en este campo.");
                            input.value = ""; // Limpia el campo si tiene caracteres no permitidos
                            input.focus();
                        }
                    }

                    function soloNumeros(event) {
                        let codigo = event.which || event.keyCode;
                        return (codigo >= 48 && codigo <= 57); // Permite solo números (0-9)
                    }

                    // Ejecutar la función al cargar la página para mostrar u ocultar correctamente
                    window.onload = function () {
                        mostrarOcultarVehiculo();
                    };
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
                            actualizarHidden();

                            input.removeEventListener("input", actualizarHidden);
                            input.addEventListener("input", actualizarHidden);
                        } else {
                            input.style.display = "none";
                            input.required = false;
                            input.value = "";
                            actualizarHidden();
                        }

                        // También escuchar cambios en el select para actualizar visibilidad y valor
                        select.addEventListener("change", function () {
                            if (select.value === "O") {
                                input.style.display = "inline-block";
                                input.required = true;
                                actualizarHidden();
                                input.addEventListener("input", actualizarHidden);
                            } else {
                                input.style.display = "none";
                                input.required = false;
                                input.value = "";
                                actualizarHidden();
                                input.removeEventListener("input", actualizarHidden);
                            }
                        });
                    }

                    window.addEventListener('DOMContentLoaded', function () {
                        manejarOtro('tipoVehiculo', 'tipoVehiculoOtro', 'tipoVehiculoFinal');
                    });
                </script>