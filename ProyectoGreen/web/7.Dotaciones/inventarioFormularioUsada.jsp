<%-- 
    Document   : inventarioFormularioUsada
    Created on : 23 abr 2025, 15:20:39
    Author     : Angie
--%>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="clasesGenericas.ConectorBD" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String accion = request.getParameter("accion");
    String tipoPrendaAjax = request.getParameter("ajax_tipo_prenda");
    if (tipoPrendaAjax != null) {
        response.setContentType("application/json");
        ResultSet rsPrendas = ConectorBD.consultar(
                "SELECT id_prenda, nombre FROM prenda WHERE id_tipo_prenda = " + tipoPrendaAjax
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
%>

<jsp:include page="../menu.jsp" />

<html>
    <head>
        <link rel="stylesheet" href="../presentacion/style-Cargos.css">
        <link rel="stylesheet" href="../presentacion/style-DotacionFormularios.css" />
    </head>
    <body>
        <div class="content">
            <h3 class="titulo">Agregar dotación utilizada</h3>
            <form action="inventarioActualizarUsada.jsp" method="post">
                <input type="hidden" name="accion" value="Actualizar">

                <div style="text-align: center; margin-bottom: 20px;">
                    <label for="fecha_ingreso">Fecha de ingreso:</label>
                    <input type="date" name="fecha_ingreso" required />
                </div>

                <div style="text-align: center; margin-bottom: 20px;">
                    <label for="unidad_negocio">Unidad de negocio:</label>
                    <select name="unidad_negocio" required>
                        <option value="">Seleccione una unidad</option>
                        <option value="EDS">EDS</option>
                        <option value="RPS">RPS</option>
                        <option value="DP">DP</option>
                        <option value="CONGUSTO">CONGUSTO</option>
                    </select>
                </div>

                <table class="table" id="tablaDotacion">
                    <thead>
                        <tr>
                            <th>Tipo de prenda</th>
                            <th>Prenda</th>
                            <th>Tipo de medida</th>
                            <th>Cantidad existente</th>
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
                                <select class="recuadro select-tipo" name="id_tipo_prenda[]" required onchange="cargarPrendas(this)">
                                    <option value="">Seleccione una opción</option>
                                    <%
                                        ResultSet tipos = ConectorBD.consultar("SELECT id_tipo_prenda, nombre FROM tipoPrenda");
                                        while (tipos.next()) {
                                            String idTipo = tipos.getString("id_tipo_prenda");
                                            String nombreTipo = tipos.getString("nombre");
                                    %>
                                    <option value="<%=idTipo%>"><%=nombreTipo%></option>
                                    <%
                                        }
                                        tipos.close();
                                    %>
                                </select>
                            </td>
                            <td>
                                <select name="id_prenda[]" class="select-prenda">
                                    <option value="">Seleccionar</option>
                                </select>
                            </td>
                            <td>
                                <select class="tipo-medida" onchange="cambiarMedida(this)">
                                    <option value="">Seleccione tipo</option>
                                    <option value="TALLA">Talla (S, M, L...)</option>
                                    <option value="NUMERO">Número (36, 38...)</option>
                                </select>
                                <div class="opciones-medida">
                                    <select name="talla[]" class="input-talla" style="display: none;">
                                        <option value="">Seleccione la talla</option>
                                        <option value="U">U</option>
                                        <option value="XS">XS</option>
                                        <option value="S">S</option>
                                        <option value="M">M</option>
                                        <option value="L">L</option>
                                        <option value="XL">XL</option>
                                        <option value="XXL">XXL</option>
                                    </select>
                                    <input type="text" name="talla[]" class="input-numero" style="display: none;" placeholder="Digite el número aquí" />
                                </div>
                            </td>

                            <td>
                                <input type="number" name="cantidad[]" min="1" value="1" />
                                <input type="hidden" name="estado[]" value="Usada" />
                            </td>
                            <td>
                                <button type="button" class="fila-icono" onclick="eliminarFila(this)">
                                    <img src="../presentacion/iconos/eliminar.png" alt="Eliminar" style="width: 24px; height: 24px;">
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="botones-form">
                    <button type="submit" class="btn-verde">Guardar</button>
                    <a href="inventarioDotacionUsada.jsp" class="btn-rojo">Cancelar</a>
                </div>
            </form>
        </div>

        <script>
            function agregarFila() {
                const tabla = document.getElementById("tablaDotacion").getElementsByTagName("tbody")[0];
                const filaBase = document.querySelector(".fila-dotacion");
                const nuevaFila = filaBase.cloneNode(true);

                nuevaFila.querySelector(".select-tipo").value = "";
                nuevaFila.querySelector(".select-prenda").innerHTML = '<option value="">Seleccionar</option>';
                nuevaFila.querySelector("select[name='talla[]']").value = "";
                nuevaFila.querySelector("input[name='cantidad[]']").value = 1;
                nuevaFila.querySelector(".input-numero").value = "";
                nuevaFila.querySelector(".tipo-medida").value = "";
                nuevaFila.querySelector(".input-talla").style.display = "none";
                nuevaFila.querySelector(".input-numero").style.display = "none";

                nuevaFila.querySelector(".select-tipo").addEventListener("change", function () {
                    cargarPrendas(this);
                });

                tabla.appendChild(nuevaFila);
            }

            function eliminarFila(btn) {
                const fila = btn.closest("tr");
                const tabla = document.getElementById("tablaDotacion").getElementsByTagName("tbody")[0];
                if (tabla.rows.length > 1) {
                    fila.remove();
                }
            }

            function cargarPrendas(selectTipo) {
                const fila = selectTipo.closest("tr");
                const prendaSelect = fila.querySelector(".select-prenda");
                const tipoPrenda = selectTipo.value;

                prendaSelect.innerHTML = '<option value="">Cargando...</option>';

                if (tipoPrenda) {
                    fetch("inventarioFormulario.jsp?ajax_tipo_prenda=" + tipoPrenda)
                            .then(response => response.json())
                            .then(data => {
                                prendaSelect.innerHTML = '<option value="">Seleccionar</option>';
                                data.forEach(prenda => {
                                    const option = document.createElement("option");
                                    option.value = prenda.id_prenda;
                                    option.textContent = prenda.nombre;
                                    prendaSelect.appendChild(option);
                                });
                            })
                            .catch(error => {
                                console.error("Error al cargar prendas:", error);
                                prendaSelect.innerHTML = '<option value="">Error al cargar</option>';
                            });
                } else {
                    prendaSelect.innerHTML = '<option value="">Seleccionar</option>';
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                const selectBase = document.querySelector(".select-tipo");
                if (selectBase) {
                    selectBase.addEventListener("change", function () {
                        cargarPrendas(this);
                    });
                }
            });

            function cambiarMedida(select) {
                const fila = select.closest("td");
                const talla = fila.querySelector(".input-talla");
                const numero = fila.querySelector(".input-numero");

                if (select.value === "TALLA") {
                    talla.style.display = "inline-block";
                    talla.disabled = false;

                    numero.style.display = "none";
                    numero.disabled = true;
                    numero.value = "";
                } else if (select.value === "NUMERO") {
                    numero.style.display = "inline-block";
                    numero.disabled = false;

                    talla.style.display = "none";
                    talla.disabled = true;
                    talla.selectedIndex = 0;
                } else {
                    talla.style.display = "none";
                    talla.disabled = true;
                    talla.selectedIndex = 0;

                    numero.style.display = "none";
                    numero.disabled = true;
                    numero.value = "";
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll(".select-tipo").forEach(el => {
                    el.addEventListener("change", function () {
                        cargarPrendas(this);
                    });
                });

                document.querySelectorAll(".tipo-medida").forEach(el => {
                    el.addEventListener("change", function () {
                        cambiarMedida(this);
                    });
                });
            });

        </script>
    </body>
</html>

