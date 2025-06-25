<%@ page import="java.util.*, java.text.DateFormatSymbols, java.text.SimpleDateFormat" %>
<%@ page import="clases.DetalleEntrega, clases.EntregaDotacion, clases.Persona" %>

<%
    boolean isDownloadMode = request.getParameter("formato") != null;
    if (isDownloadMode) {
        String tipo = "application/vnd.ms-excel", ext = ".xls";
        if ("word".equals(request.getParameter("formato"))) {
            tipo = "application/msword";
            ext = ".doc";
        }
        String fecha = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
        response.setContentType(tipo);
        response.setHeader("Content-Disposition", "inline; filename=\"Reporte_Dotacion_" + fecha + ext + "\"");
    }

    // Filtros
    String anio = request.getParameter("anio"),
            unidad = request.getParameter("unidad"),
            estado = request.getParameter("estado"),
            tipoEnt = request.getParameter("tipo");

    List<DetalleEntrega> lista = DetalleEntrega.getDetallesFiltrados(anio, unidad, estado, tipoEnt);

    // Construir set de años existentes
    Set<String> aniosSet = new TreeSet<>(Collections.reverseOrder());
    for (DetalleEntrega d : lista) {
        String f = d.getEntrega().getFechaEntrega();
        if (f != null && f.length() >= 4) {
            aniosSet.add(f.substring(0, 4));
        }
    }

    // Agrupar DetalleEntrega por entrega
    Map<String, List<DetalleEntrega>> agrupado = new LinkedHashMap<>();
    for (DetalleEntrega de : lista) {
        String idEnt = de.getEntrega().getIdEntrega();
        List<DetalleEntrega> subset = agrupado.get(idEnt);
        if (subset == null) {
            subset = new ArrayList<>();
            agrupado.put(idEnt, subset);
        }
        subset.add(de);

    }

    // Preparar datos para gráfica
    Map<String, Integer> entregasGrafico = new LinkedHashMap<>();
    for (List<DetalleEntrega> dets : agrupado.values()) {
        EntregaDotacion ed = dets.get(0).getEntrega();
        String f = ed.getFechaEntrega();
        String label;
        if (anio != null && !anio.isEmpty()) {
            int mes = Integer.parseInt(f.substring(5, 7)) - 1;
            label = new DateFormatSymbols().getMonths()[mes];
        } else {
            label = f.substring(0, 4);
        }
        entregasGrafico.put(label, entregasGrafico.getOrDefault(label, 0) + 1);
    }
%>

<% if (!isDownloadMode) {%>
<style>
    .table th, .table td {
        text-align:center;
        border: 1px solid #ccc;
        padding: 8px;
    }
    .export-icons {
        text-align:center;
        margin-bottom:20px;
    }
    .filtro-form {
        display:flex;
        justify-content:center;
        gap:10px;
        flex-wrap:wrap;
        margin:20px;
    }
    .table {
        border-collapse: collapse;
        width: 100%;
    }
</style>
<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>
<% } %>

<link rel="stylesheet" href="../presentacion/style-Cargos.css">

