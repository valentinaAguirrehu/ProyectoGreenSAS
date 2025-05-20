<%-- 
    Document   : historialDotacion
    Created on : 16 abril 2025, 17:52:29
    Author     : Angie
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="clases.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    String idPersona = request.getParameter("identificacion");

    List<EntregaDotacion> entregas = EntregaDotacion.getListaEnObjetos("id_persona = '" + idPersona + "'", "fechaEntrega DESC");
    List<DetalleEntrega> detallesEntrega = DetalleEntrega.getListaEnObjetos(null, null);
    List<DevolucionDotacion> devoluciones = DevolucionDotacion.getListaEnObjetos("id_persona = '" + idPersona + "'", "fecha_devolucion DESC");
    List<DetalleDevolucion> detallesDevolucion = DetalleDevolucion.getListaEnObjetos(null, null);

    Map<String, String> mapaPrendas = new HashMap<>();
    for (Prenda p : Prenda.getListaEnObjetos(null, null)) {
        mapaPrendas.put(p.getIdPrenda(), p.getNombre());
    }
%>

<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>
<link rel="stylesheet" href="../presentacion/style-Cargos.css">
<style>
    .boton-switch {
        margin: 10px 0;
    }

    .boton-switch button {
        background-color: #186a25;
        color: #fff;
        border: 1px solid white;
        padding: 8px 16px;
        margin-right: 5px;
        border-radius: 5px;
        cursor: pointer;
    }

    .boton-switch button.active {
        background-color: #053b0e;
    }

    .tabla-datos {
        display: none;
        width: 100%;
        border-collapse: collapse;
    }

    .tabla-datos.active {
        display: table;
    }

    .grupo-par td {
        background-color: #f9f9f9;
    }

    .grupo-impar td {
        background-color: #b4ddb4;
    }

    .subir {
        background-color: #186a25;
        color: white;
        padding: 10px 16px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 500;
        transition: background-color 0.3s ease;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .subir:hover {
        background-color: #053b0e;
    }

    .subirr img {
        vertical-align: middle;
    }
</style>

<div class="content">
    <h3 class="titulo">HISTORIAL DE DOTACIÓN</h3>

    <div style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
        <div class="boton-switch" style="display: inline-flex; gap: 10px;">
            <button id="btnEntregas" class="active" onclick="mostrarTabla('entregas')">ENTREGAS</button>
            <button id="btnDevoluciones" onclick="mostrarTabla('devoluciones')">DEVOLUCIONES</button>
        </div>

        <div style="display: inline-flex; gap: 10px;">
            <a href="entregaDotacion.jsp?accion=Adicionar&idPersona=<%=idPersona%>" class="subir" style="display: inline-flex; align-items: center; gap: 6px;">
                <img src="../presentacion/iconos/agregar.png" width="16" height="16" alt="Agregar">
                Registrar entrega
            </a>
            <a href="devolucionDotacion.jsp?accion=Adicionar&idPersona=<%=idPersona%>" class="subir" style="display: inline-flex; align-items: center; gap: 6px;">
                <img src="../presentacion/iconos/agregar.png" width="16" height="16" alt="Agregar">
                Registrar devolución
            </a>
        </div>
    </div>

    <%
        int contadorGrupo = 0;
    %>

    <!-- Tabla ENTREGAS -->
    <table class="table tabla-datos active" id="tabla-entregas" border="1">
        <thead>
            <tr>
                <th>Entrega</th>
                <th>Responsable</th>
                <th>Fecha</th>
                <th>Tipo de entrega</th>
                <th>Prenda</th>
                <th>Talla</th>
                <th>Unidad de negocio</th>
                <th>Estado</th>
                <th>Observación</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (entregas.isEmpty()) {
            %>
            <tr>
                <td colspan="10" style="text-align: center; font-style: italic;">
                    No se ha registrado ninguna entrega de dotación para esta persona.
                </td>
            </tr>
            <%
            } else {
                for (EntregaDotacion entrega : entregas) {
                    List<DetalleEntrega> grupo = new ArrayList<>();
                    for (DetalleEntrega detalle : detallesEntrega) {
                        if (detalle.getIdEntrega().equals(entrega.getIdEntrega())) {
                            grupo.add(detalle);
                        }
                    }

                    boolean primera = true;
                    String claseGrupo = (contadorGrupo++ % 2 == 0) ? "grupo-par" : "grupo-impar";

                    for (DetalleEntrega detalle : grupo) {
                        String prenda = mapaPrendas.getOrDefault(detalle.getIdPrenda(), "Desconocida");
            %>
            <tr class="<%= claseGrupo%>">
                <% if (primera) {%>
                <td rowspan="<%= grupo.size()%>"><%= entrega.getNumeroEntrega()%></td>
                <td rowspan="<%= grupo.size()%>"><%= entrega.getResponsable()%></td>
                <td rowspan="<%= grupo.size()%>"><%= entrega.getFechaEntrega()%></td>
                <td rowspan="<%= grupo.size()%>"><%= entrega.getTipoEntrega()%></td>
                <% }%>
                <td><%= prenda%></td>
                <td><%= detalle.getTalla()%></td>
                <% if (primera) {%>
                <td rowspan="<%= grupo.size()%>"><%= detalle.getUnidadNegocio()%></td>
                <td rowspan="<%= grupo.size()%>"><%= detalle.getEstado()%></td>
                <td rowspan="<%= grupo.size()%>"><%= entrega.getObservacion()%></td>
                <td rowspan="<%= grupo.size()%>">
                    <a class='editar'
                       href='entregaDotacion.jsp?accion=Modificar&id=<%= entrega.getIdEntrega()%>&idPersona=<%= entrega.getIdPersona()%>&numeroEntrega=<%= entrega.getNumeroEntrega()%>'
                       title='Modificar'>
                        <img src='../presentacion/iconos/modificar.png' width='25' height='25'>
                    </a>
                    <img src='../presentacion/iconos/eliminar.png' class='eliminar' width='25' height='25' title='Eliminar'
                         onclick='eliminarEntrega("<%= entrega.getIdEntrega()%>", "<%= entrega.getIdPersona()%>")'>
                </td>

                <% } %>
            </tr>
            <% primera = false; %>

            <%
                        }
                    }
                }
            %>
        </tbody>
    </table>

    <!-- Tabla DEVOLUCIONES -->
    <table class="table tabla-datos" id="tabla-devoluciones" border="1">
        <thead>
            <tr>
                <th>Devolución</th>
                <th>Responsable</th>
                <th>Fecha</th>
                <th>Tipo de entrega</th>
                <th>Prenda</th>
                <th>Talla</th>
                <th>Unidad de negocio</th>
                <th>Observación</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                int contadorGrupoDevol = 0;
                if (devoluciones.isEmpty()) {
            %>
            <tr>
                <td colspan="9" style="text-align: center; font-style: italic;">
                    No se ha registrado ninguna devolución de dotación para esta persona.
                </td>
            </tr>
            <%
            } else {
                for (DevolucionDotacion devolucion : devoluciones) {
                    List<DetalleDevolucion> grupo = new ArrayList<>();
                    for (DetalleDevolucion detalle : detallesDevolucion) {
                        if (detalle.getIdDevolucion().equals(devolucion.getIdDevolucion())) {
                            grupo.add(detalle);
                        }
                    }

                    boolean primera = true;
                    String claseGrupo = (contadorGrupoDevol++ % 2 == 0) ? "grupo-par" : "grupo-impar";

                    for (DetalleDevolucion detalle : grupo) {
                        String prenda = mapaPrendas.getOrDefault(detalle.getIdPrenda(), "Desconocida");
            %>
            <tr class="<%= claseGrupo%>">
                <% if (primera) {%>
                <td rowspan="<%= grupo.size()%>"><%= devolucion.getNumeroDevolucion()%></td>
                <td rowspan="<%= grupo.size()%>"><%= devolucion.getResponsable()%></td>
                <td rowspan="<%= grupo.size()%>"><%= devolucion.getFechaDevolucion()%></td>
                <td rowspan="<%= grupo.size()%>"><%= devolucion.getTipoEntrega()%></td>
                <% }%>
                <td><%= prenda%></td>
                <td><%= detalle.getTalla()%></td>
                <% if (primera) {%>
                <td rowspan="<%= grupo.size()%>"><%= detalle.getUnidadNegocio()%></td>
                <td rowspan="<%= grupo.size()%>"><%= devolucion.getObservacion()%></td>
                <td rowspan="<%= grupo.size()%>">
                    <a class='editar'
                       href='entregaDotacion.jsp?accion=Modificar&id=<%= devolucion.getIdDevolucion()%>&idPersona=<%= devolucion.getIdPersona()%>&numeroEntrega=<%= devolucion.getNumeroDevolucion()%>'
                       title='Modificar'>
                        <img src='../presentacion/iconos/modificar.png' width='25' height='25'>
                    </a>
                    <img src='../presentacion/iconos/eliminar.png' class='eliminar' width='25' height='25' title='Eliminar'
                         onclick='eliminarEntrega("<%= devolucion.getIdDevolucion()%>", "<%= devolucion.getIdPersona()%>")'> 
                </td>
                <% } %>
            </tr>
            <% primera = false; %>
            <%
                        }
                    }
                }
            %>
        </tbody>
    </table>
</div>

<script>

    function eliminarEntrega(idEntrega, idPersona) {
        if (confirm("¿Está seguro de que desea eliminar esta entrega? Al hacerlo, también se eliminarán las prendas asociadas, por lo que ya no estarán disponibles en el inventario ni podrán ser devueltas.")) {
            window.location.href = "entregaDotacionActualizar.jsp?accion=Eliminar&id=" + idEntrega + "&idPersona=" + idPersona;
        }
    }

    function mostrarTabla(tipo) {
        document.getElementById("tabla-entregas").classList.remove("active");
        document.getElementById("tabla-devoluciones").classList.remove("active");
        document.getElementById("btnEntregas").classList.remove("active");
        document.getElementById("btnDevoluciones").classList.remove("active");

        if (tipo === 'entregas') {
            document.getElementById("tabla-entregas").classList.add("active");
            document.getElementById("btnEntregas").classList.add("active");
        } else {
            document.getElementById("tabla-devoluciones").classList.add("active");
            document.getElementById("btnDevoluciones").classList.add("active");
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        controlarPermisos(
    <%= administrador.getpEliminar()%>,
    <%= administrador.getpEditar()%>,
    <%= administrador.getpAgregar()%>
        );
    });
</script>