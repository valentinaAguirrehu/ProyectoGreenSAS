
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

<%
    String accion = request.getParameter("accion");
    String identificacion = request.getParameter("identificacion");

    System.out.println(" Entrando a seguridadSocialTFormulario.jsp con identificacion=" + identificacion + " y accion=" + accion);
    SeguridadSocial seguridadSocial = new SeguridadSocial(identificacion);

    if (accion == null) {
        accion = "Adicionar";
    }

    if (identificacion != null && !identificacion.isEmpty()) {
        session.setAttribute("identificacion", identificacion);
    }

    if ("Modificar".equals(accion)) {
        SeguridadSocial tmp = SeguridadSocial.getSeguridadSocialPorIdentificacion(identificacion);
        if (tmp != null) {
            seguridadSocial = tmp;
        }
    }
%>

<%@ include file="../menu.jsp" %>


<link rel="stylesheet" href="../presentacion/style-PersonaFormulario.css">
<link rel="stylesheet" href="../presentacion/style-FormularioColaboradores.css">

</head>
<body>
    <div class="content"> 
        <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> TEMPORAL</h3>
        <form name="formulario" method="post" action="seguridadSocialTActualizar.jsp" onsubmit="obtenerDatosHijos()">
            <h1>Seguridad Social</h1>
            <table border="1">
                <tr>
                    <td><label for="identificacion">Identificación:</label></td>
                    <td>
                        <input type="text" name="identificacion" id="identificacion" value="<%= identificacion%>" readonly />
                        <input type="hidden" name="identificacionAnterior" value="<%= seguridadSocial.getIdentificacion()%>" />
                        <input type="hidden" name="accion" id="accionHidden" value="<%= accion%>" />
                    </td>
                </tr>

                <tr>
                    <th>EPS<span style="color: red;">*</span></th>
                    <td colspan="2">
                        <%= seguridadSocial.getEps().getSelectEps("eps")%>
                    </td>
                </tr>
                <!--            <tr>
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
        </tr>        -->
            </table>

            <div class="botones-container">
                <input type="hidden" name="identificacionAnterior" value="<%= identificacion%>" />
                <input type="submit" name="accion" value="<%= accion%>" />
                <!--            <input type="button" value="Cancelar" onClick="window.history.back()" /> este boton envia al anterior formulario-->
                <input type="button" value="Regresar" onClick="window.history.back()" />
                <input type="button" value="Cancelar" onclick="window.location.href = 'temporales.jsp'" />

            </div>

            <input type="hidden" id="identificacionHidden" name="identificacionHidden" />
            <button type="button" onclick="irASiguiente()">Siguiente: Referencias familiares</button>
        </form>
    </div>

    <script>
        function irASiguiente() {
            var identificacionVisible = document.getElementById("identificacion").value;
            var accion = document.getElementById("accionHidden").value;
            document.getElementById("identificacionHidden").value = identificacionVisible;

            window.location.href = "referenciaTFormulario.jsp?identificacion=" + encodeURIComponent(identificacionVisible) + "&accion=" + encodeURIComponent(accion);
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
            manejarOtro('eps', 'epsOtro', 'epsFinal');
            manejarOtro('fondoCesantias', 'fondoCesantiasOtro', 'fondoCesantiasFinal');
            manejarOtro('fondoPensiones', 'fondoPensionesOtro', 'fondoPensionesFinal');
            manejarOtro('arl', 'arlOtro', 'arlFinal');
        });
    </script>
</body>
</html>
