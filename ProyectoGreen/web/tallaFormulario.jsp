<%-- 
    Document   : tallaFormulario
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>

<%@page import="clases.Talla"%>
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
    System.out.println(" Entrando a tallaFormulario.jsp con identificacion=" + identificacion + " y accion=" + accion);
    Talla talla = new Talla(identificacion);

    if (accion == null) {
        accion = "Adicionar"; // Cambiar a Adicionar si aún no se ha guardado o el boton da null
    }

    // Validar que la identificación no sea nula o vacía
    if (identificacion != null && !identificacion.isEmpty()) {
        session.setAttribute("identificacion", identificacion);  // Almacenar en sesión
    }
    // Solo intenta obtener de la BD si la acción es "Modificar"
    // Verifica si la acción a realizar es "Modificar"

    if ("Modificar".equals(accion)) {
        // Llama al método estático getInformacionPorIdentificacion de la clase InformacionLaboral
        // para obtener los datos laborales de la persona identificada por 'identificacion'
        Talla tmp = Talla.getTallaPorIdentificacion(identificacion);
        // Si la información laboral se encontró (es decir, 'tmp' no es null)
        if (tmp != null) {
            // Asigna los datos obtenidos a la variable 'informacionLaboral'
            // Esto permite trabajar con la información laboral de la persona para modificarla
            talla = tmp;
        }
    }

%>


<%@ include file="../menu.jsp" %>

<link rel="stylesheet" href="presentacion/style-FormularioColaboradores.css">
</head>
<body>

    <div class="content">
        <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADOR</h3>
        <form name="tallaFormulario" method="post" action="tallaActualizar.jsp" onsubmit=" pasarIdentificacion(); enviarDatos(); return false; redirigirDespuesGuardar();">

            <h1>Información de tallas</h1>
            <table border="1">
                <tr>
                    <td><label for="identificacion">Identificación:</label></td>
                    <td>
                        <!-- Mostrar identificación recibida en readonly -->
                        <input type="text" name="identificacion" id="identificacion" value="<%= identificacion%>" readonly />

                        <!-- También enviarla como campo oculto para el UPDATE -->
                        <input type="hidden" name="identificacionAnterior" value="<%= talla.getIdentificacion()%>">
                        <!-- Campo oculto para la acción -->-->
                        <input type="hidden" name="accion" id="accionHidden" value="<%=accion%>">
                    </td>                
                </tr>

            </table>

            <table><!-- Formulario para Dotaciones -->           
                <tr>
                    <th>Talla de camisa</th>
                    <td colspan="2">
                        <%= talla.getTallaCamisa().getSelectTipoMedidaTalla("tallaCamisa")%>
                    </td>
                </tr>
                <tr>
                    <th>Talla de chaqueta</th>
                    <td colspan="2">
                        <%= talla.getTallaChaqueta().getSelectTipoMedidaTalla("tallaChaqueta")%>
                    </td>
                </tr>
                <tr>
                    <th>Talla de pantalón</th>
                    <td colspan="2">
                        <%= talla.getTallaPantalon().getSelectTipoMedidaTalla("tallaPantalon")%>
                    </td>
                </tr>
                <tr>
                    <th>Talla de calzado</th>
                    <td colspan="2">
                        <%= talla.getTallaCalzado().getSelectTipoMedidaTalla("tallaZapatos")%>
                    </td>
                </tr>
                <tr>
                    <th>Talla de buzo</th>
                    <td colspan="2">
                        <%= talla.getTallaBuzo().getSelectTipoMedidaTalla("tallaBuzo")%>
                    </td>
                </tr>
                <tr>
                    <th>Talla de overol</th>
                    <td colspan="2">
                        <%= talla.getTallaO().getSelectTipoMedidaTalla("tallaO")%>
                    </td>
                </tr>
                <tr>
                    <th>Talla de guantes</th>
                    <td colspan="2">
                        <%= talla.getTallaGuantes().getSelectTipoMedidaTalla("tallaGuantes")%>
                    </td>
                </tr>
            </table>


            <div class="botones-container">
                <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>">
                <input type="submit" name="accion" value="<%=accion%>">
                <input type="button" value="Cancelar" onClick="window.history.back()">
            </div>

            <% if ("Modificar".equals(accion)) { %>
            <input type="hidden" id="identificacionHidden" name="identificacionHidden">
            <button type="button" onclick="irASiguiente()">Siguiente: Seguridad social</button>
            <% }%>

    </div>


    <script>


        function irASiguiente() {
            var identificacionVisible = document.getElementById("identificacion").value;
            document.getElementById("identificacionHidden").value = identificacionVisible;
            window.location.href = "seguridadSocialFormulario.jsp?identificacion=" + encodeURIComponent(identificacionVisible);
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
            manejarOtro('tallaCamisa', 'tallaCamisaOtro', 'tallaCamisaFinal');
            manejarOtro('tallaChaqueta', 'tallaChaquetaOtro', 'tallaChaquetaFinal');
            manejarOtro('tallaPantalon', 'tallaPantalonOtro', 'tallaPantalonFinal');
            manejarOtro('tallaZapatos', 'tallaZapatosOtro', 'tallaZapatosFinal');
            manejarOtro('tallaBuzo', 'tallaBuzoOtro', 'tallaBuzoFinal');
            manejarOtro('tallaO', 'tallaOOtro', 'tallaOFinal');
            manejarOtro('tallaGuantes', 'tallaGuantesOtro', 'tallaGuantesFinal');
        });



    </script>