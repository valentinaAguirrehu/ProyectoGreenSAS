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
        response.setHeader("Content-Disposition", "inline; filename=\"Reporte_Ingresos_Colaboradores" + extensionArchivo + "\"");
    }
%>

<h2>REPORTE DE INGRESOS DE COLABORADORES - GREEN S.A.S</h2>

<%
    if (!isDownloadMode) {
%>
    <!-- Exportar -->
    <a href="ingresoColaboradores.jsp?formato=excel<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : "" %>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Exportar a Excel"></a>
    <a href="ingresoColaboradores.jsp?formato=word<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : "" %>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>

    <!-- Filtro por año -->
    <form method="get">
        <label for="anio">Filtrar por año:</label>
        <select name="anio" onchange="this.form.submit()">
            <option value="">-- Todos --</option>
            <%
                Set<Integer> añosDisponibles = new HashSet<>();
                List<Persona> listaPersonas = Persona.getListaEnObjetos("tipo = 'C' AND fechaIngreso IS NOT NULL", null);
                for (Persona p : listaPersonas) {
                    if (p.getFechaIngreso() != null) {
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaIngreso()));
                        añosDisponibles.add(cal.get(Calendar.YEAR));
                    }
                }
                for (Integer anio : añosDisponibles) {
                    String anioParam = request.getParameter("anio");
            %>
                <option value="<%= anio %>" <%= (anioParam != null && anioParam.equals(String.valueOf(anio))) ? "selected" : "" %>><%= anio %></option>
            <%
                }
            %>
        </select>
    </form>
<%
    }
%>

<%
    // Filtrar personas
    String anioFiltro = request.getParameter("anio");
    String condicion = "tipo = 'C' AND fechaIngreso IS NOT NULL";
    if (anioFiltro != null && !anioFiltro.isEmpty()) {
        condicion += " AND YEAR(fechaIngreso) = " + anioFiltro;
    }
    List<Persona> listaPersonasFiltradas = Persona.getListaEnObjetos(condicion, "fechaIngreso ASC");

    // Datos para gráfico
    List<Persona> todasLasPersonas = Persona.getListaEnObjetos("tipo = 'C' AND fechaIngreso IS NOT NULL", null);
    Map<Integer, Integer> ingresosPorAnio = new HashMap<>();
    int totalIngresos = 0;

    for (Persona p : todasLasPersonas) {
        if (p.getFechaIngreso() != null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaIngreso()));
            int anio = cal.get(Calendar.YEAR);
            ingresosPorAnio.put(anio, ingresosPorAnio.getOrDefault(anio, 0) + 1);
            totalIngresos++;
        }
    }

    String tablaResumen = "";
    String datosGrafico = "[";
    int contador = 0;
    for (Map.Entry<Integer, Integer> entry : ingresosPorAnio.entrySet()) {
        int anio = entry.getKey();
        int cantidad = entry.getValue();
        double porcentaje = (cantidad / (double) totalIngresos) * 100;

        tablaResumen += "<tr>";
        tablaResumen += "<td>" + anio + "</td>";
        tablaResumen += "<td>" + cantidad + "</td>";
        tablaResumen += "<td>" + String.format("%.2f", porcentaje) + "%</td>";
        tablaResumen += "</tr>";

        if (contador++ > 0) datosGrafico += ",";
        datosGrafico += "{ years: '" + anio + "', value: " + cantidad + " }";
    }
    datosGrafico += "]";
%>

<!-- Tabla principal -->
<h3>Lista de Colaboradores</h3>
<table border="1" class="tabla" style="margin-top:20px; width:100%; font-size: 14px;">
    <tr style="background-color: #e0e0e0;">
        <th>Identificación</th>
        <th>Nombre completo</th>
        <th>Cargo</th>
        <th>Unidad de negocio</th>
        <th>Fecha de ingreso</th>
    </tr>

<%
    for (Persona p : listaPersonasFiltradas) {
        if (p.getFechaIngreso() == null || p.getFechaIngreso().isEmpty()) continue;

        String nombreCargo = Cargo.getCargoPersona(p.getIdentificacion());
%>
    <tr>
        <td><%= p.getIdentificacion() %></td>
        <td><%= p.getNombres() %> <%= p.getApellidos() %></td>
        <td><%= nombreCargo %></td>
        <td><%= p.getUnidadNegocio() %></td>
        <td><%= p.getFechaIngreso() %></td>
    </tr>
<%
    }
%>
</table>

<!-- Tabla de resumen + gráfica -->
<h3>Indicador de Ingresos por Año</h3>
<table border="0" style="margin-bottom: 20px;">
    <tr>
        <td>
            <table border="1">
                <tr><th>Año</th><th>Ingresos</th><th>%</th></tr>
                <%=tablaResumen%>
            </table>
        </td>
    </tr>
</table>

<!-- Gráfica -->
<div id="chartdiv" style="width: 700px; height: 400px;"></div>

<!-- Incluye la librería de gráficos -->
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
        renderer: am5xy.AxisRendererX.new(root, { minGridDistance: 30 })
    }));

    var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
        renderer: am5xy.AxisRendererY.new(root, {})
    }));

    var series = chart.series.push(am5xy.ColumnSeries.new(root, {
        name: "Ingresos",
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
