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

<link rel="stylesheet" href="../presentacion/style-PersonaFormulario.css">
<link rel="stylesheet" href="../presentacion/style-FormularioColaboradores.css">

<%
    String accion = request.getParameter("accion");
    String identificacion = request.getParameter("identificacion");
    System.out.println("Entrando a tallaTFormulario.jsp con identificacion=" + identificacion + " y accion=" + accion);

    if (accion == null) {
        accion = "Adicionar";
    }

    if (identificacion != null && !identificacion.isEmpty()) {
        session.setAttribute("identificacion", identificacion);
    }

    Talla talla = new Talla(identificacion);

    if ("Modificar".equals(accion)) {
        Talla tmp = Talla.getTallaPorIdentificacion(identificacion);
        if (tmp != null) {
            talla = tmp;
        }
    }
%>

<%@ include file="../menu.jsp" %>

<body>
    <div class="content">
        <h3><%= accion.toUpperCase() %> TEMPORAL</h3>

        <form name="tallaFormulario" method="post" action="tallaTActualizar.jsp" onsubmit="actualizarOcultos();">
            <h1>Información de Tallas</h1>
            <table border="1">
                <tr>
                    <td><label for="identificacion">Identificación:</label></td>
                    <td>
                        <input type="text" name="identificacion" id="identificacion" value="<%= identificacion %>" readonly />
                        <input type="hidden" name="identificacionAnterior" value="<%= talla.getIdentificacion() %>">
                        <input type="hidden" name="accion" id="accionHidden" value="<%= accion %>">
                    </td>
                </tr>
            </table>

            <table>
                <tr>
                    <th>Talla de camisa</th>
                    <td>
                        <%= talla.getTallaCamisa().getSelectTipoMedidaTalla("tallaCamisa") %>
                        <input type="text" id="tallaCamisaOtro" style="display:none;" placeholder="Especifique otra talla">
                        <input type="hidden" name="tallaCamisaFinal" id="tallaCamisaFinal">
                    </td>
                </tr>
                <tr>
                    <th>Talla de chaqueta</th>
                    <td>
                        <%= talla.getTallaChaqueta().getSelectTipoMedidaTalla("tallaChaqueta") %>
                        <input type="text" id="tallaChaquetaOtro" style="display:none;" placeholder="Especifique otra talla">
                        <input type="hidden" name="tallaChaquetaFinal" id="tallaChaquetaFinal">
                    </td>
                </tr>
                <tr>
                    <th>Talla de pantalón</th>
                    <td>
                        <%= talla.getTallaPantalon().getSelectTipoMedidaTalla("tallaPantalon") %>
                        <input type="text" id="tallaPantalonOtro" style="display:none;" placeholder="Especifique otra talla">
                        <input type="hidden" name="tallaPantalonFinal" id="tallaPantalonFinal">
                    </td>
                </tr>
                <tr>
                    <th>Talla de calzado</th>
                    <td>
                        <%= talla.getTallaCalzado().getSelectTipoMedidaTalla("tallaCalzado") %>
                        <input type="text" id="tallaCalzadoOtro" style="display:none;" placeholder="Especifique otra talla">
                        <input type="hidden" name="tallaCalzadoFinal" id="tallaCalzadoFinal">
                    </td>
                </tr>
                <tr>
                    <th>Talla de buzo</th>
                    <td>
                        <%= talla.getTallaBuzo().getSelectTipoMedidaTalla("tallaBuzo") %>
                        <input type="text" id="tallaBuzoOtro" style="display:none;" placeholder="Especifique otra talla">
                        <input type="hidden" name="tallaBuzoFinal" id="tallaBuzoFinal">
                    </td>
                </tr>
                <tr>
                    <th>Talla de overol</th>
                    <td>
                        <%= talla.getTallaO().getSelectTipoMedidaTalla("tallaO") %>
                        <input type="text" id="tallaOOtro" style="display:none;" placeholder="Especifique otra talla">
                        <input type="hidden" name="tallaOFinal" id="tallaOFinal">
                    </td>
                </tr>
                <tr>
                    <th>Talla de guantes</th>
                    <td>
                        <%= talla.getTallaGuantes().getSelectTipoMedidaTalla("tallaGuantes") %>
                        <input type="text" id="tallaGuantesOtro" style="display:none;" placeholder="Especifique otra talla">
                        <input type="hidden" name="tallaGuantesFinal" id="tallaGuantesFinal">
                    </td>
                </tr>
            </table>

            <div class="botones-container">
                <input type="submit" name="accion" value="<%= accion %>">
                <input type="button" value="Regresar" onClick="window.history.back()" />
                <input type="button" value="Cancelar" onclick="window.location.href = 'temporales.jsp'" />
            </div>

            <% if ("Modificar".equals(accion)) { %>
            <input type="hidden" id="identificacionHidden" name="identificacionHidden">
            <!--<button type="button" onclick="irASiguiente()">Siguiente: Seguridad social</button>-->
            <% } %>
        </form>
    </div>

    <script>
        function manejarOtro(selectId, inputId, hiddenId) {
            var select = document.getElementById(selectId);
            var input = document.getElementById(inputId);
            var hidden = document.getElementById(hiddenId);

            function actualizar() {
                if (select.value === "O") {
                    input.style.display = "inline-block";
                    hidden.value = input.value;
                    input.required = true;
                } else {
                    input.style.display = "none";
                    hidden.value = select.value;
                    input.required = false;
                    input.value = "";
                }
            }

            select.addEventListener("change", actualizar);
            input.addEventListener("input", function () {
                if (select.value === "O")
                    hidden.value = input.value;
            });

            actualizar(); // Ejecutar al cargar la página
        }

        function actualizarOcultos() {
            const tallas = ["tallaCamisa", "tallaChaqueta", "tallaPantalon", "tallaCalzado", "tallaBuzo", "tallaO", "tallaGuantes"];
            tallas.forEach(function (nombre) {
                var select = document.getElementById(nombre);
                var input = document.getElementById(nombre + "Otro");
                var hidden = document.getElementById(nombre + "Final");
                if (select.value === "O") {
                    hidden.value = input.value;
                } else {
                    hidden.value = select.value;
                }
            });
        }

        function irASiguiente() {
            var id = document.getElementById("identificacion").value;
            window.location.href = "seguridadSocialTFormulario.jsp?identificacion=" + encodeURIComponent(id);
        }

        window.addEventListener("DOMContentLoaded", function () {
            manejarOtro("tallaCamisa", "tallaCamisaOtro", "tallaCamisaFinal");
            manejarOtro("tallaChaqueta", "tallaChaquetaOtro", "tallaChaquetaFinal");
            manejarOtro("tallaPantalon", "tallaPantalonOtro", "tallaPantalonFinal");
            manejarOtro("tallaCalzado", "tallaCalzadoOtro", "tallaCalzadoFinal");
            manejarOtro("tallaBuzo", "tallaBuzoOtro", "tallaBuzoFinal");
            manejarOtro("tallaO", "tallaOOtro", "tallaOFinal");
            manejarOtro("tallaGuantes", "tallaGuantesOtro", "tallaGuantesFinal");
        });
    </script>
</body>
