<%@page import="clases.Prenda"%>
<%@page import="clases.DetalleEntregaDAO"%>
<%@page import="clases.DetalleEntrega"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.EntregaDotacion"%>
<%@page import="clases.EntregaDotacionDAO"%>
<%@page import="clases.Persona"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="clasesGenericas.ConectorBD" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");
    String accion = request.getParameter("accion") != null ? request.getParameter("accion") : "Registrar";
    String idEntrega = request.getParameter("id") != null ? request.getParameter("id") : "";
    String tituloFormulario = accion.equals("Modificar") ? "Modificar entrega de dotación" : "Registrar entrega de dotación";

    String fechaEntrega = "";
    String responsable = "";
    String tipoEntrega = "";
    String observacion = "";
    String estadoSeleccionado = "";
    String unidadSeleccionada = "";
    String idPersona = request.getParameter("idPersona") != null ? request.getParameter("idPersona") : "";
    String identificacion = request.getParameter("identificacion") != null ? request.getParameter("identificacion") : "";
    String numeroEntrega = request.getParameter("numeroEntrega") != null ? request.getParameter("numeroEntrega") : "";
    List<Prenda> listaPrendas = Prenda.getListaEnObjetos(null, null);

    // DECLARAR UNA SOLA VEZ AQUÍ
    List<DetalleEntrega> detallesEntrega = new ArrayList<>();

    if ("Modificar".equals(accion) && idEntrega != null && !idEntrega.isEmpty()) {
        EntregaDotacionDAO dao = new EntregaDotacionDAO();
        EntregaDotacion entrega = dao.obtenerEntregaPorId(Integer.parseInt(idEntrega));
        if (entrega != null) {
            fechaEntrega = entrega.getFechaEntrega();
            responsable = entrega.getResponsable();
            tipoEntrega = entrega.getTipoEntrega();
            observacion = entrega.getObservacion();
            idPersona = String.valueOf(entrega.getIdPersona());
        }

        DetalleEntregaDAO detalleDAO = new DetalleEntregaDAO();
        detallesEntrega = detalleDAO.obtenerDetallesPorIdEntrega(idEntrega);

        if (detallesEntrega != null && !detallesEntrega.isEmpty()) {
            estadoSeleccionado = detallesEntrega.get(0).getEstado();
            unidadSeleccionada = detallesEntrega.get(0).getUnidadNegocio();
        }
    }
%> 

