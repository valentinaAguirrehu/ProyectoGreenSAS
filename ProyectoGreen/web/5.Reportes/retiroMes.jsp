<%@page import="clases.Cargo"%>
<%@ page import="java.util.*" %>
<%@ page import="clases.Persona" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    boolean isDownloadMode = request.getParameter("formato") != null;

    String anioParam = request.getParameter("anio");
    String mesParam = request.getParameter("mes");

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
    <h3 class="titulo">REPORTE DE RETIROS DE COLABORADORES POR MES - GREEN S.A.S</h3>
    <% if (!isDownloadMode) { %>
<div style="margin: 10px 0;">
    <a href="retiroMes.jsp?formato=excel<%= (anioParam != null ? "&anio=" + anioParam : "") + (mesParam != null ? "&mes=" + mesParam : "") %>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Exportar a Excel"></a>
    <a href="retiroMes.jsp?formato=word<%= (anioParam != null ? "&anio=" + anioParam : "") + (mesParam != null ? "&mes=" + mesParam : "") %>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>
</div>
<% } %>


   <%
        // Parámetros de filtro para la tabla principal (opcional)

    String condicion = "tipo = 'R' AND fechaTerPriContrato IS NOT NULL";

    if (anioParam != null && !anioParam.isEmpty()) {
        condicion += " AND YEAR(fechaTerPriContrato) = " + anioParam;
    }
    if (mesParam != null && !mesParam.isEmpty()) {
        condicion += " AND MONTH(fechaTerPriContrato) = " + mesParam;
    }

    // Lista de retirados filtrada (para tabla inferior)
    List<Persona> retirados = Persona.getListaEnObjetos(condicion, "fechaTerPriContrato ASC");

    // Segunda consulta para indicador de retiros por mes (SIN FILTROS)
    List<Persona> retiradosTodos = Persona.getListaEnObjetos("tipo = 'R' AND fechaTerPriContrato IS NOT NULL", "fechaTerPriContrato ASC");

    Map<Integer, Integer> retirosPorMes = new HashMap<>();
    int totalRetiros = 0;

    for (Persona p : retiradosTodos) {
        if (p.getFechaTerPriContrato() != null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaTerPriContrato()));
            int mes = cal.get(Calendar.MONTH) + 1;
            retirosPorMes.put(mes, retirosPorMes.getOrDefault(mes, 0) + 1);
            totalRetiros++;
        }
    }

    String[] mesesNombres = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};

    String tablaResumen = "";
    String datosGrafico = "[";
    int contador = 0;

    Map<Integer, Integer> retirosPorMesOrdenado = new TreeMap<>(retirosPorMes);

    for (int mes = 1; mes <= 12; mes++) {
        if (retirosPorMesOrdenado.containsKey(mes)) {
            int cantidad = retirosPorMesOrdenado.get(mes);
            double porcentaje = (cantidad / (double) totalRetiros) * 100;

            tablaResumen += "<tr><td>" + mesesNombres[mes - 1] + "</td><td>" + cantidad + "</td><td>" + String.format("%.2f", porcentaje) + "%</td></tr>";

            if (contador++ > 0) datosGrafico += ",";
            datosGrafico += "{ mes: '" + mesesNombres[mes - 1] + "', value: " + cantidad + " }";
        }
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
        <%    for (Persona p : retirados) {
                String nombreCargo = Cargo.getCargoPersona(p.getIdentificacion());
        %>
        <tr>
            <td><%= p.getIdentificacion()%></td>
            <td><%= p.getNombres()%> <%= p.getApellidos()%></td>
            <td><%= nombreCargo%></td>
            <td><%= p.getEstablecimiento()%></td>
            <td><%= p.getFechaTerPriContrato()%></td>
        </tr>
        <% }%>
    </table>

    <% if (!isDownloadMode) { %>
    <h3>Indicador de retiros por mes</h3>
    <div style="display: flex; gap: 20px; align-items: flex-start;">
        <div>
            <table class="table" border="1">
                <tr><th>Mes</th><th>Retiros</th><th>%</th></tr>
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
                categoryField: "mes",
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
                categoryXField: "mes",
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
<% } %>
