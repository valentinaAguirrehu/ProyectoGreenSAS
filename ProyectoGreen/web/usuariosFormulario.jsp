<%-- 
    Document   : usuariosFormulario
    Created on : 10 mar 2025, 14:52:32
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String accion = request.getParameter("accion");
    String identificacion = request.getParameter("identificacion");
    Administrador usuario = new Administrador();
    if (accion.equals("Modificar")) {
        usuario = new Administrador(identificacion);
    }
%>

<h3><%=accion.toUpperCase()%> USUARIO</h3>
<form name="formulario" method="post" action="usuariosActualizar.jsp">
    <table class="table" border="1">
        <tr>
            <th>Identificación</th>
            <td><input class="recuadro" type="text" name="identificacion" maxlength="12" value="<%=usuario.getIdentificacion()%>" size="50" required></td>
        </tr>
        <tr>
            <th>Nombres</th>
            <td><input class="recuadro" type="text" name="nombres" value="<%=usuario.getNombres()%>" size="50" maxlength="40" required></td>
        </tr>
        <tr>
            <th>Celular</th>
            <td><input class="recuadro" type="tel" name="celular" value="<%=usuario.getCelular()%>" size="50" maxlength="40" required></td>
        </tr>
        <tr>
            <th>Email</th>
            <td><input class="recuadro" type="email" name="email" value="<%=usuario.getEmail()%>" size="50" maxlength="40" required></td>
        </tr>
        </tr>
        <tr>
            <th>Permisos</th>
            <td>
                <label><input type="checkbox" name="permisos" value="leer"> Leer</label><br>
                <label><input type="checkbox" name="permisos" value="editar"> Editar</label><br>
                <label><input type="checkbox" name="permisos" value="agregar"> Agregar</label><br>
                <label><input type="checkbox" name="permisos" value="eliminar"> Eliminar</label><br>
                <label><input type="checkbox" name="permisos" value="descargar"> Descargar</label><br>
            </td>
        </tr>
        <tr>
        <tr>
            <th>Estado</th>
            <td>
                <select class="recuadro" name="estado">
                    <option value="Activo" selected>Activo</option>
                    <option value="Inactivo">Inactivo</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>Contraseña</th>
            <td><input class="recuadro" type="password" name="clave" value="<%=usuario.getClave()%>" size="50" maxlength="40" required></td>
        </tr>
    </table>

    <input type="hidden" name="identificacionAnterior" value="<%=usuario.getIdentificacion()%>">
    <input type="hidden" name="accion" value="<%=accion%>">
    <input class="submit" type="submit" value="Guardar">
    <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
</form>
