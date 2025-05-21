<%@page import="java.text.ParseException"%>
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
        color: #2c6e49;
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
        background-color: #daf2da;
    }
    .table img {
        cursor: pointer;
        transition: transform 0.2s;
    }
    .table img:hover {
        transform: scale(1.1);
    }
    .table th:last-child {
        text-align: center;
    }
    .content {
        flex-grow: 1;
        overflow-x: auto;
        margin-left: 220px;
        padding: 20px;
    }

    .filtro-anio-form {
        display: flex;
        align-items: center;
        gap: 10px;
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        padding: 12px 16px;
        border-radius: 6px;
        width: fit-content;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .filtro-anio-form label {

        color: #333;
    }

    .filtro-anio-form select {
        padding: 6px 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #fff;
        cursor: pointer;
        transition: border-color 0.3s;
    }

    .filtro-anio-form select:hover {
        border-color: #888;
    }
</style>
<% } %>

<% if (!isDownloadMode) {%>
<%@ include file="../menu.jsp" %> 
<% } %> 

<div class="content">
    <h3 class="titulo">REPORTE DE INGRESO DE COLABORADORES - GREEN S.A.S</h3>

    <%
        if (!isDownloadMode) {
    %>
    <!-- Exportar -->
    <a href="ingresoColaboradores.jsp?formato=excel<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Exportar a Excel"></a>
    <a href="ingresoColaboradores.jsp?formato=word<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>

    <!-- Filtro por año -->
    <form method="get" class="filtro-anio-form">
        <label for="anio">Filtrar por año:</label>
        <select name="anio" onchange="this.form.submit()">
            <option value="">-- Todos --</option>

            <%
                Set<Integer> añosDisponibles = new HashSet<>();
                List<Persona> listaPersonas = Persona.getListaEnObjetos("tipo = 'C' AND fechaIngreso IS NOT NULL", null);
                for (Persona p : listaPersonas) {
                    if (p.getFechaIngreso() != null && !p.getFechaIngreso().isEmpty()) {
                        try {
                            Calendar cal = Calendar.getInstance();
                            cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaIngreso()));
                            añosDisponibles.add(cal.get(Calendar.YEAR));
                        } catch (ParseException e) {
                            System.out.println("Error al parsear la fecha: " + p.getFechaIngreso());
                        }
                    }
                }
                for (Integer anio : añosDisponibles) {
                    String anioParam = request.getParameter("anio");
            %>
            <option value="<%= anio%>" <%= (anioParam != null && anioParam.equals(String.valueOf(anio))) ? "selected" : ""%>><%= anio%></option>
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
        if (anioFiltro != null && !anioFiltro.isEmpty()) {
            try {
                Integer.parseInt(anioFiltro); // Verifica si el parámetro es un número válido
            } catch (NumberFormatException e) {
                // Si no es un número válido, puedes mostrar un mensaje de error
                System.out.println("Error: el año seleccionado no es válido.");
                anioFiltro = null;  // Restablecer el filtro a null si el año es inválido
            }
        }
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
            if (p.getFechaIngreso() != null && !p.getFechaIngreso().isEmpty()) {
                try {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaIngreso()));
                    int anio = cal.get(Calendar.YEAR);
                    ingresosPorAnio.put(anio, ingresosPorAnio.getOrDefault(anio, 0) + 1);
                    totalIngresos++;
                } catch (ParseException e) {
                    // Si la fecha tiene un formato incorrecto, se captura el error
                    System.out.println("Error al parsear la fecha: " + p.getFechaIngreso());
                }
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

            if (contador++ > 0) {
                datosGrafico += ",";
            }
            datosGrafico += "{ years: '" + anio + "', value: " + cantidad + " }";
        }
        datosGrafico += "]";
    %>

    <!-- Tabla principal -->
    <table border="1" class="table">
        <tr>
            <th>Identificación</th>
            <th>Nombre completo</th>
            <th>Cargo</th>
            <th>Unidad de negocio</th>
            <th>Fecha de ingreso</th>
        </tr>

        <%
            for (Persona p : listaPersonasFiltradas) {
                if (p.getFechaIngreso() == null || p.getFechaIngreso().isEmpty()) {
                    continue;
                }

                String nombreCargo = Cargo.getCargoPersona(p.getIdentificacion());
        %>
        <tr>
            <td><%= p.getIdentificacion()%></td>
            <td><%= p.getNombres()%> <%= p.getApellidos()%></td>
            <td><%= nombreCargo%></td>
            <td><%= p.getUnidadNegocio()%></td>
            <%
                String[] fechaIngresoPartes = p.getFechaIngreso().split("-");
                String anioIngreso = fechaIngresoPartes[0];
                String mesIngreso = fechaIngresoPartes[1];
            %>
            <td>
                <a href="ingresoMes.jsp?anio=<%= anioIngreso%>&mes=<%= mesIngreso%>">
                    <%= p.getFechaIngreso()%>
                </a>
            </td>
        </tr>

        <%
            }
        %>
    </table>

    <% if (!isDownloadMode) {%>
    <h3>Indicador de ingresos por año</h3>

    <!-- Contenedor horizontal -->
    <div style="display: flex; gap: 20px; align-items: flex-start;">
        <!-- Tabla de resumen -->
        <div>
            <table class="table" border="1">
                <tr><th>Año</th><th>Ingresos</th><th>%</th></tr>
                        <%=tablaResumen%>
            </table>
        </div>

        <!-- Gráfica -->
        <div id="chartdiv" style="width: 700px; height: 400px;"></div>
    </div>

    <!-- Scripts de gráfica -->
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
    <% }%>
