<%-- 
    Document   : inventarioDotacion
    Created on : 10 abr 2025, 17:35:51
    Author     : Angie
--%>

<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.Prenda"%>
<%@page import="clases.InventarioDotacion"%>
<%@page import="java.util.List"%>
<%@page import="clases.Administrador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    // Agrupar registros por tipo de prenda
    LinkedHashMap<String, List<String>> mapa = new LinkedHashMap<>();
    List<InventarioDotacion> inventario = InventarioDotacion.getListaEnObjetos("estado = 'Nueva'", "fecha_ingreso DESC");

    if (inventario != null && !inventario.isEmpty()) {
        for (InventarioDotacion inv : inventario) {
            Prenda prenda = new Prenda(inv.getIdPrenda());
            String tipo = prenda.getNombreTipoPrenda();
            String fila = "<tr>"
                    + "<td>" + inv.getFechaIngreso() + "</td>"
                    + "<td>" + prenda.getNombre() + "</td>"
                    + "<td>" + inv.getTalla() + "</td>"
                    + "<td>" + inv.getCantidad() + "</td>"
                    + "<td>" + inv.getUnidadNegocio() + "</td>"
                    + "</tr>";
            if (!mapa.containsKey(tipo)) {
                mapa.put(tipo, new ArrayList<String>());
            }
            mapa.get(tipo).add(fila);
        }
    }

%>

<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>

<head>
    <link rel="stylesheet" href="../presentacion/style-Cargos.css">
    <link rel="stylesheet" href="../presentacion/style-Inventario.css">
</head>

<body>
    <div class="content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin: 20px 0; position: relative;">

            <div style="width: 13%;"></div>
            <h3 class="titulo" style="text-align: center; width: 34%; margin: 0;">INVENTARIO DE DOTACIÓN NUEVA</h3>

            <div style="margin-top: 30px;">
                <a href="inventarioFormulario.jsp?accion=Adicionar" class="subir" style="display: inline-flex; align-items: center; gap: 6px;">
                    <img src="../presentacion/iconos/agregar.png" width="16" height="16" alt="Agregar">
                    Agregar prendas
                </a>
            </div>
        </div>

        <div class="search-container">
            <div class="search-box">
                <input type="text" id="searchInput" onkeyup="filtrarContenido()" placeholder="Buscar prenda ..." class="recuadro">
                <img src="../presentacion/iconos/lupa.png" alt="Buscar">
            </div>
        </div>

        <% if (mapa.isEmpty()) { %>
        <p style="text-align: center;">No se encontraron registros</p>
        <% } else { %>
        <div class="tabs">
            <%
                int contador = 0;
                for (String tipo : mapa.keySet()) {
                    String id = "tab_" + contador;
            %>
            <button class="tab-btn <%= contador == 0 ? "active" : ""%>" onclick="mostrarTab('<%= id%>')"><%= tipo%></button>
            <% contador++;
                } %>
        </div>

        <%
            contador = 0;
            for (String tipo : mapa.keySet()) {
                String id = "tab_" + contador;
        %>
        <div class="tab-content <%= contador == 0 ? "active" : ""%>" id="<%= id%>">
            <table>
                <thead>
                    <tr>
                        <th>Última fecha de ingreso</th>
                        <th>Prenda</th>        
                        <th>Talla</th>
                        <th>Cantidad</th>
                        <th>Unidad de negocio</th>
                    </tr>
                </thead>
                <tbody>
                    <%= String.join("", mapa.get(tipo))%>
                </tbody>
            </table>
        </div>
        <% contador++;
            } %>
        <% }%>
    </div>
</body>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        controlarPermisos(
    <%= administrador.getpEliminar()%>,
    <%= administrador.getpEditar()%>,
    <%= administrador.getpAgregar()%>
        );
    });

    function mostrarTab(id) {
        const tabs = document.querySelectorAll('.tab-content');
        const buttons = document.querySelectorAll('.tab-btn');

        tabs.forEach(tab => {
            tab.classList.remove('active');
        });

        buttons.forEach(btn => {
            btn.classList.remove('active');
        });

        document.getElementById(id).classList.add('active');
        event.target.classList.add('active');
    }

    let ultimoValorBuscado = "";

    function filtrarContenido() {
        const input = document.getElementById('searchInput').value.toLowerCase().trim();
        const tabs = document.querySelectorAll('.tab-content');
        const buttons = document.querySelectorAll('.tab-btn');

        // Si el usuario borró todo el texto y antes había escrito algo, recargar la página
        if (input === "" && ultimoValorBuscado !== "") {
            location.reload();
            return;
        }

        // Actualizar el valor buscado
        ultimoValorBuscado = input;

        if (input === "") {
            // Restaurar estado inicial
            tabs.forEach((tab, i) => {
                if (i === 0) {
                    tab.classList.add('active');
                    tab.style.display = "";
                } else {
                    tab.classList.remove('active');
                    tab.style.display = "none";
                }

                // Mostrar todas las filas
                const rows = tab.querySelectorAll("tbody tr");
                rows.forEach(row => row.style.display = "");
            });

            buttons.forEach((btn, i) => {
                if (i === 0) {
                    btn.classList.add('active');
                } else {
                    btn.classList.remove('active');
                }
            });

            return;
        }

        // Mostrar todas las pestañas y aplicar filtro global
        tabs.forEach(tab => {
            tab.classList.add('active');
            tab.style.display = "";
            const rows = tab.querySelectorAll("tbody tr");
            let hasMatch = false;

            rows.forEach(row => {
                const text = row.innerText.toLowerCase();
                const match = text.includes(input);
                row.style.display = match ? "" : "none";
                if (match)
                    hasMatch = true;
            });

            // Ocultar pestaña si no tiene coincidencias
            tab.style.display = hasMatch ? "" : "none";
        });

        // Quitar estado activo de los botones de pestañas
        buttons.forEach(btn => btn.classList.remove('active'));
    }


</script>
