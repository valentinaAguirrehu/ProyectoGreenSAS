<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="clases.Retirados"%>
<%@ page import="clases.Persona"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    Retirados retirado = new Retirados();
    Persona persona = new Persona();

    if ("Modificar".equals(accion)) {
        retirado = new Retirados(id);
        persona = new Persona(id);
    }

%>

<h3><%=accion.toUpperCase()%> RETIRADO</h3>
<form name="formulario" method="post" action="retiradosActualizar.jsp">
    <link rel="stylesheet" href="presentacion/style-Retirados.css">
    <table class="table" border="1">
        <tr>
            <th>Identificación</th>
            <td>
                <input type="text" id="identificacion" class="recuadro" name="identificacion" value="<%=persona.getIdentificacion()%>" required>
                <div id="sugerencias" class="autocomplete-suggestions"></div>
            </td>
        </tr>
        <tr>
            <th>Nombres y apellidos</th>
            <td><span id="nombre"><%=persona.getNombres()%></span></td>
        </tr>
        <tr>
            <th>Cargo</th>
            <td><span id="cargo"><%=persona.getIdCargo()%></span></td>
        </tr>
        <tr>
            <th>Establecimiento</th>
            <td><span id="establecimiento"><%=persona.getEstablecimiento()%></span></td>
        </tr>
        <tr>
            <th>Fecha de ingreso</th>
            <td><span id="fechaIngreso"><%=persona.getFechaIngreso()%></span></td>
        </tr>

        <tr>
            <th>Fecha de retiro</th>
            <td><input class="recuadro" type="date" name="fechaRetiro" value="<%=persona.getFechaRetiro()%>" required></td>
        </tr>
        <tr>
            <th>N° de caja</th>
            <td><input class="recuadro" type="text" name="numCaja" value="<%=retirado.getNumCaja()%>" required></td>
        </tr>
        <tr>
            <th>N° de carpeta</th>
            <td><input class="recuadro" type="text" name="numCarpeta" value="<%=retirado.getNumCarpeta()%>" required></td>
        </tr>
        <tr>
            <th>Observaciones</th>
            <td colspan="3"><textarea class="recuadro" name="observaciones" rows="4" cols="50"><%=retirado.getObservaciones()%></textarea></td>
        </tr>
    </table>
    <input type="hidden" name="identificacion" id="identificacionHidden" value="<%=persona.getIdentificacion()%>">
    <input type="hidden" name="id" value="<%= (id != null) ? id : (retirado != null ? retirado.getId() : "")%>">
    <input class="submit" type="submit" name="accion" value="<%=accion%>">
    <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
</form>

<script>
    
    document.addEventListener("DOMContentLoaded", function () {
        var inputIdentificacion = document.getElementById("identificacion");
        var sugerenciasDiv = document.getElementById("sugerencias");
        var identificacionHidden = document.getElementById("identificacionHidden");

        var nombreSpan = document.getElementById("nombre");
        var cargoSpan = document.getElementById("cargo");
        var establecimientoSpan = document.getElementById("establecimiento");
        var fechaIngresoSpan = document.getElementById("fechaIngreso");

        // SELECCIONAR LA CÉDULA
        var personas = <%= Persona.getListaEnArregloJS("tipo='C' OR tipo='T' OR tipo='A'", null) %>;

        inputIdentificacion.addEventListener("input", function () {
            var valor = this.value.trim();
            sugerenciasDiv.innerHTML = "";
            if (valor.length === 0)
                return;

            var coincidencias = personas.filter(p => p[0].startsWith(valor));

            coincidencias.forEach(function(persona) {
                var opcion = document.createElement("div");
                opcion.textContent = persona[0] + " - " + persona[1];
                opcion.classList.add("autocomplete-item");

                opcion.addEventListener("click", function () {
                    inputIdentificacion.value = persona[0];
                    identificacionHidden.value = persona[0];  // Actualiza el campo oculto
                    sugerenciasDiv.innerHTML = "";

                    nombreSpan.textContent = persona[1] + " " + persona[2];
                    cargoSpan.textContent = persona[3];
                    establecimientoSpan.textContent = persona[4];
                    fechaIngresoSpan.textContent = persona[5];
                });

                sugerenciasDiv.appendChild(opcion);
            });
        });

        document.addEventListener("click", function (e) {
            if (!sugerenciasDiv.contains(e.target) && e.target !== inputIdentificacion) {
                sugerenciasDiv.innerHTML = "";
            }
        });
    });
</script>
