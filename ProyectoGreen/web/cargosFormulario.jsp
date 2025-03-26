<%-- 
    Document   : cargosEliminar
    Created on : 8 mar 2025, 18:50:09
    Author     : Angie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="clases.Cargo" %>
<%
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    Cargo cargo = new Cargo();
    cargo.setId("Sin generar");

    if ("Modificar".equals(accion)) {
        cargo = new Cargo(id);
    }
%>

<%@ include file="menu.jsp" %>

<div class="content">
    <link rel="stylesheet" href="presentacion/style-CargoFormulario.css">

    <form name="formulario" method="post" action="cargosActualizar.jsp" enctype="multipart/form-data">
        <table class="table">
            <h3 class="titulo"><%=accion.toUpperCase()%> CARGO</h3>
            <tr>
                <th>Nombre</th>
                <td>
                    <input class="recuadro" type="text" name="nombre" value="<%=cargo.getNombre()%>" maxlength="50" size="40" required>
                </td>
            </tr>
            <tr>
                <th>Código del cargo</th>
                <td>
                    <input class="recuadro" type="number" name="codigoCargo" value="<%=cargo.getCodigoCargo()%>" maxlength="50" size="40" placeholder="Campo numérico" required oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                </td>
            </tr>

            <tr>
                <th>Descripción</th>
                <td>
                    <textarea class="recuadro" name="descripcion" rows="4" cols="40" required><%=cargo.getDescripcion()%></textarea>
                </td>
            </tr>
        </table> 
        <input type="hidden" name="id" value="<%=cargo.getId()%>">
        <div class="button-container">
            <input class="submit" type="submit" name="accion" value="<%=accion%>">
            <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
        </div>

    </form>
</body>
</html>
</div>

