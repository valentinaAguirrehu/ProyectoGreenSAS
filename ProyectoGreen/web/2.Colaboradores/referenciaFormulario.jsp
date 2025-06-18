<%-- 
    Document   : referenciaFormulario
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.Vehiculo"%>
<%@page import="clases.Referencia"%>
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
    System.out.println(" Entrando a referenciaFormulario.jsp con identificacion=" + identificacion + " y accion=" + accion);
    Referencia referencia = new Referencia(identificacion);

    if (accion == null || identificacion == null) {
        // Maneja el caso donde no se pase un parámetro necesario
        response.sendRedirect("error.jsp");
        return;
//      accion = "Adicionar"; // Cambiar a Adicionar si aún no se ha guardado o el boton da null

    }

    if ("Modificar".equals(accion)) {
        // Llama al método estático getInformacionPorIdentificacion de la clase InformacionLaboral
        // para obtener los datos laborales de la persona identificada por 'identificacion'
        Referencia tmp = Referencia.getReferenciaPorIdentificacion(identificacion);
        // Si la información laboral se encontró (es decir, 'tmp' no es null)
        if (tmp != null) {
            // Asigna los datos obtenidos a la variable 'informacionLaboral'
            // Esto permite trabajar con la información laboral de la persona para modificarla
            referencia = tmp;
        }
    }

%>
<%    int referenciasConDatos = 0;
    if (referencia.getTerceraRefNombre() != null && !referencia.getTerceraRefNombre().trim().isEmpty()) {
        referenciasConDatos++;
    }
    if (referencia.getCuartaRefNombre() != null && !referencia.getCuartaRefNombre().trim().isEmpty()) {
        referenciasConDatos++;
    }
%>


<%@ include file="../menu.jsp" %>

<link rel="stylesheet" href="../presentacion/style-FormularioColaboradores.css">
</head>
<body>
    <div class="content"> 
        <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADOR</h3>
        <form name="formulario" method="post" action="referenciaActualizar.jsp" onsubmit="obtenerDatosHijos()">
            <h1>Referencias familiares</h1>
            <table border="1">

                <tr>
                    <td><label for="identificacion">Identificación:</label></td>
                    <td>
                        <!-- Mostrar identificación recibida en readonly -->
                        <input type="text" name="identificacion" id="identificacion" value="<%= identificacion%>" readonly />

                        <!-- También enviarla como campo oculto para el UPDATE -->
                        <input type="hidden" name="identificacionAnterior" value="<%= referencia.getIdentificacion()%>">

                        <!-- Campo oculto para la acción -->
                        <input type="hidden" name="accion" id="accionHidden" value="<%=accion%>">
                    </td>
                </tr>

                <tr><th colspan="2">Primer contacto<span style="color: red;">*</span></th></tr>
                <tr>
                    <th>Nombre<span style="color: red;">*</span></th>
                    <td><input type="text" name="primerRefNombre" value="<%= referencia.getPrimerRefNombre() != null ? referencia.getPrimerRefNombre() : ""%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>Parentesco<span style="color: red;">*</span></th>
                    <td><input type="text" name="primerRefParentezco" value="<%= referencia.getPrimerRefParentezco() != null ? referencia.getPrimerRefParentezco() : ""%>" size="50" maxlength="50" required></td>
                </tr>
                <tr>
                    <th>Celular<span style="color: red;">*</span></th>
                    <td><input type="text" name="primerRefCelular" value="<%= referencia.getPrimerRefCelular() != null ? referencia.getPrimerRefCelular() : ""%>" size="50" maxlength="10" pattern="\d{10}" title="Ingrese exactamente 10 números" 
                               onkeypress="return soloNumeros(event)" onblur="validarNumerico('celular')" placeholder="Campo numérico" required></td>
                </tr>

                <tr><th colspan="2">Segundo contacto</th></tr>
                <tr>
                    <th>Nombre</th>
                    <td><input type="text" name="segundaRefNombre" value="<%= referencia.getSegundaRefNombre() != null ? referencia.getSegundaRefNombre() : ""%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <th>Parentesco</th>
                    <td><input type="text" name="segundaRefParentezco" value="<%= referencia.getSegundaRefParentezco() != null ? referencia.getSegundaRefParentezco() : ""%>" size="50" maxlength="50"></td>
                </tr>
                <tr>
                    <th>Celular</th>
                    <td><input type="text" name="segundaRefCelular" value="<%= referencia.getSegundaRefCelular() != null ? referencia.getSegundaRefCelular() : ""%>" size="50" maxlength="10" pattern="\d{10}" title="Ingrese exactamente 10 números"
                               onkeypress="return soloNumeros(event)" onblur="validarNumerico('celular')" placeholder="Campo numérico"></td>
                </tr>

            </table>

            <div class="botones-container">
                <button class="submit" type="button" onclick="agregarReferencia()">Añadir otro contacto</button>
            </div>

            <table border="1">
                <!-- Oculto -->
                <tr class="referencia1" style="display: none;"><th colspan="2">Tercer contacto</th></tr>
                <tr class="referencia1" style="display: none;">
                    <th>Nombre</th>
                    <td><input type="text" name="terceraRefNombre" value="<%= referencia.getTerceraRefNombre() != null ? referencia.getTerceraRefNombre() : ""%>" size="50" maxlength="50">
                        <button type="button" onclick="eliminarReferencia(1)">Eliminar</button>
                    </td>
                </tr>
                <tr class="referencia1" style="display: none;">
                    <th>Parentesco</th>
                    <td><input type="text" name="terceraRefParentezco" value="<%= referencia.getTerceraRefParentezco() != null ? referencia.getTerceraRefParentezco() : ""%>" size="50" maxlength="50"></td>
                </tr>
                <tr class="referencia1" style="display: none;">
                    <th>Celular</th>
                    <td><input type="text" name="terceraRefCelular" value="<%= referencia.getTerceraRefCelular() != null ? referencia.getTerceraRefCelular() : ""%>" size="50" maxlength="10" pattern="\d{10}" title="Ingrese exactamente 10 números"
                               onkeypress="return soloNumeros(event)" onblur="validarNumerico('celular')" placeholder="Campo numérico"></td>
                </tr>

                <!-- Oculto -->
                <tr class="referencia2" style="display: none;"><th colspan="2">Cuarto contacto</th></tr>
                <tr class="referencia2" style="display: none;">
                    <th>Nombre</th>
                    <td><input type="text" name="cuartaRefNombre" value="<%= referencia.getCuartaRefNombre() != null ? referencia.getCuartaRefNombre() : ""%>" size="50" maxlength="50">
                        <button type="button" onclick="eliminarReferencia(2)">Eliminar</button>
                    </td>
                </tr>
                <tr class="referencia2" style="display: none;">
                    <th>Parentesco</th>
                    <td><input type="text" name="cuartaRefParentezco" value="<%= referencia.getCuartaRefParentezco() != null ? referencia.getCuartaRefParentezco() : ""%>" size="50" maxlength="50"></td>
                </tr>
                <tr class="referencia2" style="display: none;">
                    <th>Celular</th>
                    <td><input type="text" name="cuartaRefCelular" value="<%= referencia.getCuartaRefCelular() != null ? referencia.getCuartaRefCelular() : ""%>" size="50" maxlength="10" pattern="\d{10}" title="Ingrese exactamente 10 números"
                               onkeypress="return soloNumeros(event)" onblur="validarNumerico('celular')" placeholder="Campo numérico"></td>
                </tr>
            </table>

            <div class="botones-container">
                <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>">
                <input type="submit" name="accion" value="<%=accion%>">
                <input type="button" value="Regresar" onClick="window.history.back()" />
                <input type="button" value="Cancelar" onclick="window.location.href = 'persona.jsp'" />
            </div>

            <input type="hidden" id="identificacionHidden" name="identificacionHidden">
            <button type="button" onclick="irASiguiente()">Siguiente: Información Vehiculo</button>
        </form>
