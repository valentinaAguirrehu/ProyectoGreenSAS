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
    <table class="table" border="1">
        <tr>
            <th>Cédula</th>
            <td>
                <select id="identificacion" class="recuadro" name="identificacion" required>
                    <option value="">Seleccione una persona</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>Nombres y apellidos</th>
            <td><span id="nombre"></span></td>
        </tr>
        <tr>
            <th>Cargo</th>
            <td><span id="cargo"></span></td>
        </tr>
        <tr>
            <th>Establecimiento</th>
            <td><span id="establecimiento"></span></td>
        </tr>
        <tr>
            <th>Fecha de ingreso</th>
            <td><span id="fechaIngreso"></span></td>
        </tr>
        <tr>
            <th>Fecha de retiro</th>
            <td><input class="recuadro" type="date" name="fechaRetiro" required></td>
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
    <input type="hidden" name="id" value="<%=retirado != null ? retirado.getId() : ""%>">
    <input class="submit" type="submit" name="accion" value="<%=accion%>">
    <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
</form>

<script>
 var personas = <%= Persona.getListaEnArregloJS("tipo='C' OR tipo='T'", null) %>;

    function cargarCedulas() {
        var select = document.getElementById("identificacion");
        select.innerHTML = "<option value=''>Seleccione una persona</option>";

        personas.forEach(function(persona) {
            var opcion = document.createElement("option");
            opcion.value = persona[0]; // Cédula
            opcion.textContent = persona[0] + " - " + persona[1]; // Cédula - Nombre
            select.appendChild(opcion);
        });
    }

    window.onload = cargarCedulas;

    function buscarPersona(identificacion, index) {
        for (var i = 0; i < personas.length; i++) {
            if (personas[i][index] === identificacion) {
                return i;
            }
        }
        return -1;
    }

    window.onload = cargarCedulas;
</script>