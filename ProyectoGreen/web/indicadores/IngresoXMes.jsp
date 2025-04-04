<%@page import="clases.Persona"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String anio = request.getParameter("anio");
    if (anio == null) {
        anio = "2024";
    }

    List<String[]> datos = Persona.getTotalIngresosPorMes(anio);
    String lista = "";
    String datosGraficos = "[";

    // Mapeo de meses en inglés a español
    Map<String, String> mesesMap = new HashMap<>();
    mesesMap.put("January", "Enero");
    mesesMap.put("February", "Febrero");
    mesesMap.put("March", "Marzo");
    mesesMap.put("April", "Abril");
    mesesMap.put("May", "Mayo");
    mesesMap.put("June", "Junio");
    mesesMap.put("July", "Julio");
    mesesMap.put("August", "Agosto");
    mesesMap.put("September", "Septiembre");
    mesesMap.put("October", "Octubre");
    mesesMap.put("November", "Noviembre");
    mesesMap.put("December", "Diciembre");

    String mesActual = "";
    String fechaActual = "";
    int totalMes = 0;
    boolean primeraFilaMes = true;
    boolean primeraFilaFecha = true;

    for (int i = 0; i < datos.size(); i++) {
        String[] r = datos.get(i);
        String mesTexto = mesesMap.getOrDefault(r[0], r[0]); // Convertir mes a español
        String numTotal = r[1]; // Número total del mes
        String fechaIngreso = r[2]; // Fecha de ingreso
        String numEspecificado = r[3]; // Número específico en esa fecha
        String tipoCargo = r[4]; // Tipo de cargo
        String unidadNegocio = r[5]; // Unidad de negocio

        if (!mesTexto.equals(mesActual)) {
            totalMes = Integer.parseInt(numTotal);
            primeraFilaMes = true;
            mesActual = mesTexto;
        }

        if (!fechaIngreso.equals(fechaActual)) {
            primeraFilaFecha = true;
            fechaActual = fechaIngreso;
        }

        lista += "<tr>";

        if (primeraFilaMes) {
            lista += "<td rowspan='" + totalMes + "'><b>" + mesTexto + "</b></td>";
            lista += "<td rowspan='" + totalMes + "'><b>" + numTotal + "</b></td>";
            primeraFilaMes = false;
        }

        if (primeraFilaFecha) {
            lista += "<td>" + fechaIngreso + "</td>";
            lista += "<td>" + numEspecificado + "</td>";
            primeraFilaFecha = false;
        } else {
            lista += "<td></td><td></td>";
        }

        lista += "<td>" + tipoCargo + "</td>";
        lista += "<td>" + unidadNegocio + "</td>";
        lista += "</tr>";

        if (i > 0) {
            datosGraficos += ",";
        }
        datosGraficos += "{ mes: '" + mesTexto + "', ingresos: " + numTotal + " }";
    }
    datosGraficos += "]";
%>

<h3 class="titulo">INGRESOS DE COLABORADORES POR MES - <%= anio%></h3>
<link rel="stylesheet" href="presentacion/style-Proyecto.css">

<table>
    <tr>
        <td>
            <table class="table" border="1">
                <tr>
                    <th>Mes</th>
                    <th>Número Total</th>
                    <th>Fecha (día)</th>
                    <th>Número Especificado</th>
                    <th>Tipo de Cargo</th>
                    <th>Unidad de Negocio</th>
                </tr>
                <%= lista%>
            </table>
        </td>
    </tr>
</table>

<div id="chartdiv" style="width: 100%; height: 400px;"></div>

<input class="submitBuscar" type="button" value="Atrás" onclick="window.history.back()">

<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
<script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>

<script>
    am5.ready(function () {
        var root = am5.Root.new("chartdiv");
        root.setThemes([am5themes_Animated.new(root)]);

        var chart = root.container.children.push(am5xy.XYChart.new(root, {
            panX: true, panY: true, wheelX: "panX", wheelY: "zoomX", pinchZoomX: true
        }));

        var cursor = chart.set("cursor", am5xy.XYCursor.new(root, {}));
        cursor.lineY.set("visible", false);

        var xRenderer = am5xy.AxisRendererX.new(root, {
            minGridDistance: 30, minorGridEnabled: true
        });

        xRenderer.labels.template.setAll({
            rotation: -45, centerY: am5.p50, centerX: am5.p100, paddingRight: 15
        });

        var xAxis = chart.xAxes.push(am5xy.CategoryAxis.new(root, {
            maxDeviation: 0.3, categoryField: "mes", renderer: xRenderer,
            tooltip: am5.Tooltip.new(root, {})
        }));

        var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
            maxDeviation: 0.3,
            min: 0, // Asegura que el mínimo sea 0
            strictMinMax: true, // Mantiene los valores dentro del rango
            renderer: am5xy.AxisRendererY.new(root, {strokeOpacity: 0.7})
        }));

        yAxis.get("renderer").grid.template.setAll({
            strokeOpacity: 0.3, // Opcional, para mejorar la visibilidad de la cuadrícula
            strokeDasharray: [3, 3]
        });

        yAxis.set("interval", 1); // Fuerza a que los valores sean enteros


        var series = chart.series.push(am5xy.ColumnSeries.new(root, {
            name: "Ingresos", xAxis: xAxis, yAxis: yAxis,
            valueYField: "ingresos", sequencedInterpolation: true,
            categoryXField: "mes",
            tooltip: am5.Tooltip.new(root, {labelText: "{valueY}"})
        }));

        series.columns.template.setAll({
            cornerRadiusTL: 10, cornerRadiusTR: 10,
            strokeOpacity: 0, fill: am5.color("#63c4f4")
        });

        var data = <%= datosGraficos%>;
        xAxis.data.setAll(data);
        series.data.setAll(data);
        series.appear(1000);
        chart.appear(1000, 100);
    });
</script>
