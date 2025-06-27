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
    request.setCharacterEncoding("UTF-8");

    // ✅ 1️⃣ Parámetros principales
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    String identificacion = request.getParameter("identificacion");

    // ✅ ✔️ Agregado: Si no llega identificación, usar id
    if (identificacion == null || identificacion.trim().isEmpty()) {
        identificacion = id;
    }

    // ✅ 2️⃣ Inicializar objetos
    Persona persona = null;
    Retirados retirado = new Retirados();

    if (identificacion != null && !identificacion.isEmpty()) {
        persona = new Persona(identificacion);
    } else {
        List<Retirados> datos = Retirados.getListaEnObjetos(null, null);
        if (datos != null && !datos.isEmpty()) {
            retirado = datos.get(0);
            if (retirado.getIdentificacionPersona() != null) {
                persona = new Persona(retirado.getIdentificacionPersona());
            }
        }
    }

    if ("Modificar".equals(accion) && id != null) {
        retirado = new Retirados(id);
        persona = new Persona(id);
    }

    // ✅ 3️⃣ Lógica para tipoColaborador
    String tipoColaborador = (persona != null && persona.getTipo() != null && !persona.getTipo().isEmpty())
                             ? persona.getTipo()
                             : request.getParameter("tipo");

    if (tipoColaborador == null || tipoColaborador.trim().isEmpty()) {
        tipoColaborador = "C";
    }

    // ✅ 4️⃣ Crear objetos dependientes
    InformacionLaboral info = new InformacionLaboral(persona.getIdentificacion());
    Educacion educacion = (persona != null) ? new Educacion(persona.getIdentificacion()) : new Educacion();

    String idCargoSeleccionado = (info.getIdCargo() != null) ? info.getIdCargo() : "";
    List<Cargo> listaCargos = Cargo.getListaEnObjetos(null, null);

    // ✅ ✔️ Asegurar acción por defecto
    if (accion == null || accion.isEmpty()) {
        accion = "Adicionar";
    }
    String textoBoton = accion.equals("Modificar") ? "Modificar" : "Aceptar";

    // ✅ 5️⃣ Lógica para fechas
    // Parámetros por si vienen del request
    String fechaIngresoParam = request.getParameter("fechaIngreso");
    String fechaRetiroParam = request.getParameter("fechaRetiro");

    // 🔥 ✔️ AGREGADO: Usar lógica inteligente para calcular fechaIngreso
    // ✅ Nuevo manejo para fechaIngreso dependiendo de la acción
String fechaIngreso = "";

if ("Modificar".equals(accion)) {
    // ✔️ Si es Modificar, siempre usar la fecha guardada en la BD
    fechaIngreso = info.getFechaIngreso();
} else {
    // ✔️ Si es Adicionar u otra acción, usar la lógica inteligente o el parámetro enviado
    fechaIngreso = (fechaIngresoParam != null && !fechaIngresoParam.trim().isEmpty())
                   ? fechaIngresoParam
                   : info.obtenerFechaIngresoInteligente(tipoColaborador, educacion, fechaIngresoParam);
}

    // 🔥 ✔️ AGREGADO: Para fechaRetiro, usar param si existe o sino traer de BD
    String fechaRetiro = (fechaRetiroParam != null && !fechaRetiroParam.trim().isEmpty())
                         ? fechaRetiroParam
                         : info.getFechaRetiro();
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
                <%= info.getEstablecimiento().getSelectLugarTrabajo("establecimiento")%>
            </td>               
        </tr> -->
                <tr>
                    <th>Lugar de trabajo</th>
                    <td> <%= mostrarCampo(info.getUnidadNegocio())%></td>
                </tr>
                <tr>
               <tr>
    <th>Fecha de ingreso</th>
    <td>
        <input type="date" name="fechaIngreso" value="<%= fechaIngreso %>" required>
    </td>
</tr>
<tr>
    <th>Fecha de retiro</th>
    <td>
        <input type="date" name="fechaRetiro" value="<%= fechaRetiro %>">
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
            <input type="hidden" name="unidadNegocio" value="<%= (info.getUnidadNegocio() != null && !info.getUnidadNegocio().isEmpty()) ? info.getUnidadNegocio() : "No aplica"%>">
            <input type="hidden" name="centroCostos" value="<%= (info.getCentroCostos() != null && !info.getCentroCostos().isEmpty()) ? info.getCentroCostos() : "No aplica"%>">
            <input type="hidden" name="area" value="<%= (info.getArea() != null && !info.getArea().equals("")) ? info.getArea() : "No aplica"%>">
            <input type="hidden" name="salario" value="<%= (info.getSalario() != null && !info.getSalario().isEmpty()) ? info.getSalario() : "No aplica"%>">
            <input type="hidden" name="estado" value="<%= (info.getEstado() != null && !info.getEstado().isEmpty()) ? info.getEstado() : "No aplica"%>">
            <input type="hidden" name="fechaTerPriContrato" value="<%= (info.getFechaTerPriContrato() != null && !info.getFechaTerPriContrato().isEmpty()) ? info.getFechaTerPriContrato() : "No aplica"%>">
<!--            <input type="hidden" name="fechaIngresoTemporal" value="<%= (info.getFechaIngresoTemporal() != null && !info.getFechaIngresoTemporal().isEmpty()) ? info.getFechaIngresoTemporal() : "No aplica"%>">-->

            <input type="hidden" name="id" value="<%= (retirado != null) ? retirado.getId() : ""%>">
            <input type="hidden" name="accion" value="<%= accion%>">
            <input type="hidden" name="identificacion" value="<%= request.getParameter("identificacion")%>">
            <button type="submit" class="submit"><%= textoBoton%></button>
            <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
        </form>
    </div>           
</body>