<div class="content">
    <h3 class="titulo">REPORTE DE DOTACIÓN</h3>

    <% if (!isDownloadMode) {%>
    <div class="export-icons">
        <a class="descargar" href="dotacion.jsp?formato=excel<%= request.getQueryString() != null ? "&" + request.getQueryString().replaceAll("formato=\\w+&?", "") : ""%>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Excel"></a>
        <a class="descargar" href="dotacion.jsp?formato=word<%= request.getQueryString() != null ? "&" + request.getQueryString().replaceAll("formato=\\w+&?", "") : ""%>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Word"></a>
    </div>
    <form method="get" class="filtro-form" id="filtroForm">
        <select name="anio">
            <option value="">-- Año --</option>
            <% for (String y : aniosSet) {%>
            <option value="<%= y%>" <%= y.equals(anio) ? "selected" : ""%>><%= y%></option>
            <% } %>
        </select>
        <select name="unidad">
            <option value="">-- Unidad --</option>
            <% Set<String> unidadesSet = new TreeSet<>();
                for (DetalleEntrega d : lista) {
                    unidadesSet.add(d.getUnidadNegocio());
                }
                for (String u : unidadesSet) {%>
            <option value="<%= u%>" <%= u.equals(unidad) ? "selected" : ""%>><%= u%></option>
            <% }%>
        </select>
        <select name="estado">
            <option value="">-- Estado --</option>
            <option value="Nueva" <%= "Nueva".equals(estado) ? "selected" : ""%>>Nueva</option>
            <option value="Usada" <%= "Usada".equals(estado) ? "selected" : ""%>>Usada</option>
        </select>
        <select name="tipo">
            <option value="">-- Tipo Entrega --</option>
            <% Set<String> tiposSet = new TreeSet<>();
                for (DetalleEntrega d : lista) {
                    tiposSet.add(d.getEntrega().getTipoEntrega());
                }
                for (String t : tiposSet) {%>
            <option value="<%= t%>" <%= t.equals(tipoEnt) ? "selected" : ""%>><%= t%></option>
            <% } %>
        </select>
    </form>
    <script>
        document.querySelectorAll('#filtroForm select').forEach(s => s.onchange = () => document.getElementById('filtroForm').submit());
    </script>
    <% } %>

    <% if (isDownloadMode) { %>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            font-family: Arial, sans-serif;
        }
        th, td {
            border: 1px solid #000;
            padding: 5px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
    </style>
    <% } %>

    <table class="table">
        <thead>
            <tr>
                <th>Identificación</th>
                <th>Colaborador</th>
                <th>Fecha Entrega</th>
                <th>Tipo Entrega</th>
                <th>Estado</th>
                <th>Unidad de Negocio</th>
            </tr>
        </thead>
        <tbody>
            <% for (List<DetalleEntrega> dets : agrupado.values()) {
                    EntregaDotacion ed = dets.get(0).getEntrega();
                    String estadoVal = dets.get(0).getEstado();
                    String unidadVal = dets.get(0).getUnidadNegocio();
            %>
            <tr>
                <td><%= ed.getIdPersona()%></td>
                <td><%= Persona.getNombrePorId(ed.getIdPersona())%></td>
                <td><%= ed.getFechaEntrega()%></td>
                <td><%= ed.getTipoEntrega()%></td>
                <td><%= estadoVal%></td>
                <td><%= unidadVal%></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <% if (!isDownloadMode && !entregasGrafico.isEmpty()) {%>
    <h3 class="titulo">Indicador por <%= (anio != null && !anio.isEmpty() ? "Meses" : "Años")%></h3>
    <style>
        .contenedor-flex {
            display: flex;
            gap: 20px;
            align-items: flex-start;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 40px;
        }
        .tabla-resumen-pequena {
            border-collapse: collapse;
            width: 300px;
            font-family: Arial, sans-serif;
            font-size: 13px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
        .tabla-resumen-pequena th,
        .tabla-resumen-pequena td {
            padding: 8px;
            border: 1px solid #ccc;
            text-align: center;
        }
        .tabla-resumen-pequena th {
            background-color: #2c6e49;
            color: white;
        }
        .tabla-resumen-pequena tfoot td {
            font-weight: bold;
            background-color: #daf2da;
            color: #2c6e49;
        }
        .chart-container {
            position: relative;
            width: 600px;  /* puedes usar % o fijo */
            aspect-ratio: 3.5; /* ancho:alto */
        }
    </style>

    <div class="contenedor-flex">
        <table class="tabla-resumen-pequena">
            <thead>
                <tr><th><%= (anio != null && !anio.isEmpty() ? "Mes" : "Año")%></th><th>Entregas</th></tr>
            </thead>
            <tbody>
                <% int total = 0;
                    for (Map.Entry<String, Integer> e : entregasGrafico.entrySet()) {
                        total += e.getValue();%>
                <tr><td><%= e.getKey()%></td><td><%= e.getValue()%></td></tr>
                <% }%>
            </tbody>
            <tfoot><tr><td>Total</td><td><%= total%></td></tr></tfoot>
        </table>

        <!-- Gráfico dentro de un contenedor con aspect-ratio -->
        <div class="chart-container">
            <canvas id="graficoEntregas"></canvas>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const ctx = document.getElementById('graficoEntregas').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [<% boolean first = true;
                    for (String lbl : entregasGrafico.keySet()) {
                        if (!first) {
                            out.print(",");
                        }
                        out.print("\"" + lbl + "\"");
                        first = false;
                    }%>],
                datasets: [{
                        label: '<%= anio != null && !anio.isEmpty() ? "Entregas por Mes en " + anio : "Entregas por Año"%>',
                        data: [<% boolean fb = true;
                            for (Integer v : entregasGrafico.values()) {
                                if (!fb) {
                                    out.print(",");
                                }
                                out.print(v);
                                fb = false;
                            } %>],
                        backgroundColor: 'rgba(100,149,237,0.7)',
                        borderColor: '#6495ED',
                        borderWidth: 2,
                        borderRadius: 6,
                        barPercentage: 0.6,
                        categoryPercentage: 0.8
                    }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, // 
                scales: {
                    y: {beginAtZero: true, ticks: {stepSize: 1}}
                },
                plugins: {
                    legend: {labels: {font: {weight: 'bold', size: 14}}},
                    tooltip: {backgroundColor: '#daf2da'}
                }
            }
        });
               
    </script>

    <% }%>
</div>
