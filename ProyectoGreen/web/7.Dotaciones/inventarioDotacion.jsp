<%-- 
    Document   : inventarioDotacion
    Created on : 10 abr 2025, 17:35:51
    Author     : Angie
--%>

<%@page import="clases.FechaProxEntregaDotacion"%>
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
    List<InventarioDotacion> inventario = InventarioDotacion.getListaEnObjetos(null, "fecha_ingreso DESC");

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

    String idFecha = "1"; 
    FechaProxEntregaDotacion fechas = new FechaProxEntregaDotacion(idFecha);
    String fechaAdmin = fechas.getFecha_admin();
    String fechaOperativo = fechas.getFecha_operativo();
%>

<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>

<head>
    <link rel="stylesheet" href="../presentacion/style-Cargos.css">
    <link rel="stylesheet" href="../presentacion/style-Inventario.css">
</head>

<body>
    <div class="content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin: 20px 0;">

            <div style="background-color: #e6f0e6; border: 1px solid #4a944a; border-radius: 8px; padding: 15px 20px; font-size: 16px;">
                <strong style="color: #2d602d;">Próxima entrega de dotación:</strong><br>
                Administrativo: <%= fechaAdmin != null ? fechaAdmin : "Sin registro"%><br>
                Operativo: <%= fechaOperativo != null ? fechaOperativo : "Sin registro"%>
                <a href="fechasFormulario.jsp?accion=Modificar&id=<%=idFecha%>&fechaAdmin=<%=fechaAdmin%>&fechaOperativo=<%=fechaOperativo%>" style="margin-left: 10px; text-decoration: none; color: inherit;">
                    <img src="../presentacion/iconos/modificar.png" alt="Editar fechas" width="16" height="16" style="vertical-align: middle; cursor: pointer;">
                </a>
            </div>

            <h3 class="titulo">INVENTARIO DE DOTACIÓN  NUEVA</h3>

            <div>
                <a href="inventarioFormulario.jsp?accion=Adicionar" class="boton-agregar" style="display: inline-flex; align-items: center; gap: 6px;">
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

    function filtrarContenido() {
        const input = document.getElementById('searchInput').value.toLowerCase();
        const tabContents = document.querySelectorAll('.tab-content');

        tabContents.forEach(tab => {
            const rows = tab.querySelectorAll("tbody tr");
            let matchFound = false;

            rows.forEach(row => {
                const text = row.innerText.toLowerCase();
                const show = text.includes(input);
                row.style.display = show ? "" : "none";
                if (show)
                    matchFound = true;
            });
        });
    }
</script>
