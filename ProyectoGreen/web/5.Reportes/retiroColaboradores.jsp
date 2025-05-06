<%@page import="clases.Cargo"%>
<%@ page import="java.util.*" %>
<%@ page import="clases.Persona" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    boolean isDownloadMode = request.getParameter("formato") != null;
    if (isDownloadMode) {
        String tipoContenido = "";
        String extensionArchivo = "";
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
        response.setHeader("Content-Disposition", "inline; filename=\"Reporte_Retirados" + extensionArchivo + "\"");
    }
%>

<% if (!isDownloadMode) { %>
<style>
    body {
        display: flex;
        min-height: 10vh;
        margin: 0;
    }
    .titulo {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 2px;
        color:  #2c6e49;
        position: relative;
        text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        transition: transform 0.3s ease-in-out;
    }
    .titulo:hover {
        transform: scale(1.05);
    }
    .table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        border-radius: 8px;
        overflow: hidden;
    }
    .table th, .table td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
        text-align: center;
    }
    .table th {
        background-color: #2c6e49;
        color: white;
        text-transform: uppercase;
    }
    .table tr:hover {
        background-color:#daf2da;
    }
    .content {
        flex-grow: 1;
        overflow-x: auto;
        margin-left: 220px;
        padding: 20px;
    }
</style>
<% } %>

<% if (!isDownloadMode) {%>
<%@ include file="../menu.jsp" %> 
<% } %> 

<div class="content">
    <h3 class="titulo">REPORTE DE RETIROS DE COLABORADORES - GREEN S.A.S</h3>

    <% if (!isDownloadMode) {%>
    <a href="retiroColaboradores.jsp?formato=excel<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Exportar a Excel"></a>
    <a href="retiroColaboradores.jsp?formato=word<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>

    <form method="get">
        <label for="anio">Filtrar por año:</label>
        <select name="anio" onchange="this.form.submit()">
            <option value="">-- Todos --</option>
            <%
                Set<Integer> años = new HashSet<>();
                List<Persona> retirados = Persona.getListaEnObjetos("tipo = 'R' AND fechaTerPriContrato IS NOT NULL", null);
                for (Persona p : retirados) {
                    if (p.getFechaTerPriContrato() != null) {
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaTerPriContrato()));
                        años.add(cal.get(Calendar.YEAR));
                    }
                }
                for (Integer anio : años) {
                    String param = request.getParameter("anio");
            %>
            <option value="<%= anio%>" <%= (param != null && param.equals(String.valueOf(anio))) ? "selected" : ""%>><%= anio%></option>
            <%
                }
            %>
        </select>
    </form>


    <% } %>

    <%
        String anioFiltro = request.getParameter("anio");
        String condicion = "tipo = 'R' AND fechaTerPriContrato IS NOT NULL";
        if (anioFiltro != null && !anioFiltro.isEmpty()) {
            condicion += " AND YEAR(fechaTerPriContrato) = " + anioFiltro;
        }
        List<Persona> filtrados = Persona.getListaEnObjetos(condicion, "fechaTerPriContrato ASC");
        List<Persona> todos = Persona.getListaEnObjetos("tipo = 'R' AND fechaTerPriContrato IS NOT NULL", null);
        Map<Integer, Integer> retirosPorAnio = new HashMap<>();
        int totalRetiros = 0;

        for (Persona p : todos) {
            if (p.getFechaTerPriContrato() != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaTerPriContrato()));
                int anio = cal.get(Calendar.YEAR);
                retirosPorAnio.put(anio, retirosPorAnio.getOrDefault(anio, 0) + 1);
                totalRetiros++;
            }
        }

        String tablaResumen = "";
        String datosGrafico = "[";
        int contador = 0;
        for (Map.Entry<Integer, Integer> entry : retirosPorAnio.entrySet()) {
            int anio = entry.getKey();
            int cantidad = entry.getValue();
            double porcentaje = (cantidad / (double) totalRetiros) * 100;

            tablaResumen += "<tr><td>" + anio + "</td><td>" + cantidad + "</td><td>" + String.format("%.2f", porcentaje) + "%</td></tr>";

            if (contador++ > 0) {
                datosGrafico += ",";
            }
            datosGrafico += "{ years: '" + anio + "', value: " + cantidad + " }";
        }
        datosGrafico += "]";
    %>

    <h3>Lista de retirados</h3>
    <table border="1" class="table">
        <tr>
            <th>Identificación</th>
            <th>Nombre completo</th>
            <th>Cargo</th>
            <th>Establecimiento</th>
            <th>Fecha de retiro</th>
        </tr>
        <%
            for (Persona p : filtrados) {
                String nombreCargo = Cargo.getCargoPersona(p.getIdentificacion());
        %>
        <tr>
            <td><%= p.getIdentificacion()%></td>
            <td><%= p.getNombres()%> <%= p.getApellidos()%></td>
            <td><%= nombreCargo%></td>
            <td><%= p.getEstablecimiento()%></td>
            <%
                String[] fechaPartes = p.getFechaTerPriContrato().split("-");
                String anioLink = fechaPartes[0];
                String mesLink = fechaPartes[1];
            %>
            <td>
                <a href="retiroMes.jsp?anio=<%= anioLink%>&mes=<%= mesLink%>">
                    <%= p.getFechaTerPriContrato()%>
                </a>
            </td>

        </tr>
        <% }%>
    </table>

    <h3>Indicador de retiros por año</h3>
    <div style="display: flex; gap: 20px; align-items: flex-start;">
        <div>
            <table class="table" border="1">
                <tr><th>Año</th><th>Retiros</th><th>%</th></tr>
                        <%=tablaResumen%>
            </table>
        </div>
        <div id="chartdiv" style="width: 700px; height: 400px;"></div>
    </div>

    <script src="https://cdn.amcharts.com/lib/5/index.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
    <script>
                am5.ready(function () {
                    var root = am5.Root.new("chartdiv");
                    root.setThemes([am5themes_Animated.new(root)]);
                    var chart = root.container.children.push(am5xy.XYChart.new(root, {}));
                    var xAxis = chart.xAxes.push(am5xy.CategoryAxis.new(root, {
                        categoryField: "years",
                        renderer: am5xy.AxisRendererX.new(root, {minGridDistance: 30})
                    }));
                    var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
                        renderer: am5xy.AxisRendererY.new(root, {})
                    }));
                    var series = chart.series.push(am5xy.ColumnSeries.new(root, {
                        name: "Retiros",
                        xAxis: xAxis,
                        yAxis: yAxis,
                        valueYField: "value",
                        categoryXField: "years",
                        tooltip: am5.Tooltip.new(root, {
                            labelText: "{valueY}"
                        })
                    }));
                    var data = <%=datosGrafico%>;
                    xAxis.data.setAll(data);
                    series.data.setAll(data);
                    series.appear(1000);
                    chart.appear(1000, 100);
                });
    </script>
</div>
