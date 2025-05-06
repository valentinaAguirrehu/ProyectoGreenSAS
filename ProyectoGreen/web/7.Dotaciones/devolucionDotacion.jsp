<%-- 
    Document   : devolucionDotacion
    Created on : 29 abr 2025, 16:52:20
    Author     : Angie
--%>

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

    String tipoPrendaAjax = request.getParameter("ajax_tipo_prenda");
    String estadoAjax = request.getParameter("ajax_estado");
    if (tipoPrendaAjax != null && estadoAjax != null && request.getParameter("ajax_id_prenda") == null) {
        response.setContentType("application/json");

        ResultSet rsPrendas = ConectorBD.consultar(
                "SELECT DISTINCT p.id_prenda, p.nombre FROM prenda p "
                + "JOIN detalleEntrega de ON p.id_prenda = de.id_prenda "
                + "JOIN entregaDotacion ed ON de.id_entrega = ed.id_entrega "
                + "WHERE p.id_tipo_prenda = " + tipoPrendaAjax
                + " AND de.estado = '" + estadoAjax + "' "
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

    String tiposPorEstado = request.getParameter("ajax_tipos_por_estado");
    if (tiposPorEstado != null) {
        response.setContentType("application/json");

        ResultSet rsTipos = ConectorBD.consultar(
                "SELECT DISTINCT tp.id_tipo_prenda, tp.nombre "
                + "FROM tipoPrenda tp "
                + "JOIN prenda p ON tp.id_tipo_prenda = p.id_tipo_prenda "
                + "JOIN inventarioDotacion i ON p.id_prenda = i.id_prenda "
                + "WHERE i.estado = '" + tiposPorEstado + "' "
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

    String idPrendaAjax = request.getParameter("ajax_id_prenda");
    if (idPrendaAjax != null && estadoAjax != null) {
        response.setContentType("application/json");

        ResultSet rsTallas = ConectorBD.consultar(
                "SELECT DISTINCT talla FROM inventarioDotacion "
                + "WHERE id_prenda = " + idPrendaAjax
                + " AND estado = '" + estadoAjax + "' "
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

    ResultSet estados = ConectorBD.consultar("SELECT DISTINCT estado FROM inventarioDotacion ORDER BY estado");
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
                <div style="text-align: center; margin-bottom: 20px;">
                    <label for="fechaDevolucion">Fecha de devolución:</label>
                    <input type="date" name="fechaDevolucion" required>
                </div>
                <div style="text-align: center; margin-bottom: 20px;">
                    <label for="tipoEntrega">Tipo de entrega:</label>
                    <select name="tipoEntrega" required>
                        <option value="">Seleccione tipo</option>
                        <option value="Completa">Completa</option>
                        <option value="Parcial">Parcial</option>
                    </select>
                </div>
                

                <table class="table" id="tablaDotacion">
                    <thead>
                        <tr>
                            <th>Estado</th>
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
                        <tr class="fila-dotacion">
                            <td>
                                <select name="estado[]" class="select-estado" required onchange="cargarTiposDesdeEstado(this)">
                                    <option value="">Seleccionar</option>
                                    <%
                                        while (estados.next()) {
                                    %>
                                    <option value="<%=estados.getString("estado")%>"><%=estados.getString("estado")%></option>
                                    <%
                                        }
                                        estados.close();
                                    %>
                                </select>
                            </td>
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
                    </tbody>
                    <input type="hidden" name="idPersona" value="<%= idPersona != null ? idPersona : ""%>">
                </table>

                <div class="botones-form">
                    <button type="submit" class="btn-verde">Guardar</button>
                    <a href="historialDotacion.jsp?identificacion=<%= identificacion%>" class="btn-rojo">Cancelar</a>
                </div>
            </form>
        </div>

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
                nuevaFila.querySelector(".select-estado").addEventListener("change", function () {
                    cargarTallasDesdeEstado(this);
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
                const estado = fila.querySelector(".select-estado").value;
                const idPersona = "<%= idPersona != null ? idPersona : ""%>";

                prendaSelect.innerHTML = '<option value="">Cargando...</option>';

                if (selectTipo.value && estado) {
                    fetch("devolucionDotacion.jsp?ajax_tipo_prenda=" + selectTipo.value + "&ajax_estado=" + encodeURIComponent(estado) + "&idPersona=" + idPersona)
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
                const estado = fila.querySelector("select[name='estado[]']").value;
                const selectTalla = fila.querySelector(".input-talla");

                selectTalla.innerHTML = '<option value="">Cargando...</option>';

                if (idPrenda) {
                    fetch("devolucionDotacion.jsp?ajax_id_prenda=" + idPrenda + "&ajax_estado=" + encodeURIComponent(estado))
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

            function cargarTiposDesdeEstado(selectEstado) {
                const fila = selectEstado.closest("tr");
                const tipoSelect = fila.querySelector(".select-tipo");
                const estado = selectEstado.value;

                tipoSelect.innerHTML = '<option value="">Cargando...</option>';

                if (estado) {
                    fetch("devolucionDotacion.jsp?ajax_tipos_por_estado=" + encodeURIComponent(estado))
                            .then(res => res.json())
                            .then(data => {
                                tipoSelect.innerHTML = '<option value="">Seleccione</option>';
                                data.forEach(t => {
                                    const opt = document.createElement("option");
                                    opt.value = t.id_tipo;
                                    opt.textContent = t.nombre;
                                    tipoSelect.appendChild(opt);
                                });
                            })
                            .catch(() => {
                                tipoSelect.innerHTML = '<option value="">Error al cargar tipos de prenda</option>';
                            });
                } else {
                    tipoSelect.innerHTML = '<option value="">Seleccione</option>';
                }
            }
        </script>

    </body>
</html>
