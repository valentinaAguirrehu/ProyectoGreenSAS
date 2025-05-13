<%-- 
    Document   : devolucionDotacion
    Created on : 29 abr 2025, 16:52:20
    Author     : Angie
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.Persona"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="clasesGenericas.ConectorBD" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Persona persona = (Persona) session.getAttribute("persona");
    String identificacion = "";
    if (persona != null) {
        identificacion = persona.getIdentificacion();
    } else if (request.getParameter("idPersona") != null) {
        identificacion = request.getParameter("idPersona");
    }

    String idPersona = request.getParameter("idPersona");

    // AJAX: Obtener prendas por tipo de prenda entregadas a una persona
    String tipoPrendaAjax = request.getParameter("ajax_tipo_prenda");
    if (tipoPrendaAjax != null && request.getParameter("ajax_id_prenda") == null) {
        response.setContentType("application/json");
        ResultSet rsPrendas = ConectorBD.consultar(
                "SELECT DISTINCT p.id_prenda, p.nombre FROM prenda p "
                + "JOIN detalleEntrega de ON p.id_prenda = de.id_prenda "
                + "JOIN entregaDotacion ed ON de.id_entrega = ed.id_entrega "
                + "WHERE p.id_tipo_prenda = " + tipoPrendaAjax
                + " AND ed.id_persona = " + idPersona
                + " ORDER BY p.nombre"
        );

        StringBuilder json = new StringBuilder("[");
        boolean hayDatos = false;
        while (rsPrendas.next()) {
            if (hayDatos) {
                json.append(",");
            }
            json.append("{\"id_prenda\":\"")
                    .append(rsPrendas.getString("id_prenda"))
                    .append("\",\"nombre\":\"")
                    .append(rsPrendas.getString("nombre"))
                    .append("\"}");
            hayDatos = true;
        }
        rsPrendas.close();

        if (!hayDatos) {
            json.append("{\"id_prenda\":\"\",\"nombre\":\"No se realizaron entregas de dotación para este tipo de prenda\"}");
        }
        json.append("]");
        out.print(json.toString());
        return;
    }

    // AJAX: Obtener tipos de prenda disponibles
    String tiposPorEstado = request.getParameter("ajax_tipos_por_estado");
    if (tiposPorEstado != null) {
        response.setContentType("application/json");

        ResultSet rsTipos = ConectorBD.consultar(
                "SELECT DISTINCT tp.id_tipo_prenda, tp.nombre "
                + "FROM tipoPrenda tp "
                + "JOIN prenda p ON tp.id_tipo_prenda = p.id_tipo_prenda "
                + "JOIN inventarioDotacion i ON p.id_prenda = i.id_prenda "
                + "ORDER BY tp.nombre"
        );

        StringBuilder jsonTipos = new StringBuilder("[");
        boolean primeroTipo = true;
        while (rsTipos.next()) {
            if (!primeroTipo) {
                jsonTipos.append(",");
            }
            jsonTipos.append("{\"id_tipo\":\"")
                    .append(rsTipos.getString("id_tipo_prenda"))
                    .append("\",\"nombre\":\"")
                    .append(rsTipos.getString("nombre"))
                    .append("\"}");
            primeroTipo = false;
        }
        jsonTipos.append("]");
        rsTipos.close();
        out.print(jsonTipos.toString());
        return;
    }

    // AJAX: Obtener tallas disponibles para una prenda
    String idPrendaAjax = request.getParameter("ajax_id_prenda");
    if (idPrendaAjax != null) {
        response.setContentType("application/json");

        // 1. Consultar tallas y unidad de negocio asociada
        ResultSet rsTallas = ConectorBD.consultar(
                "SELECT DISTINCT talla, unidad_negocio FROM inventarioDotacion "
                + "WHERE id_prenda = " + idPrendaAjax
                + " ORDER BY talla"
        );

        StringBuilder json = new StringBuilder("{\"valores\":[");
        boolean primero = true;
        String unidadNegocio = "";

        while (rsTallas.next()) {
            if (!primero) {
                json.append(",");
            }
            json.append("\"").append(rsTallas.getString("talla")).append("\"");
            primero = false;

            // Guardar la unidad de negocio (siempre será la misma, así que basta con tomarla una vez)
            if (unidadNegocio.isEmpty()) {
                unidadNegocio = rsTallas.getString("unidad_negocio");
            }
        }
        rsTallas.close();
        json.append("], \"unidad_negocio\":\"").append(unidadNegocio).append("\"}");

        out.print(json.toString());
        return;
    }

    ResultSet tipos = ConectorBD.consultar("SELECT id_tipo_prenda, nombre FROM tipoPrenda");
%>

<jsp:include page="../menu.jsp" />

