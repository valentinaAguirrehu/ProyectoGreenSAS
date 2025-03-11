<%-- 
    Document   : usuariosFormulario
    Created on : 10 mar 2025, 14:52:32
    Author     : Angie
--%>

<%@page import="clases.Persona"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String accion=request.getParameter("accion");
String identificacion=request.getParameter("identificacion");
Persona usuario=new Persona();
if (accion.equals("Modificar")) {
        usuario=new Persona(identificacion);
    }
%>

<h3><%=accion.toUpperCase() %> USUARIO</h3>
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
            <th>Apellidos</th>
            <td><input class="recuadro" type="text" name="apellidos" value="<%=usuario.getApellidos()%>" size="50" maxlength="40" required></td>
        </tr>
        <tr>
            <th>Celular</th>
            <td><input class="recuadro" type="tel" name="celular" value="<%=usuario.getCelular()%>" size="50"  maxlength="40" required></td>
        </tr>
        <tr>
            <th>Email</th>
            <td><input class="recuadro" type="email" name="email" value="<%=usuario.getEmail() %>" size="50" maxlength="40" required></td>
        </tr>
        <tr>
            <th>Contraseña</th>
            <td><input class="recuadro" type="password" name="clave" value="<%=usuario.getClave() %>" size="50" maxlength="40" required></td>
        </tr>

    </table>

    <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>">
    <input class="submit" type="submit" name="accion" value="<%=accion%>">
    <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
</form>

<script>

</script>
