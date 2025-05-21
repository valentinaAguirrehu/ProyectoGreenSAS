
<%-- 
    Document   : seguridadSocialTFormulario
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>

<%@page import="clases.SeguridadSocial"%>
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
    System.out.println(" Entrando a seguridadSocialFormulario.jsp con identificacion=" + identificacion + " y accion=" + accion);
    SeguridadSocial seguridadSocial = new SeguridadSocial(identificacion);

    if (accion == null) {
        accion = "Adicionar"; // Cambiar a Adicionar si aún no se ha guardado o el boton da null
    }

    // Validar que la identificación no sea nula o vacía
    if (identificacion != null && !identificacion.isEmpty()) {
        session.setAttribute("identificacion", identificacion);  // Almacenar en sesión
    }

    if ("Modificar".equals(accion)) {
        // Llama al método estático getInformacionPorIdentificacion de la clase InformacionLaboral
        // para obtener los datos laborales de la persona identificada por 'identificacion'
        SeguridadSocial tmp = SeguridadSocial.getSeguridadSocialPorIdentificacion(identificacion);
        // Si la información laboral se encontró (es decir, 'tmp' no es null)
        if (tmp != null) {
            // Asigna los datos obtenidos a la variable 'informacionLaboral'
            // Esto permite trabajar con la información laboral de la persona para modificarla
            seguridadSocial = tmp;
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
        <form name="formulario" method="post" action="seguridadSocialTActualizar.jsp" onsubmit="obtenerDatosHijos()">
            <h1>Seguridad Social</h1>
            <table border="1">

                <tr>
                    <td><label for="identificacion">Identificación:</label></td>
                    <td>
                        <!-- Mostrar identificación recibida en readonly -->
                        <input type="text" name="identificacion" id="identificacion" value="<%= identificacion%>" readonly />

                        <!-- También enviarla como campo oculto para el UPDATE -->
                        <input type="hidden" name="identificacionAnterior" value="<%= seguridadSocial.getIdentificacion()%>">

                        <!-- Campo oculto para la acción -->
                        <input type="hidden" name="accion" id="accionHidden" value="<%=accion%>">
                    </td>
                </tr>
                <tr>
                    <th>EPS<span style="color: red;">*</span></th>
                    <td colspan="2">
                        <%= seguridadSocial.getEps().getSelectEps("eps")%>
                    </td>
                </tr>
                <th>Fondo Cesantias<span style="color: red;">*</span></th>
                <td colspan="2">
                    <%= seguridadSocial.getFondoCesantias().getSelectFondoCesantias("fondoCesantias")%>
                </td>
                </tr>                
                <tr>
                    <th>Fondo de pensiones<span style="color: red;">*</span></th>
                    <td colspan="2">
                        <%= seguridadSocial.getFondoPensiones().getSelectFondoPensiones("fondoPensiones")%>
                    </td>

                </tr>                        
                <tr>
                    <th>Arl<span style="color: red;">*</span></th>
                    <td colspan="2">
                        <%= seguridadSocial.getArl().getSelectArl("arl")%>
                    </td>
                </tr>        
            </table>

            <div class="botones-container">
                <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>">
                <input type="submit" name="accion" value="<%=accion%>">
                <input type="button" value="Cancelar" onClick="window.history.back()">
            </div>

            <input type="hidden" id="identificacionHidden" name="identificacionHidden">
            <button type="button" onclick="irASiguiente()">Siguiente: Referencias familiares</button>


        </form>
    </div>
</body>
</html>


<script>

    function irASiguiente() {
        var identificacionVisible = document.getElementById("identificacion").value;
        var accion = document.getElementById("accionHidden").value; // Obtener la acción
        document.getElementById("identificacionHidden").value = identificacionVisible;

        // Redirigir a la siguiente página pasando los parámetros correctos
        window.location.href = "referenciaFormulario.jsp?identificacion=" + encodeURIComponent(identificacionVisible) + "&accion=" + encodeURIComponent(accion);
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

            // Asegúrate de no duplicar el listener
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
        manejarOtro('eps', 'epsOtro', 'epsFinal');
//            manejarOtro('tipoVivienda', 'tipoViviendaOtro', 'tipoViviendaFinal');
    });
//
//        window.addEventListener('DOMContentLoaded', function () {
//        manejarOtro('eps', 'epsOtro', 'epsFinal');
//        manejarOtro('fondoCesantias', 'fondoCesantiasOtro', 'fondoCesantiasFinal');
//        manejarOtro('fondoPensiones', 'fondoPensionesOtro', 'fondoPensionesFinal');
//        manejarOtro('arl', 'arlOtro', 'arlFinal');
//    });
</script>
