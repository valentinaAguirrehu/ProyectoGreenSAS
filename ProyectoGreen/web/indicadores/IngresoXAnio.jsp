<%@ page import="clases.Persona" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    List<String[]> datos = Persona.getTotalIngresosPorAnio();
    String lista = "";
    String datosGraficos = "[";

    for (int i = 0; i < datos.size(); i++) {
        String[] registro = datos.get(i);
        lista += "<tr>";
        lista += "<td><a href='principal.jsp?CONTENIDO=indicadores/ingresosXMes.jsp&anio=" + registro[0] + "'>" + registro[0] + "</a></td>";
        lista += "<td>" + registro[1] + "</td>"; // Número de personas
        lista += "<td>" + registro[2] + "</td>"; // Tipo de cargo
        lista += "<td>" + registro[3] + "</td>"; // Unidad de negocio
        lista += "</tr>";

        if (i > 0) datosGraficos += ", ";
        datosGraficos += "{ country: '" + registro[0] + "', value: " + registro[1] + " }";
    }
    datosGraficos += "]";
%>

<h3 class="titulo">INGRESOS DE COLABORADORES POR AÑO</h3>

<table class="table" border="1">
    <tr>
        <th>Año</th>
        <th>Número de Personas</th>
        <th>Tipo de Cargo</th>
        <th>Unidad de Negocio</th>
    </tr>
    <%= lista %>
</table>

<div id="chartdiv" style="width: 100%; height: 400px;"></div>

<script>
    am5.ready(function () {
        var root = am5.Root.new("chartdiv");
        root.setThemes([am5themes_Animated.new(root)]);

        var chart = root.container.children.push(am5xy.XYChart.new(root, {}));

        var xAxis = chart.xAxes.push(am5xy.CategoryAxis.new(root, {
            categoryField: "country",
            renderer: am5xy.AxisRendererX.new(root, {})
        }));

        var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
            renderer: am5xy.AxisRendererY.new(root, {})
        }));

        var series = chart.series.push(am5xy.ColumnSeries.new(root, {
            name: "Ingresos",
            xAxis: xAxis,
            yAxis: yAxis,
            valueYField: "value",
            categoryXField: "country",
            tooltip: am5.Tooltip.new(root, { labelText: "{valueY}" })
        }));

        series.columns.template.setAll({
            cornerRadiusTL: 10,
            cornerRadiusTR: 10,
            strokeOpacity: 0,
            fill: am5.color("#63c4f4")
        });

        var data = <%= datosGraficos %>;
        xAxis.data.setAll(data);
        series.data.setAll(data);

        series.appear(1000);
        chart.appear(1000, 100);
    });
</script>
