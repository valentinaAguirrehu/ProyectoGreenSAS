<%@page import="java.text.DateFormatSymbols"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="clases.DetalleEntrega" %>
<%@ page import="clases.EntregaDotacion" %>
<%@ page import="clases.Persona" %>

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
                tipoContenido = "application/msword";
                extensionArchivo = ".doc";
                break;
        }
        response.setContentType(tipoContenido);
        String nombreArchivo = "Reporte_Dotacion_" + fechaActual + extensionArchivo;
        response.setHeader("Content-Disposition", "inline; filename=\"" + nombreArchivo + "\"");
    }

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

<% if (!isDownloadMode) {%>
<style>
    .table th, .table td {
        text-align: center;
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

<%@ include file="../menu.jsp" %>
<% } %>

<link rel="stylesheet" href="../presentacion/style-Cargos.css">

<div class="content">
    <h3 class="titulo">REPORTE DE DOTACIÓN</h3>

    <% if (!isDownloadMode) {
            String anio = request.getParameter("anio");
            String unidad = request.getParameter("unidad");
            String estado = request.getParameter("estado");
            String tipo = request.getParameter("tipo");
    %>

    <div class="export-icons">
        <a href="dotacion.jsp?formato=excel<%= (request.getQueryString() != null ? "&" + request.getQueryString().replaceAll("formato=\\w+&?", "") : "")%>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Exportar a Excel"></a>
        <a href="dotacion.jsp?formato=word<%= (request.getQueryString() != null ? "&" + request.getQueryString().replaceAll("formato=\\w+&?", "") : "")%>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>
    </div>

    <form method="get" class="filtro-form" id="filtroForm">
        <select name="anio">
            <option value="">-- Año --</option>
            <% for (String a : anios) {%>
            <option value="<%= a%>" <%= a.equals(anio) ? "selected" : ""%>><%= a%></option>
            <% } %>
        </select>

        <select name="unidad">
            <option value="">-- Unidad de Negocio --</option>
            <% for (String u : unidades) {%>
            <option value="<%= u%>" <%= u.equals(unidad) ? "selected" : ""%>><%= u%></option>
            <% }%>
        </select>

        <select name="estado">
            <option value="">-- Estado --</option>
            <option value="Nueva" <%= "Nueva".equals(estado) ? "selected" : ""%>>Nueva</option>
            <option value="Usada" <%= "Usada".equals(estado) ? "selected" : ""%>>Usada</option>
        </select>

        <select name="tipo">
            <option value="">-- Tipo de Entrega --</option>
            <% for (String t : tiposEntrega) {%>
            <option value="<%= t%>" <%= t.equals(tipo) ? "selected" : ""%>><%= t%></option>
            <% } %>
        </select>
    </form>

    <script>
        document.querySelectorAll('#filtroForm select').forEach(select => {
            select.addEventListener('change', () => {
                document.getElementById('filtroForm').submit();
            });
        });
    </script>

    <% } %>

    <%
        String anio = request.getParameter("anio");
        String unidad = request.getParameter("unidad");
        String estado = request.getParameter("estado");
        String tipo = request.getParameter("tipo");

        List<DetalleEntrega> lista = DetalleEntrega.getDetallesFiltrados(anio, unidad, estado, tipo);
    %>

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
            <% for (DetalleEntrega de : lista) {
                    EntregaDotacion ed = de.getEntrega();
            %>
            <tr>
                <td><%= ed.getIdPersona()%></td>
                <td><%= Persona.getNombrePorId(ed.getIdPersona())%></td>
                <td><%= ed.getFechaEntrega()%></td>
                <td><%= ed.getTipoEntrega()%></td>
                <td><%= de.getEstado()%></td>
                <td><%= de.getUnidadNegocio()%></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <%
        Map<String, Integer> entregasGrafico = new TreeMap<>();

        if (anio != null && !anio.isEmpty()) {
            for (DetalleEntrega de : lista) {
                EntregaDotacion ed = de.getEntrega();
                String fecha = ed.getFechaEntrega();
                if (fecha != null && fecha.startsWith(anio)) {
                    try {
                        int mes = Integer.parseInt(fecha.split("-")[1]);
                        String nombreMes = new DateFormatSymbols().getMonths()[mes - 1];
                        entregasGrafico.put(nombreMes, entregasGrafico.getOrDefault(nombreMes, 0) + 1);
                    } catch (Exception e) {
                    }
                }
            }
        } else {
            for (DetalleEntrega de : lista) {
                EntregaDotacion ed = de.getEntrega();
                String fecha = ed.getFechaEntrega();
                if (fecha != null && fecha.length() >= 4) {
                    String year = fecha.substring(0, 4);
                    entregasGrafico.put(year, entregasGrafico.getOrDefault(year, 0) + 1);
                }
            }
        }
    %>

    <% if (!isDownloadMode && !entregasGrafico.isEmpty()) {%>
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
        .tabla-resumen-pequena th, .tabla-resumen-pequena td {
            padding: 8px;
            text-align: center;
            border: 1px solid #ccc;
        }
        .tabla-resumen-pequena th {
            background-color: #2c6e49;
            color: white;
            font-weight: bold;
        }
        .tabla-resumen-pequena tfoot td {
            font-weight: bold;
            background-color: #daf2da;
            color: #2c6e49;
        }
        #graficoEntregas {
            width: 700px !important;
            height: 400px !important;
            border-radius: 8px;
            background-color: #f9f9f9;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
            padding: 10px;
        }
    </style>

    <h3 class="titulo">Indicador por <%= (anio != null && !anio.isEmpty()) ? "meses en " + anio : "años"%></h3>

    <div class="contenedor-flex">
        <table class="tabla-resumen-pequena">
            <thead>
                <tr>
                    <th><%= (anio != null && !anio.isEmpty()) ? "Mes" : "Año"%></th>
                    <th>Entregas</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int totalEntregas = 0;
                    for (Map.Entry<String, Integer> entry : entregasGrafico.entrySet()) {
                        totalEntregas += entry.getValue();
                %>
                <tr>
                    <td><%= entry.getKey()%></td>
                    <td><%= entry.getValue()%></td>
                </tr>
                <% }%>
            </tbody>
            <tfoot>
                <tr>
                    <td>Total</td>
                    <td><%= totalEntregas%></td>
                </tr>
            </tfoot>
        </table>

        <canvas id="graficoEntregas"></canvas>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        const ctx = document.getElementById('graficoEntregas').getContext('2d');
        const data = {
            labels: [<%
                boolean first = true;
                for (String key : entregasGrafico.keySet()) {
                    if (!first) {
                        out.print(", ");
                    }
                    out.print("\"" + key + "\"");
                    first = false;
                }
        %>],
            datasets: [{
                    label: '<%= (anio != null && !anio.isEmpty()) ? "Entregas por Mes en " + anio : "Entregas por Año"%>',
                    data: [<%
                    first = true;
                    for (String key : entregasGrafico.keySet()) {
                        if (!first) {
                            out.print(", ");
                        }
                        out.print(entregasGrafico.get(key));
                        first = false;
                    }
        %>],
                    backgroundColor: 'rgba(100, 149, 237, 0.7)', // Azul claro (Cornflower Blue con opacidad)
                    borderColor: '#6495ED', // Azul claro sólido
                    borderWidth: 2,
                    borderRadius: 6,
                    barPercentage: 0.6,
                    categoryPercentage: 0.8
                }]
        };

        new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                responsive: false,
                plugins: {
                    legend: {
                        display: true,
                        onClick: null, 
                        labels: {
                            color: '#2c6e49',
                            font: {
                                family: 'Arial',
                                size: 14,
                                weight: 'bold'
                            }
                        }
                    },
                    tooltip: {
                        backgroundColor: '#daf2da',
                        titleColor: '#2c6e49',
                        bodyColor: '#2c6e49'
                    }
                }
                ,
                scales: {
                    x: {
                        ticks: {color: '#2c6e49', font: {family: 'Arial', size: 13}},
                        grid: {display: false}
                    },
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: '#2c6e49',
                            font: {family: 'Arial', size: 13},
                            stepSize: 1
                        },
                        title: {
                            display: true,
                            text: 'Cantidad de Entregas',
                            color: '#2c6e49',
                            font: {family: 'Arial', size: 14, weight: 'bold'}
                        },
                        grid: {color: '#e0e0e0'}
                    }
                }
            }
        });                          
    </script>
    <% }%>
