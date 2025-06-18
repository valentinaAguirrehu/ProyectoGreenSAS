<%-- 
    Document   : prenda
    Created on : 10 abr 2025, 14:59:08
    Author     : Angie
--%>

<%@page import="clases.Prenda"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.Administrador"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    // Agrupar prendas por tipo
    Map<String, List<Prenda>> prendasPorTipo = new LinkedHashMap<>();
    List<Prenda> prendas = Prenda.getListaEnObjetos(null, "tp.nombre");

    for (Prenda prenda : prendas) {
        String tipo = prenda.getNombreTipoPrenda();
        if (!prendasPorTipo.containsKey(tipo)) {
            prendasPorTipo.put(tipo, new ArrayList<Prenda>());
        }
        prendasPorTipo.get(tipo).add(prenda);
    }
%>

<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>

<head>
    <link rel="stylesheet" href="../presentacion/style-Cargos.css">
    <style>
        .tipo-header {
            background-color: #f2f2f2;
            cursor: pointer;
            color: #145a32;
            padding: 10px;
            font-weight: bold;
            font-size: 18px;
            border-radius: 5px;
        }

        .prendas-body {
            display: none;
        }

        .prendas-body.active {
            display: table-row-group;
        }

        .titulo {
            margin-bottom: 20px;
        }

        .agregar-btn {
            float: right;
        }
    </style>
</head>
<body>
    <div class="content">
        <h3 class="titulo">GESTIÓN DE PRENDAS
            <a href="prendaFormulario.jsp?accion=Adicionar" class="agregar-btn" title="Adicionar">
                <img src="../presentacion/iconos/agregar.png" width='30' height='30'>
            </a>
        </h3>

        <div class="search-container">
            <div class="search-box">
                <input type="text" id="searchInput" onkeyup="filterNames()" placeholder="Buscar por prenda o tipo de prenda" class="recuadro">
                <img src="../presentacion/iconos/lupa.png" alt="Buscar">
            </div>
        </div>

        <table class="table" border="1" id="prendasTable">
            <thead>
                <tr>
                    <th>Prenda</th>
                    <th>
                        <a href="prendaFormulario.jsp?accion=Adicionar" class="subir" title="Adicionar">
                            <img src="../presentacion/iconos/agregar.png" width='30' height='30'>
                        </a>
                    </th>
                </tr>
            </thead>

            <tbody>
                <% for (Map.Entry<String, List<Prenda>> entry : prendasPorTipo.entrySet()) {%>
                <tr class="tipo-header" onclick="toggleCategoria('<%= entry.getKey().replaceAll("\\s+", "")%>')">
                    <td colspan="2">+ <%= entry.getKey()%></td>
                </tr>
            <tbody id="body-<%= entry.getKey().replaceAll("\\s+", "")%>" class="prendas-body">
                <% for (Prenda prenda : entry.getValue()) {%>
                <tr>
                    <td><%= prenda.getNombre()%></td>
                    <td class="acciones">
                        <a class="editar" href="prendaFormulario.jsp?accion=Modificar&id=<%= prenda.getIdPrenda()%>" title="Modificar"><img src="../presentacion/iconos/modificar.png" width="25" height="25"></a>
                        <a><img src="../presentacion/iconos/eliminar.png" class="eliminar" width="25" height="25" title="Eliminar"onclick="eliminar('<%= prenda.getIdPrenda()%>')"></a>
                    </td>
                </tr>
                <% } %>
            </tbody>
            <% }%>
            </tbody>
        </table>
    </div>

    <script>
        function eliminar(id) {
            if (confirm("¿Realmente desea eliminar la prenda?")) {
                document.location = "prendaActualizar.jsp?accion=Eliminar&id=" + id;
            }
        }

        function toggleCategoria(id) {
            const cuerpo = document.getElementById("body-" + id);
            cuerpo.classList.toggle("active");
        }

        function filterNames() {
            const input = document.getElementById('searchInput').value.toLowerCase();
            const secciones = document.querySelectorAll('.prendas-body');
            const headers = document.querySelectorAll('.tipo-header');

            secciones.forEach((section, index) => {
                let visible = false;
                section.querySelectorAll('tr').forEach(row => {
                    const text = row.textContent.toLowerCase();
                    const match = text.includes(input);
                    row.style.display = match ? "" : "none";
                    if (match)
                        visible = true;
                });
                section.style.display = visible ? "table-row-group" : "none";
                headers[index].style.display = visible ? "" : "none";
            });
        }

        document.addEventListener("DOMContentLoaded", function () {
            controlarPermisos(
        <%= administrador.getpEliminar()%>,
        <%= administrador.getpEditar()%>,
        <%= administrador.getpAgregar()%>
            );
        });
    </script>
</body>