</body>
</html>
</div>
<script>
    function irASiguiente() {
        var identificacionVisible = document.getElementById("identificacion").value;
        var accion = document.getElementById("accionHidden").value; // Obtener la acción
        document.getElementById("identificacionHidden").value = identificacionVisible;

        // Redirigir a la siguiente página pasando los parámetros correctos
        window.location.href = "vehiculoFormulario.jsp?identificacion=" + encodeURIComponent(identificacionVisible) + "&accion=" + encodeURIComponent(accion);
    }

    let referenciaCount = <%= referenciasConDatos%>;

    // Mostrar las referencias con datos al cargar la página
    window.onload = function () {
        for (let i = 1; i <= referenciaCount; i++) {
            document.querySelectorAll(".referencia" + i).forEach(el => el.style.display = "table-row");
        }
        // Si ya hay 4 referencias, deshabilita el botón de añadir
        if (referenciaCount >= 4) {
            document.querySelector('.submit').disabled = true;
        }
    };

    function agregarReferencia() {
        // Obtener los valores del primer y segundo contacto
        const p1Nombre = document.querySelector("input[name='primerRefNombre']").value.trim();
        const p1Parentesco = document.querySelector("input[name='primerRefParentezco']").value.trim();
        const p1Celular = document.querySelector("input[name='primerRefCelular']").value.trim();

        const p2Nombre = document.querySelector("input[name='segundaRefNombre']").value.trim();
        const p2Parentesco = document.querySelector("input[name='segundaRefParentezco']").value.trim();
        const p2Celular = document.querySelector("input[name='segundaRefCelular']").value.trim();

        // Validar que el primer y segundo contacto estén llenos
        const primerCompleto = p1Nombre !== "" && p1Parentesco !== "" && p1Celular.length === 10;
        const segundoCompleto = p2Nombre !== "" && p2Parentesco !== "" && p2Celular.length === 10;

        if (!primerCompleto || !segundoCompleto) {
            alert("Por favor diligencia completamente el primer y segundo contacto antes de añadir más.");
            return;
        }

        // Mostrar progresivamente el tercer y cuarto contacto
        if (referenciaCount < 2) {
            referenciaCount++;
            document.querySelectorAll(".referencia" + referenciaCount).forEach(el => el.style.display = "table-row");
        }

        // Ocultar el botón si ya se añadieron ambos adicionales
        if (referenciaCount >= 2) {
            document.querySelector("button[onclick='agregarReferencia()']").style.display = "none";
        }
    }

    function eliminarReferencia(ref) {
        document.querySelectorAll(".referencia" + ref).forEach(el => {
            el.style.display = "none";
            el.querySelectorAll("input").forEach(input => input.value = ""); // Limpia los campos
        });

        if (referenciaCount === ref)
            referenciaCount--;

        if (referenciaCount < 2) {
            document.querySelector("button[onclick='agregarReferencia()']").style.display = "inline-block";
        }
    }



</script>

