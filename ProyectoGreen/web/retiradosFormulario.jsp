<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="clases.Retirados" %>
<%@ page import="clases.Persona" %>
<%
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    Retirados retirado = null;
    Persona persona = null;
    
    if ("Modificar".equals(accion) && id != null && !id.isEmpty()) {
        retirado = new Retirados(id);
        persona = new Persona(id);
    } else {
        retirado = new Retirados();
        persona = new Persona();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title><%=accion.toUpperCase()%> RETIRADO</title>
    <link rel="stylesheet" href="presentacion/style-Retirado.css">
</head>
<body>
    <h3 class="titulo"><%=accion.toUpperCase()%> RETIRADO</h3>
    
    <form name="formulario" method="post" action="retiradosActualizar.jsp">
        <table class="table" border="1">
        <tr>
            <th>Cédula</th>
            <td><input class="recuadro" type="text" name="cedula" value="<%=persona != null ? persona.getIdentificacion() : ""%>" required></td>
        </tr>
        <tr>
            <th>Nombres y Apellidos</th>
            <td><input class="recuadro" type="text" name="nombres" value="<%=persona != null ? persona.getNombres() : ""%>" required></td>
        </tr>
        <tr>
            <th>Cargo</th>
            <td><input class="recuadro" type="text" name="cargo" value="<%=retirado != null ? retirado.getNombreCargo() : ""%>" required></td>
        </tr>
        <tr>
            <th>Establecimiento</th>
            <td><input class="recuadro" type="text" name="establecimiento" value="<%=persona != null ? persona.getEstablecimiento() : ""%>" required></td>
        </tr>
        <tr>
            <th>Fecha Ingreso</th>
            <td><input class="recuadro" type="date" name="fechaIngreso" value="<%=persona != null ? persona.getFechaIngreso() : ""%>" required></td>
        </tr>
        <tr>
            <th>Fecha Retiro</th>
            <td><input class="recuadro" type="date" name="fechaRetiro" value="<%=persona != null ? persona.getFechaRetiro() : ""%>" required></td>
        </tr>
        <tr>
            <th>N° de Caja</th>
            <td><input class="recuadro" type="text" name="numCaja" value="<%=retirado != null ? retirado.getNumCaja() : ""%>" required></td>
        </tr>
        <tr>
            <th>N° de Carpeta</th>
            <td><input class="recuadro" type="text" name="numCarpeta" value="<%=retirado != null ? retirado.getNumCarpeta() : ""%>" required></td>
        </tr>
        <tr>
            <th>Observaciones</th>
            <td colspan="3"><textarea class="recuadro" name="observaciones" rows="4" cols="50"><%=retirado != null ? retirado.getObservaciones() : ""%></textarea></td>
        </tr>
    </table>
        <input type="hidden" name="id" value="<%=retirado != null ? retirado.getId() : ""%>">
        <input class="submit" type="submit" name="accion" value="<%=accion%>">
        <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
    </form>
</body>
</html>
