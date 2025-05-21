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

<%@ include file="menu.jsp" %>

<head>
    <link rel="stylesheet" href="presentacion/style-FormularioColaboradores.css">
</head>
<body>
    <div class="content"> 
        <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADOR</h3>
        <form name="formulario" method="post" action="referenciaActualizar.jsp" onsubmit="obtenerDatosHijos()">
            <h1>Seguridad Social</h1>
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
                <input type="button" value="Cancelar" onClick="window.history.back()">
            </div>

            <input type="hidden" id="identificacionHidden" name="identificacionHidden">
            <button type="button" onclick="irASiguiente()">Siguiente: Información Vehiculo</button>
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
        window.location.href = "vehiculoFormulario.jsp?identificacion=" + encodeURIComponent(identificacionVisible) + "&accion=" + encodeURIComponent(accion);
    }

    let referenciaCount = 0;  // Inicializamos la variable fuera de cualquier función para que conserve su valor.

    function agregarReferencia() {
        if (referenciaCount < 4) {  // Limitar el número de contactos a 4
            referenciaCount++;
            document.querySelectorAll(".referencia" + referenciaCount).forEach(el => el.style.display = "table-row");

            // Deshabilitar el botón si se alcanzan 4 referencias
            if (referenciaCount >= 4) {
                document.querySelector('.submit').disabled = true;
            }
        } else {
            alert("Se ha alcanzado el límite máximo de contactos.");
        }
    }

    function eliminarReferencia(ref) {
        document.querySelectorAll(".referencia" + ref).forEach(el => el.style.display = "none");
        if (referenciaCount === ref) {
            referenciaCount--;
        }

        // Rehabilitar el botón si se eliminan contactos
        if (referenciaCount < 4) {
            document.querySelector('.submit').disabled = false;
        }
    }


</script>


