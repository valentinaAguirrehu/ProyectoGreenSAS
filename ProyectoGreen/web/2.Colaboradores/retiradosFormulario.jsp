<%-- 
    Document   : retiradosFormulario
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>

<%@page import="clases.Educacion"%>
<%@page import="clases.InformacionLaboral"%>
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
    InformacionLaboral informacionLaboral = new InformacionLaboral(identificacion);

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

    InformacionLaboral info = new InformacionLaboral(persona.getIdentificacion());
    String idCargoSeleccionado = (info != null && info.getIdCargo() != null) ? info.getIdCargo() : "";
    List<Cargo> listaCargos = Cargo.getListaEnObjetos(null, null);
    Educacion educacion = (persona != null) ? new Educacion(persona.getIdentificacion()) : new Educacion();

    if (accion == null || accion.isEmpty()) {
        accion = "Adicionar";
    }

    String textoBoton = accion.equals("Modificar") ? "Modificar" : "Aceptar";

    // 🔄 Precarga de fechas desde request o clase Java
    String fechaIngresoParam = request.getParameter("fechaIngreso");
    String fechaRetiroParam = request.getParameter("fechaRetiro");

    String fechaIngreso = "";
    String fechaRetiro = "";

    if (fechaIngresoParam != null && !fechaIngresoParam.trim().isEmpty()) {
        fechaIngreso = fechaIngresoParam;
    } else if (info.getFechaIngreso() != null && !info.getFechaIngreso().trim().isEmpty()) {
        fechaIngreso = info.getFechaIngreso();
    } else if (info.getFechaIngresoTemporal() != null && !info.getFechaIngresoTemporal().trim().isEmpty()) {
        fechaIngreso = info.getFechaIngresoTemporal();
    } else if (educacion != null && educacion.getFechaEtapaProductiva() != null && !educacion.getFechaEtapaProductiva().trim().isEmpty()) {
        fechaIngreso = educacion.getFechaEtapaProductiva();
    }

    if (fechaRetiroParam != null && !fechaRetiroParam.trim().isEmpty()) {
        fechaRetiro = fechaRetiroParam;
    } else if (info.getFechaRetiro() != null && !info.getFechaRetiro().trim().isEmpty()) {
        fechaRetiro = info.getFechaRetiro();
    }
%>
<%!
    public String mostrarCampo(Object valor) {
        return (valor != null && !valor.toString().trim().isEmpty() && !"null".equals(valor.toString().trim()))
                ? valor.toString()
                : "No aplica";
    }
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
                    <th>Cargo<span style="color: red;">*</span></th>
                    <td>
                        <input type="hidden" name="idCargo" value="<%= idCargoSeleccionado%>">
                        <%
                            String nombreCargoSeleccionado = "";
                            for (Cargo c : listaCargos) {
                                if (c.getId().equals(idCargoSeleccionado)) {
                                    nombreCargoSeleccionado = c.getNombre();
                                    break;
                                }
                            }
                        %>
                        <span><%= nombreCargoSeleccionado%></span>
                    </td>
                </tr>

                <!--                <tr>
                                    <th>Lugar de trabajo<span style="color: red;">*</span></th>
                                    <td colspan="2">
                <%= informacionLaboral.getEstablecimiento().getSelectLugarTrabajo("establecimiento")%>
            </td>               
        </tr> -->
                <tr>
                    <th>Lugar de trabajo</th>
                    <td> <%= mostrarCampo(informacionLaboral.getUnidadNegocio())%></td>
                </tr>
                <tr>
                <tr>
                    <th>Fecha de ingreso</th>
                    <td>
                        <input type="date" name="fechaIngreso" value="<%= fechaIngreso%>" required>
                    </td>
                </tr>
                <tr>
                    <th>Fecha de retiro</th>
                    <td>
                        <input type="date" name="fechaRetiro" value="<%= fechaRetiro%>" required>
                    </td>
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
            <input type="hidden" name="unidadNegocio" value="<%= (informacionLaboral.getUnidadNegocio() != null && !informacionLaboral.getUnidadNegocio().isEmpty()) ? informacionLaboral.getUnidadNegocio() : "No aplica"%>">
            <input type="hidden" name="centroCostos" value="<%= (informacionLaboral.getCentroCostos() != null && !informacionLaboral.getCentroCostos().isEmpty()) ? informacionLaboral.getCentroCostos() : "No aplica"%>">
            <input type="hidden" name="area" value="<%= (informacionLaboral.getArea() != null && !informacionLaboral.getArea().equals("")) ? informacionLaboral.getArea() : "No aplica"%>">
            <input type="hidden" name="salario" value="<%= (informacionLaboral.getSalario() != null && !informacionLaboral.getSalario().isEmpty()) ? informacionLaboral.getSalario() : "No aplica"%>">
            <input type="hidden" name="estado" value="<%= (informacionLaboral.getEstado() != null && !informacionLaboral.getEstado().isEmpty()) ? informacionLaboral.getEstado() : "No aplica"%>">
            <input type="hidden" name="fechaTerPriContrato" value="<%= (informacionLaboral.getFechaTerPriContrato() != null && !informacionLaboral.getFechaTerPriContrato().isEmpty()) ? informacionLaboral.getFechaTerPriContrato() : "No aplica"%>">
<!--            <input type="hidden" name="fechaIngresoTemporal" value="<%= (informacionLaboral.getFechaIngresoTemporal() != null && !informacionLaboral.getFechaIngresoTemporal().isEmpty()) ? informacionLaboral.getFechaIngresoTemporal() : "No aplica"%>">-->

            <input type="hidden" name="id" value="<%= (retirado != null) ? retirado.getId() : ""%>">
            <input type="hidden" name="accion" value="<%= accion%>">
            <input type="hidden" name="identificacion" value="<%= request.getParameter("identificacion")%>">
            <button type="submit" class="submit"><%= textoBoton%></button>
            <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
        </form>
    </div>           
</body>