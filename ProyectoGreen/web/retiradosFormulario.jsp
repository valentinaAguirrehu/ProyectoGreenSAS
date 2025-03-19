<%-- 
    Document   : retiradosFormulario
    Created on : 17/03/2025, 04:47:29 PM
    Author     : VALEN
--%>

<%@ page import="clases.Retirados"%>
<%@ page import="clases.Persona"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    Retirados retirado = new Retirados();
    Persona persona = new Persona();
    
    if (accion.equals("Modificar")) {
        retirado = new Retirados(id);
        persona = new Persona(id);
    }
%>

    <h3><%=accion.toUpperCase()%> RETIRADO</h3>
   <form name="formulario" method="post" action="retiradosActualizar.jsp">
    <table class="table" border="1">
        <tr>
            <th>Cédula</th>
            <td><input class="recuadro" type="text" name="cedula" value="<%=persona.getIdentificacion()%>" required></td>
        </tr>
        <tr>
            <th>Nombres y Apellidos</th>
            <td><input class="recuadro" type="text" name="nombres" value="<%=persona.getNombres()%>" required></td>
        </tr>
        <tr>
            <th>Cargo</th>
            <td><input class="recuadro" type="text" name="cargo" value="<%=persona.getIdCargo()%>" required></td>
        </tr>
        <tr>
            <th>Establecimiento</th>
            <td><input class="recuadro" type="text" name="establecimiento" value="<%=persona.getEstablecimiento()%>" required></td>
        </tr>
        <tr>
            <th>Fecha Ingreso</th>
            <td><input class="recuadro" type="date" name="fechaIngreso" value="<%= persona.getFechaIngreso()%>" required></td>
        </tr>
        <tr>
            <th>Fecha Retiro</th>
            <td><input class="recuadro" type="date" name="fechaRetiro" value="<%= persona.getFechaRetiro()%>" required></td>
        </tr>
        <tr>
            <th>N° de Caja</th>
            <td><input class="recuadro" type="text" name="numCaja" value="<%=retirado.getNumCaja()%>" required></td>
        </tr>
        <tr>
            <th>N° de Carpeta</th>
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

</body>
</html>
