<%-- 
    Document   : retiradosFormulario
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>

<%@page import="clases.Cargo"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="clases.Retirados"%>
<%@ page import="clases.Persona"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    String identificacion = request.getParameter("identificacion");

    Persona persona = null;
    Retirados retirado = new Retirados();

    if (identificacion != null && !identificacion.isEmpty()) {
        persona = new Persona(identificacion);
    } else {
        List<Retirados> datos = Retirados.getListaEnObjetos(null, null);
        if (datos != null && !datos.isEmpty()) {
            retirado = datos.get(0);
            if (retirado != null && retirado.getIdentificacionPersona() != null) {
                persona = new Persona(retirado.getIdentificacionPersona());
            }
        }
    }

    if ("Modificar".equals(accion) && id != null) {
        retirado = new Retirados(id);
        persona = new Persona(id);
    }

    String nombreCargo = "";
    if (persona != null && persona.getIdCargo() != null) {
        Cargo cargo = new Cargo(persona.getIdCargo());
        nombreCargo = cargo.getNombre();
    }

    if (accion == null || accion.isEmpty()) {
        accion = "Adicionar"; // Valor por defecto
    }

    String textoBoton = accion.equals("Modificar") ? "Modificar" : "Aceptar";
%>

<%@ include file="../menu.jsp" %>

<head>
    <link rel="stylesheet" href="../presentacion/style-RetiradosFormulario.css">
</head>
<body>
    <div class="content">
        <h3 class="titulo">COLABORADOR RETIRADO</h3>
        <form name="formulario" method="post" action="retiradosActualizar.jsp">
            <table class="table" border="1">
                <tr>
                    <th>Identificación</th>
                    <td>
                        <span id="identificacionTexto"><%= (persona != null) ? persona.getIdentificacion() : ""%></span>
                        <input type="hidden" name="identificacion" value="<%= (persona != null) ? persona.getIdentificacion() : ""%>">
                    </td>
                </tr>

                <tr>
                    <th>Nombres</th>
                    <td><span id="nombre"><%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() : ""%></span></td>
                </tr>
                <tr>
                    <th>Cargo</th>
                    <td><span id="cargo"><%= nombreCargo%></span></td>
                </tr>
                <tr>
                    <th>Establecimiento</th>
                    <td><span id="establecimiento"><%= (persona != null) ? persona.getEstablecimiento() : ""%></span></td>
                </tr>
                <tr>
                    <th>Fecha de ingreso</th>
                    <td><span id="fechaIngreso"><%= (persona != null) ? persona.getFechaIngreso() : ""%></span></td>
                </tr>
                <tr>
                    <th>Fecha de retiro</th>
                    <td><input class="recuadro" type="date" name="fechaRetiro" 
                               value="<%= (persona != null) ? persona.getFechaRetiro() : ""%>" required></td>
                </tr>
                <tr>
                    <th>Número de caja</th>
                    <td><input class="recuadro" type="text" name="numCaja" 
                               value="<%= (retirado != null) ? retirado.getNumCaja() : ""%>"></td>
                </tr>
                <tr>
                    <th>Número de carpeta</th>
                    <td><input class="recuadro" type="text" name="numCarpeta" 
                               value="<%= (retirado != null) ? retirado.getNumCarpeta() : ""%>"></td>
                </tr>
                <tr>
                    <th>Observaciones</th>
                    <td colspan="3">
                        <textarea class="recuadro" name="observaciones" rows="4" cols="50">
                            <%= (retirado != null) ? retirado.getObservaciones() : ""%>
                        </textarea>
                    </td>
                </tr>
            </table>
            <input type="hidden" name="id" value="<%= (retirado != null) ? retirado.getId() : ""%>">
            <input type="hidden" name="accion" value="<%= accion%>">
            <input type="hidden" name="identificacion" value="<%= request.getParameter("identificacion")%>">
            <button type="submit" class="submit"><%= textoBoton%></button>
            <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
        </form>
    </div>           
</body>