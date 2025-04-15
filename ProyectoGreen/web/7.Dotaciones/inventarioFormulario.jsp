<%-- 
    Document   : inventarioFormulario
    Created on : 11 abr 2025
    Author     : Angie
--%>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="clasesGenericas.ConectorBD" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Manejo de petición AJAX para cargar prendas según tipo de prenda
    String tipoPrendaAjax = request.getParameter("ajax_tipo_prenda");
    if (tipoPrendaAjax != null) {
        response.setContentType("application/json");
        ResultSet rsPrendas = ConectorBD.consultar(
            "SELECT id_prenda, nombre FROM prenda WHERE id_tipo_prenda = '" + tipoPrendaAjax + "'"
        );

        StringBuilder json = new StringBuilder("[");
        boolean primero = true;
        while (rsPrendas.next()) {
            if (!primero) json.append(",");
            json.append("{\"idPrenda\":\"")
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
    <link rel="stylesheet" href="../presentacion/style-Inventario.css" />
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #333;
            text-align: center;
        }
        .botones-form {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }
        .btn-verde {
            background-color: #2e7d32;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
        }
        .btn-rojo {
            background-color: #c62828;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
        }
        .titulo {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #1b5e20;
        }
        .fila-icono {
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="content">
    <h3 class="titulo">Agregar dotación nueva</h3>

    <form action="InventarioServlet" method="post">
        <input type="hidden" name="accion" value="Guardar">

        <div style="text-align: center; margin-bottom: 20px;">
            <label for="fechaIngreso">Fecha de ingreso:</label>
            <input type="date" name="fechaIngreso" required />
        </div>

        <table id="tablaDotacion">
            <thead>
                <tr>
                    <th>Tipo de prenda</th>
                    <th>Prenda</th>
                    <th>Talla</th>
                    <th>Cantidad existente</th>
                    <th>
                        <button type="button" onclick="agregarFila()">➕</button>
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr class="fila-dotacion">
                    <td>
                        <select class="recuadro" name="id_tipo_prenda" required onchange="cargarPrendas(this)">
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
                        <select name="idPrenda">
                            <option value="">Seleccionar</option>
                        </select>
                    </td>
                    <td>
                        <select name="talla">
                            <option value="U">U</option>
                            <option value="XS">XS</option>
                            <option value="S">S</option>
                            <option value="M">M</option>
                            <option value="L">L</option>
                            <option value="XL">XL</option>
                        </select>
                    </td>
                    <td>
                        <input type="number" name="cantidad" min="1" value="1" />
                    </td>
                    <td>
                        <button type="button" class="fila-icono" onclick="eliminarFila(this)">🗑️</button>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="botones-form">
            <button type="submit" class="btn-verde">Guardar</button>
            <a href="inventarioDotacion.jsp" class="btn-rojo">Cancelar</a>
        </div>
    </form>
</div>

<script>
    function agregarFila() {
        const tabla = document.getElementById("tablaDotacion").getElementsByTagName("tbody")[0];
        const filaBase = document.querySelector(".fila-dotacion");
        const nuevaFila = filaBase.cloneNode(true);

        // Limpiar valores
        nuevaFila.querySelector("select[name='id_tipo_prenda']").value = "";
        nuevaFila.querySelector("select[name='idPrenda']").innerHTML = '<option value="">Seleccionar</option>';
        nuevaFila.querySelector("select[name='talla']").value = "U";
        nuevaFila.querySelector("input[name='cantidad']").value = 1;

        // Reasignar evento onchange
        nuevaFila.querySelector("select[name='id_tipo_prenda']").addEventListener("change", function () {
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
        const prendaSelect = fila.querySelector("select[name='idPrenda']");
        const tipoPrenda = selectTipo.value;

        if (tipoPrenda) {
            fetch("inventarioFormulario.jsp?ajax_tipo_prenda=" + tipoPrenda)
                .then(response => response.json())
                .then(data => {
                    prendaSelect.innerHTML = '<option value="">Seleccionar</option>';
                    data.forEach(prenda => {
                        prendaSelect.innerHTML += `<option value="${prenda.idPrenda}">${prenda.nombre}</option>`;
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

    // Asignar evento a la fila base al cargar
    document.addEventListener("DOMContentLoaded", function () {
        const selectBase = document.querySelector("select[name='id_tipo_prenda']");
        if (selectBase) {
            selectBase.addEventListener("change", function () {
                cargarPrendas(this);
            });
        }
    });
</script>
</body>
</html>
