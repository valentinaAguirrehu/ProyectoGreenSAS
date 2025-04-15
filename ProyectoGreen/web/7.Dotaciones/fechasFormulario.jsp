<%-- 
    Document   : fechasFormulario
    Created on : 14 abr 2025, 17:23:18
    Author     : Angie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="clases.FechaProxEntregaDotacion" %> 

<%
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");

    FechaProxEntregaDotacion fechas = new FechaProxEntregaDotacion();

    if ("Modificar".equals(accion) && id != null) {
        fechas = new FechaProxEntregaDotacion(id); // Carga desde BD con el id
    }

    String fechaAdmin = fechas.getFecha_admin();
    String fechaOperativo = fechas.getFecha_operativo();
%>

<%@ include file="../menu.jsp" %>

<head>
    <link rel="stylesheet" href="../presentacion/style-CargoFormulario.css">
</head>
<body>
    <div class="content">
        <form name="formulario" method="post" action="fechasActualizar.jsp">
            <input type="hidden" name="id" value="<%= id %>">
            <table class="table">
                <h3 class="titulo"><%=accion.toUpperCase()%> FECHAS DE ENTREGA DE DOTACIÓN</h3>
                <tr>
                    <th>Personal administrativo</th>
                    <td>
                        <input class="recuadro" type="date" name="fechaAdmin" value="<%= fechaAdmin != null ? fechaAdmin : ""%>" required>
                    </td>
                </tr>
                <tr>
                    <th>Personal operativo</th>
                    <td>
                        <input class="recuadro" type="date" name="fechaOperativo" value="<%= fechaOperativo != null ? fechaOperativo : ""%>" required>
                    </td>
                </tr>    
            </table> 
            <div class="button-container">
                <input class="submit" type="submit" name="accion" value="<%=accion%>">
                <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
            </div>
        </form>
    </div>
</body>
