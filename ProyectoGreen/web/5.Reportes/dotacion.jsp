<%@page import="java.text.DateFormatSymbols"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="clases.DetalleEntrega" %>
<%@ page import="clases.EntregaDotacion" %>

<%
    boolean isDownloadMode = request.getParameter("formato") != null;
    if (isDownloadMode) {
        String tipoContenido = "";
        String extensionArchivo = "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String fechaActual = sdf.format(new java.util.Date());

        switch (request.getParameter("formato")) {
            case "excel":
                tipoContenido = "application/vnd.ms-excel";
                extensionArchivo = ".xls";
                break;
            case "word":
                tipoContenido = "application/vnd.msword";
                extensionArchivo = ".doc";
                break;
        }
        response.setContentType(tipoContenido);
        String nombreArchivo = "Reporte_Dotacion_" + fechaActual + extensionArchivo;
        response.setHeader("Content-Disposition", "inline; filename=\"" + nombreArchivo + "\"");
    }

    // Preparar listas únicas para los filtros
    Set<String> anios = new TreeSet<>(Collections.reverseOrder());
    Set<String> unidades = new TreeSet<>();
    Set<String> tiposEntrega = new TreeSet<>();

    List<DetalleEntrega> todas = DetalleEntrega.getDetallesConEstadoNueva();
    for (DetalleEntrega d : todas) {
        EntregaDotacion e = d.getEntrega();
        if (e.getFechaEntrega() != null && e.getFechaEntrega().length() >= 4) {
            anios.add(e.getFechaEntrega().substring(0, 4));
        }
        if (d.getUnidadNegocio() != null) {
            unidades.add(d.getUnidadNegocio());
        }
        if (e.getTipoEntrega() != null) {
            tiposEntrega.add(e.getTipoEntrega());
        }
    }
%>

<% if (!isDownloadMode) { %>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
    }
    .titulo {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        margin-top: 20px;
        color: #2c6e49;
    }
    .table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px auto;
    }
    .table th, .table td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: center;
    }
    .table th {
        background-color: #2c6e49;
        color: white;
    }
    .export-icons {
        text-align: center;
        margin-bottom: 20px;
    }
    .export-icons img {
        width: 32px;
        height: 32px;
        margin: 0 10px;
        cursor: pointer;
    }
    .filtro-form {
        display: flex;
        justify-content: center;
        gap: 10px;
        flex-wrap: wrap;
        margin: 20px;
    }
    .filtro-form select {
        padding: 5px;
        font-size: 14px;
    }
</style>
<% } %>

<div class="content">
    <h3 class="titulo">REPORTE DE DOTACIÓN</h3>

    <% if (!isDownloadMode) { %>
    <div class="export-icons">
        <a href="dotacion.jsp?formato=excel<%= request.getQueryString() != null ? "&" + request.getQueryString().replaceAll("formato=\\w+&?", "") : "" %>" target="_blank">
            <img src="../presentacion/iconos/excel.png" alt="Exportar a Excel">
        </a>
        <a href="dotacion.jsp?formato=word<%= request.getQueryString() != null ? "&" + request.getQueryString().replaceAll("formato=\\w+&?", "") : "" %>" target="_blank">
            <img src="../presentacion/iconos/word.png" alt="Exportar a Word">
        </a>
    </div>

    <form method="get" class="filtro-form">
        <select name="anio">
            <option value="">-- Año --</option>
            <%
                for (String a : anios) {
            %>
            <option value="<%= a %>" <%= a.equals(request.getParameter("anio")) ? "selected" : "" %>><%= a %></option>
            <% } %>
        </select>

        <select name="unidad">
            <option value="">-- Unidad de Negocio --</option>
            <%
                for (String u : unidades) {
            %>
            <option value="<%= u %>" <%= u.equals(request.getParameter("unidad")) ? "selected" : "" %>><%= u %></option>
            <% } %>
        </select>

        <select name="estado">
            <option value="">-- Estado --</option>
            <option value="Nueva" <%= "Nueva".equals(request.getParameter("estado")) ? "selected" : "" %>>Nueva</option>
            <option value="Usada" <%= "Usada".equals(request.getParameter("estado")) ? "selected" : "" %>>Usada</option>
        </select>

        <select name="tipo">
            <option value="">-- Tipo de Entrega --</option>
            <%
                for (String t : tiposEntrega) {
            %>
            <option value="<%= t %>" <%= t.equals(request.getParameter("tipo")) ? "selected" : "" %>><%= t %></option>
            <% } %>
        </select>

        <button type="submit">Filtrar</button>
    </form>
    <% } %>

    <table class="table">
        <thead>
            <tr>
                <th>ID Persona</th>
                <th>Fecha Entrega</th>
                <th>Tipo Entrega</th>
                <th>Estado</th>
                <th>Unidad de Negocio</th>
            </tr>
        </thead>
        <tbody>