<%
    Persona persona = (Persona) session.getAttribute("persona");
    if (persona != null) {
        identificacion = persona.getIdentificacion();
    }

    // -------------------- CARGAR TIPOS DE PRENDA --------------------
    String tiposPorEstado = request.getParameter("ajax_tipos_por_estado");
    String unidadParaTipos = request.getParameter("ajax_unidad");

    if (tiposPorEstado != null && unidadParaTipos != null) {
        response.setContentType("application/json");

        ResultSet rsTipos = ConectorBD.consultar(
                "SELECT DISTINCT tp.id_tipo_prenda, tp.nombre "
                + "FROM tipoPrenda tp "
                + "JOIN prenda p ON tp.id_tipo_prenda = p.id_tipo_prenda "
                + "JOIN inventarioDotacion i ON p.id_prenda = i.id_prenda "
                + "WHERE i.estado = '" + tiposPorEstado + "' "
                + "AND i.unidad_negocio = '" + unidadParaTipos + "' "
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

    // -------------------- CARGAR PRENDAS --------------------
    String tipoPrendaAjax = request.getParameter("ajax_tipo_prenda");
    String estadoAjax = request.getParameter("ajax_estado");
    String unidadAjax = request.getParameter("ajax_unidad");

    if (tipoPrendaAjax != null && estadoAjax != null && unidadAjax != null && request.getParameter("ajax_id_prenda") == null) {
        response.setContentType("application/json");

        ResultSet rsPrendas = ConectorBD.consultar(
                "SELECT DISTINCT p.id_prenda, p.nombre FROM prenda p "
                + "JOIN inventarioDotacion i ON p.id_prenda = i.id_prenda "
                + "WHERE p.id_tipo_prenda = " + tipoPrendaAjax + " "
                + "AND i.estado = '" + estadoAjax + "' "
                + "AND i.unidad_negocio = '" + unidadAjax + "' "
                + "ORDER BY p.nombre"
        );

        StringBuilder json = new StringBuilder("[");
        boolean primero = true;
        while (rsPrendas.next()) {
            if (!primero) {
                json.append(",");
            }
            json.append("{\"id_prenda\":\"")
                    .append(rsPrendas.getString("id_prenda"))
                    .append("\",\"nombre\":\"")
                    .append(rsPrendas.getString("nombre"))
                    .append("\"}");
            primero = false;
        }
        json.append("]");
        rsPrendas.close();
        out.print(json.toString());
        return;
    }

    // -------------------- CARGAR TALLAS --------------------
    String idPrendaAjax = request.getParameter("ajax_id_prenda");

    if (idPrendaAjax != null && estadoAjax != null && unidadAjax != null) {
        response.setContentType("application/json");

        ResultSet rsTallas = ConectorBD.consultar(
                "SELECT DISTINCT talla FROM inventarioDotacion "
                + "WHERE id_prenda = " + idPrendaAjax + " "
                + "AND estado = '" + estadoAjax + "' "
                + "AND unidad_negocio = '" + unidadAjax + "' "
                + "ORDER BY talla"
        );

        StringBuilder jsonTallas = new StringBuilder("{\"valores\":[");
        boolean primero = true;
        while (rsTallas.next()) {
            if (!primero) {
                jsonTallas.append(",");
            }
            jsonTallas.append("\"").append(rsTallas.getString("talla")).append("\"");
            primero = false;
        }
        jsonTallas.append("]}");
        rsTallas.close();
        out.print(jsonTallas.toString());
        return;
    }

    // -------------------- CARGAR ESTADOS Y UNIDADES --------------------
    ResultSet estados = ConectorBD.consultar("SELECT DISTINCT estado FROM inventarioDotacion ORDER BY estado");
    ResultSet unidades = ConectorBD.consultar("SELECT DISTINCT unidad_negocio FROM inventarioDotacion ORDER BY unidad_negocio");
%>

<jsp:include page="../menu.jsp" />

<html>
    <head>
        <link rel="stylesheet" href="../presentacion/style-Cargos.css">
        <link rel="stylesheet" href="../presentacion/style-DotacionFormularios.css" />
    </head>
    <body>
        <div class="content">
            <h3 class="titulo"><%= tituloFormulario%></h3>
            <form action="entregaDotacionActualizar.jsp" method="post">
                <%
                    String accionFormulario = "Adicionar".equals(accion) ? "Registrar" : accion;
                %>
                <input type="hidden" name="accion" value="<%= accionFormulario%>">
                <input type="hidden" name="idPersona" value="<%= idPersona%>">

                <% if ("Modificar".equals(accion)) {%>
                <input type="hidden" name="id" value="<%= idEntrega%>">
                <input type="hidden" name="numeroEntrega" value="<%= numeroEntrega%>">
                <% }%>



                <table class="table2">
                    <tbody>
                        <tr>
                            <td><label for="fechaEntrega">Fecha de entrega:</label></td>
                            <td><input type="date" name="fechaEntrega" required value="<%= fechaEntrega%>"></td>
                        </tr>
                        <tr>
                            <td><label for="responsable">Responsable:</label></td>
                            <td><input type="text" name="responsable" required value="<%= responsable%>"></td>
                        </tr>
                        <tr>
                            <td><label for="tipoEntrega">Tipo de entrega:</label></td>
                            <td>
                                <select name="tipoEntrega" required>
                                    <option value="">Seleccione tipo</option>
                                    <option value="Completa" <%= "Completa".equals(tipoEntrega) ? "selected" : ""%>>Completa</option>
                                    <option value="Parcial" <%= "Parcial".equals(tipoEntrega) ? "selected" : ""%>>Parcial</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="estado">Estado:</label></td>
                            <td>
                                <select name="estado" class="select-estado" id="estadoGeneral" required>
                                    <option value="">Seleccionar un estado</option>
                                    <% while (estados.next()) {
                                            String estado = estados.getString("estado");
                                    %>
                                    <option value="<%= estado%>" <%= estado.equals(estadoSeleccionado) ? "selected" : ""%>><%= estado%></option>
                                    <% }
                                        estados.close(); %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="unidad_negocio">Unidad de negocio:</label></td>
                            <td>
                                <select name="unidad_negocio" class="select-unidad" id="unidadGeneral" required>
                                    <option value="">Seleccione una unidad</option>
                                    <% while (unidades.next()) {
                                            String unidad = unidades.getString("unidad_negocio");
                                    %>
                                    <option value="<%= unidad%>" <%= unidad.equals(unidadSeleccionada) ? "selected" : ""%>><%= unidad%></option>
                                    <% }
                                        unidades.close();%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="observacion">Observación:</label></td>
                            <td><input type="text" name="observacion" value="<%= observacion%>"></td>
                        </tr>
                    </tbody>
                </table>

                <table class="table" id="tablaDotacion">
                    <thead>
                        <tr>
                            <th>Tipo de prenda</th>
                            <th>Prenda</th>
                            <th>Talla</th>
                            <th>
                                <button type="button" onclick="agregarFila()">
                                    <img src="../presentacion/iconos/agregar.png" alt="Agregar" width="24" height="24">
                                </button>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if ("Modificar".equals(accion) && detallesEntrega != null && !detallesEntrega.isEmpty()) {
                                for (DetalleEntrega d : detallesEntrega) {
                                    String tipoPrendaSeleccionado = "";
                                    for (Prenda p : listaPrendas) {
                                        if (p.getIdPrenda().equals(d.getIdPrenda())) {
                                            tipoPrendaSeleccionado = p.getIdTipoPrenda();
                                            break;
                                        }
                                    }
                        %>
                        <tr class="fila-dotacion">
                            <td>
                                <select class="select-tipo" name="id_tipo_prenda[]" required onchange="cargarPrendas(this)">
                                    <option value="">Seleccione</option>
                                    <% for (Prenda prenda : listaPrendas) {
                                            String tipo = prenda.getIdTipoPrenda();
                                            String nombreTipo = prenda.getNombreTipoPrenda();
                                            boolean seleccionado = tipo.equals(tipoPrendaSeleccionado);
                                    %>
                                    <option value="<%= tipo%>" <%= seleccionado ? "selected" : ""%>><%= nombreTipo%></option>
                                    <% } %>
                                </select>
                            </td>
                            <td>
                                <select name="id_prenda[]" class="select-prenda" required onchange="cargarTallas(this)">
                                    <option value="">Seleccionar</option>
                                    <% for (Prenda prenda : listaPrendas) {
                                            boolean seleccionado = prenda.getIdPrenda().equals(d.getIdPrenda());
                                    %>
                                    <option value="<%= prenda.getIdPrenda()%>" <%= seleccionado ? "selected" : ""%>><%= prenda.getNombre()%></option>
                                    <% }%>
                                </select>
                            </td>
                            <td>
                                <select name="talla[]" class="input-talla" required>
                                    <option value="<%= d.getTalla()%>" selected><%= d.getTalla()%></option>
                                </select>
                            </td>
                            <td>
                                <button type="button" class="fila-icono" onclick="eliminarFila(this)">
                                    <img src="../presentacion/iconos/eliminar.png" alt="Eliminar" width="24" height="24">
                                </button>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <!-- Fila vacía si es nueva entrega -->
                        <tr class="fila-dotacion">
                            <td>
                                <select class="select-tipo" name="id_tipo_prenda[]" required onchange="cargarPrendas(this)">
                                    <option value="">Seleccione</option>
                                </select>
                            </td>
                            <td>
                                <select name="id_prenda[]" class="select-prenda" required onchange="cargarTallas(this)">
                                    <option value="">Seleccionar</option>
                                </select>
                            </td>
                            <td>
                                <select name="talla[]" class="input-talla" required>
                                    <option value="">Seleccione talla</option>
                                </select>
                            </td>
                            <td>
                                <button type="button" class="fila-icono" onclick="eliminarFila(this)">
                                    <img src="../presentacion/iconos/eliminar.png" alt="Eliminar" width="24" height="24">
                                </button>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
                <input type="hidden" name="idPersona" value="<%= idPersona%>">
                <div class="botones-form">
                    <button type="submit" class="btn-verde">Guardar</button>
                    <a href="historialDotacion.jsp?identificacion=<%= request.getParameter("identificacion")%>" class="btn-rojo">Cancelar</a>
                </div>
            </form>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById("estadoGeneral").addEventListener("change", function () {
                    actualizarSelectoresExistentes();
                });
                document.getElementById("unidadGeneral").addEventListener("change", function () {
                    actualizarSelectoresExistentes();
                });

                function actualizarSelectoresExistentes() {
                    const estado = document.getElementById("estadoGeneral").value;
                    const unidad = document.getElementById("unidadGeneral").value;

                    if (estado && unidad) {
                        const filas = document.querySelectorAll(".fila-dotacion");
                        filas.forEach(fila => {
                            const tipoSelect = fila.querySelector(".select-tipo");
                            const prendaSelect = fila.querySelector(".select-prenda");
                            const tallaSelect = fila.querySelector(".input-talla");
                            tipoSelect.innerHTML = '<option value="">Cargando...</option>';
                            fetch("entregaDotacion.jsp?ajax_tipos_por_estado=" + encodeURIComponent(estado) + "&ajax_unidad=" + encodeURIComponent(unidad))
                                    .then(res => res.json())
                                    .then(data => {
                                        tipoSelect.innerHTML = '<option value="">Seleccionar tipo</option>';
                                        data.forEach(tipo => {
                                            const opt = document.createElement("option");
                                            opt.value = tipo.id_tipo;
                                            opt.textContent = tipo.nombre;
                                            tipoSelect.appendChild(opt);
                                        });
                                    })
                                    .catch(() => {
                                        tipoSelect.innerHTML = '<option value="">Error al cargar tipos</option>';
                                    });
                        });
                    }
                }

                // Función para agregar nuevas filas
                function agregarFila() {
                    const filaBase = document.querySelector(".fila-dotacion");
                    const nuevaFila = filaBase.cloneNode(true);

                    nuevaFila.querySelectorAll("select").forEach(select => {
                        select.value = "";
                        select.innerHTML = '<option value="">Seleccionar</option>';
                    });

                    const tipoSelect = nuevaFila.querySelector(".select-tipo");
                    const prendaSelect = nuevaFila.querySelector(".select-prenda");
                    const tallaSelect = nuevaFila.querySelector(".input-talla");

                    const estado = document.getElementById("estadoGeneral").value;
                    const unidad = document.getElementById("unidadGeneral").value;

                    if (estado && unidad) {
                        tipoSelect.innerHTML = '<option value="">Cargando...</option>';
                        fetch("entregaDotacion.jsp?ajax_tipos_por_estado=" + encodeURIComponent(estado) + "&ajax_unidad=" + encodeURIComponent(unidad))
                                .then(res => res.json())
                                .then(data => {
                                    tipoSelect.innerHTML = '<option value="">Seleccionar tipo</option>';
                                    data.forEach(tipo => {
                                        const opt = document.createElement("option");
                                        opt.value = tipo.id_tipo;
                                        opt.textContent = tipo.nombre;
                                        tipoSelect.appendChild(opt);
                                    });
                                })
                                .catch(() => {
                                    tipoSelect.innerHTML = '<option value="">Error al cargar tipos</option>';
                                });
                    }

                    tipoSelect.addEventListener("change", function () {
                        cargarPrendas(this);
                    });

                    prendaSelect.addEventListener("change", function () {
                        cargarTallas(this);
                    });

                    document.querySelector("#tablaDotacion tbody").appendChild(nuevaFila);
                }

                // Función para eliminar una fila
                function eliminarFila(btn) {
                    const fila = btn.closest("tr");
                    const tbody = document.querySelector("#tablaDotacion tbody");
                    if (tbody.rows.length > 1)
                        fila.remove();
                }

                // Función para cargar prendas según tipo de prenda
                function cargarPrendas(selectTipo) {
                    const fila = selectTipo.closest("tr");
                    const prendaSelect = fila.querySelector(".select-prenda");
                    const estado = document.getElementById("estadoGeneral").value;
                    const unidad = document.getElementById("unidadGeneral").value;
                    const tipo = selectTipo.value;

                    prendaSelect.innerHTML = '<option value="">Cargando...</option>';

                    if (tipo && estado && unidad) {
                        fetch("entregaDotacion.jsp?ajax_tipo_prenda=" + tipo + "&ajax_estado=" + encodeURIComponent(estado) + "&ajax_unidad=" + encodeURIComponent(unidad))
                                .then(res => res.json())
                                .then(data => {
                                    prendaSelect.innerHTML = '<option value="">Seleccionar prenda</option>';
                                    data.forEach(p => {
                                        const opt = document.createElement("option");
                                        opt.value = p.id_prenda;
                                        opt.textContent = p.nombre;
                                        prendaSelect.appendChild(opt);
                                    });
                                })
                                .catch(() => {
                                    prendaSelect.innerHTML = '<option value="">Error al cargar prendas</option>';
                                });
                    } else {
                        prendaSelect.innerHTML = '<option value="">Seleccionar</option>';
                    }
                }

                // Función para cargar tallas según prenda seleccionada
                function cargarTallas(selectPrenda) {
                    const fila = selectPrenda.closest("tr");
                    const idPrenda = selectPrenda.value;
                    const estado = document.getElementById("estadoGeneral").value;
                    const unidad = document.getElementById("unidadGeneral").value;
                    const selectTalla = fila.querySelector(".input-talla");

                    selectTalla.innerHTML = '<option value="">Cargando...</option>';

                    if (idPrenda && estado && unidad) {
                        fetch("entregaDotacion.jsp?ajax_id_prenda=" + idPrenda + "&ajax_estado=" + encodeURIComponent(estado) + "&ajax_unidad=" + encodeURIComponent(unidad))
                                .then(response => response.json())
                                .then(data => {
                                    selectTalla.innerHTML = '<option value="">Seleccione talla</option>';
                                    data.valores.forEach(talla => {
                                        const option = document.createElement("option");
                                        option.value = talla;
                                        option.textContent = talla;
                                        selectTalla.appendChild(option);
                                    });
                                })
                                .catch(() => {
                                    selectTalla.innerHTML = '<option value="">Error al cargar tallas</option>';
                                });
                    } else {
                        selectTalla.innerHTML = '<option value="">Seleccione talla</option>';
                    }
                }

                window.agregarFila = agregarFila;
                window.eliminarFila = eliminarFila;
                window.cargarPrendas = cargarPrendas;
                window.cargarTallas = cargarTallas;
            });

        </script>
    </body>
</html>