<html>
    <head>
        <link rel="stylesheet" href="../presentacion/style-Cargos.css">
        <link rel="stylesheet" href="../presentacion/style-DotacionFormularios.css" />
    </head>
    <body>
        <div class="content">
            <h3 class="titulo">Registrar devolución de dotación</h3>
            <form action="devolucionDotacionActualizar.jsp" method="post">
                <input type="hidden" name="accion" value="Registrar">


                <table class="table2">
                    <tbody>
                        <tr>
                            <td><label for="fechaDevolucion">Fecha de devolución:</label></td>
                            <td><input type="date" name="fechaDevolucion" required></td>
                        </tr>
                        <tr>
                            <td><label for="tipoEntrega">Tipo de entrega:</label></td>
                            <td>
                                <select name="tipoEntrega" required>
                                    <option value="">Seleccione un tipo</option>
                                    <option value="Completa">Completa</option>
                                    <option value="Parcial">Parcial</option>
                                </select>
                            </td>
                        </tr>
                </table>

                <table class="table" id="tablaDotacion">
                    <thead>
                        <tr>
                            <th>Tipo de prenda</th>
                            <th>Prenda</th>
                            <th>Talla</th>
                            <th>Unidad de Negocio</th>
                            <th>
                                <button type="button" onclick="agregarFila()">
                                    <img src="../presentacion/iconos/agregar.png" alt="Agregar" width="24" height="24">
                                </button>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="fila-dotacion">
                            <td>
                                <select class="select-tipo" name="id_tipo_prenda[]" required onchange="cargarPrendas(this)">
                                    <option value="">Seleccione</option>
                                    <%
                                        while (tipos.next()) {
                                    %>
                                    <option value="<%=tipos.getString("id_tipo_prenda")%>"><%=tipos.getString("nombre")%></option>
                                    <%
                                        }

                                        tipos.close();
                                    %>
                                </select>
                            </td>
                            <td>
                                <select name="id_prenda[]" class="select-prenda" required onchange="cargarTallas(this)">
                                    <option value="">Seleccionar</option>
                                </select>
                            </td>
                            <td>
                                <select name="talla[]" class="input-talla" required>
                                    <option value="">Seleccionar</option>
                                </select>
                            </td>

                            <td>
                                <input type="text" name="unidad_negocio[]" class="unidad-negocio" readonly>
                            </td>
                            <td>
                                <button type="button" class="fila-icono" onclick="eliminarFila(this)">
                                    <img src="../presentacion/iconos/eliminar.png" alt="Eliminar" width="24" height="24">
                                </button>
                            </td>
                        </tr>
                    </tbody>

                    <input type="hidden" name="idPersona" value="<%= idPersona != null ? idPersona : ""%>">
                </table>

                <div class="botones-form">
                    <button type="submit" class="btn-verde">Guardar</button>
                    <a href="historialDotacion.jsp?identificacion=<%= identificacion%>" class="btn-rojo">Cancelar</a>
                </div>
            </form>
            <script>
                function agregarFila() {
                    const filaBase = document.querySelector(".fila-dotacion");
                    const nuevaFila = filaBase.cloneNode(true);

                    nuevaFila.querySelectorAll("select").forEach(select => {
                        select.value = "";
                        if (select.classList.contains("select-prenda") || select.classList.contains("input-talla")) {
                            select.innerHTML = '<option value="">Seleccionar</option>';
                        }
                    });

                    nuevaFila.querySelector(".select-tipo").addEventListener("change", function () {
                        cargarPrendas(this);
                    });
                    nuevaFila.querySelector(".select-prenda").addEventListener("change", function () {
                        cargarTallas(this);
                    });

                    document.querySelector("#tablaDotacion tbody").appendChild(nuevaFila);
                }

                function eliminarFila(btn) {
                    const fila = btn.closest("tr");
                    const tbody = document.querySelector("#tablaDotacion tbody");
                    if (tbody.rows.length > 1)
                        fila.remove();
                }

                function cargarPrendas(selectTipo) {
                    const fila = selectTipo.closest("tr");
                    const prendaSelect = fila.querySelector(".select-prenda");
                    const idPersona = "<%= idPersona != null ? idPersona : ""%>";

                    prendaSelect.innerHTML = '<option value="">Cargando...</option>';

                    if (selectTipo.value) {
                        fetch("devolucionDotacion.jsp?ajax_tipo_prenda=" + selectTipo.value + "&idPersona=" + idPersona)
                                .then(res => res.json())
                                .then(data => {
                                    prendaSelect.innerHTML = '';
                                    if (data.length === 1 && data[0].id_prenda === "") {
                                        const opt = document.createElement("option");
                                        opt.value = "";
                                        opt.textContent = data[0].nombre;
                                        opt.disabled = true;
                                        opt.selected = true;
                                        prendaSelect.appendChild(opt);
                                    } else {
                                        const defaultOption = document.createElement("option");
                                        defaultOption.value = "";
                                        defaultOption.textContent = "Seleccionar";
                                        prendaSelect.appendChild(defaultOption);

                                        data.forEach(p => {
                                            const opt = document.createElement("option");
                                            opt.value = p.id_prenda;
                                            opt.textContent = p.nombre;
                                            prendaSelect.appendChild(opt);
                                        });
                                    }
                                });
                    } else {
                        prendaSelect.innerHTML = '<option value="">Seleccionar</option>';
                    }
                }

                function cargarTallas(selectPrenda) {
                    const fila = selectPrenda.closest("tr");
                    const idPrenda = selectPrenda.value;
                    const selectTalla = fila.querySelector(".input-talla");
                    const inputUnidad = fila.querySelector(".unidad-negocio"); // <- Este input es el campo readonly

                    selectTalla.innerHTML = '<option value="">Cargando...</option>';
                    inputUnidad.value = ""; // Limpiar valor anterior

                    if (idPrenda) {
                        fetch("devolucionDotacion.jsp?ajax_id_prenda=" + idPrenda)
                                .then(response => response.json())
                                .then(data => {
                                    // Cargar las tallas
                                    selectTalla.innerHTML = '<option value="">Seleccione talla</option>';
                                    data.valores.forEach(talla => {
                                        const option = document.createElement("option");
                                        option.value = talla;
                                        option.textContent = talla;
                                        selectTalla.appendChild(option);
                                    });

                                    // Prellenar unidad de negocio
                                    inputUnidad.value = data.unidad_negocio || '';
                                })
                                .catch(() => {
                                    selectTalla.innerHTML = '<option value="">Error al cargar tallas</option>';
                                    inputUnidad.value = "";
                                });
                    } else {
                        selectTalla.innerHTML = '<option value="">Seleccione talla</option>';
                        inputUnidad.value = "";
                    }
                }
            </script>
    </body>
</html>