<%
    // Obtener filtros
    String anio = request.getParameter("anio");
    String unidad = request.getParameter("unidad");
    String estado = request.getParameter("estado");
    String tipo = request.getParameter("tipo");

    List<DetalleEntrega> lista = DetalleEntrega.getDetallesFiltrados(anio, unidad, estado, tipo);
    for (DetalleEntrega de : lista) {
        EntregaDotacion ed = de.getEntrega();
%>
<tr>
    <td><%= ed.getIdPersona() %></td>
    <td><%= ed.getFechaEntrega() %></td>
    <td><%= ed.getTipoEntrega() %></td>

    <td><%= de.getEstado() %></td>
    <td><%= de.getUnidadNegocio() %></td>
</tr>
<%
    }
%>
        </tbody>
        
    </table>
        <%
Map<String, Integer> entregasGrafico = new TreeMap<>(); // Clave: mes o año

if (anio != null && !anio.isEmpty()) {
    // Mostrar por MES del año seleccionado
    for (DetalleEntrega de : lista) {
        EntregaDotacion ed = de.getEntrega();
        String fecha = ed.getFechaEntrega(); // Formato esperado: yyyy-MM-dd
        if (fecha != null && fecha.startsWith(anio)) {
            try {
                String[] partes = fecha.split("-");
                int mes = Integer.parseInt(partes[1]);
                String nombreMes = new DateFormatSymbols().getMonths()[mes - 1]; // Mes en texto
                entregasGrafico.put(nombreMes, entregasGrafico.getOrDefault(nombreMes, 0) + 1);
            } catch (Exception e) {
                // Ignorar errores de formato
            }
        }
    }
} else {
    // Mostrar por AÑO
    for (DetalleEntrega de : lista) {
        EntregaDotacion ed = de.getEntrega();
        String fecha = ed.getFechaEntrega(); // Formato esperado: yyyy-MM-dd
        if (fecha != null && fecha.length() >= 4) {
            String year = fecha.substring(0, 4);
            entregasGrafico.put(year, entregasGrafico.getOrDefault(year, 0) + 1);
        }
    }
}
%>

<% if (!isDownloadMode && !entregasGrafico.isEmpty()) { %>
    <div style="width: 80%; margin: 40px auto;">
        <canvas id="graficoEntregas"></canvas>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const ctx = document.getElementById('graficoEntregas').getContext('2d');

        const data = {
            labels: [<%
                boolean first = true;
                for (String key : entregasGrafico.keySet()) {
                    if (!first) out.print(", ");
                    out.print("\"" + key + "\"");
                    first = false;
                }
            %>],
            datasets: [{
                label: '<%= (anio != null && !anio.isEmpty()) ? "Entregas por Mes en " + anio : "Entregas por Año" %>',
                data: [<%
                    first = true;
                    for (String key : entregasGrafico.keySet()) {
                        if (!first) out.print(", ");
                        out.print(entregasGrafico.get(key));
                        first = false;
                    }
                %>],
                backgroundColor: 'rgba(44, 110, 73, 0.6)',
                borderColor: 'rgba(44, 110, 73, 1)',
                borderWidth: 1
            }]
        };

        new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Cantidad de Entregas'
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        });
    </script>
<% } %>

</div>
