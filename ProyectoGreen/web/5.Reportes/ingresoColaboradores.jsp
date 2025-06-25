<%@page import="java.text.ParseException"%>
<%@page import="clases.Cargo"%>
<%@ page import="java.util.*" %>
<%@ page import="clases.Persona" %>
<%@ page import="clases.InformacionLaboral" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String formatoExportacion = request.getParameter("formato");
    boolean isDownloadMode = formatoExportacion != null;
    boolean isWordExport = "word".equals(formatoExportacion);

    if (isDownloadMode) {
        String tipoContenido = "";
        String extensionArchivo = "";

        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy");
        String fechaActual = sdf.format(new java.util.Date());

        switch (formatoExportacion) {
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
        String nombreArchivo = "Reporte_Ingresos_Por_Año-" + fechaActual + extensionArchivo;
        response.setHeader("Content-Disposition", "inline; filename=\"" + nombreArchivo + "\"");
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
<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %> 
<% } %> 

<div class="content">
<% if (isWordExport) {
     String logoURL = request.getScheme() + "://" +
                      request.getServerName() + ":" +
                      request.getServerPort() +
                      request.getContextPath() + "/presentacion/iconos/logoEmpresa.jpg";
%>
    <table width="100%" style="border: none; margin-bottom: 10px;">
        <tr>
            <td style="text-align: left;">
                <img src="<%= logoURL %>" alt="Logo"
                     style="width: 120px; height: 40px; object-fit: contain; display: block;">
            </td>
        </tr>
    </table>
<% } %>

    <h3 class="titulo">REPORTE DE INGRESO DE COLABORADORES - GREEN S.A.S</h3>

    <% if (!isDownloadMode) { %>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">

        <!-- Filtro por año a la izquierda -->
        <form method="get" class="filtro-anio-form" style="margin: 0;">
            <label for="anio">Filtrar por año:</label>
            <select name="anio" onchange="this.form.submit()">
                <option value="">-- Todos --</option>
                <%
                    Set<Integer> añosDisponibles = new TreeSet<>(Collections.reverseOrder());
                    List<Persona> listaPersonas = Persona.getListaEnObjetos("tipo = 'C'", null);
                    for (Persona p : listaPersonas) {
                        InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
                        if (info != null && info.getFechaIngreso() != null && !info.getFechaIngreso().isEmpty()) {
                            try {
                                Calendar cal = Calendar.getInstance();
                                cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(info.getFechaIngreso()));
                                añosDisponibles.add(cal.get(Calendar.YEAR));
                            } catch (ParseException e) {
                                System.out.println("Error al parsear la fecha: " + info.getFechaIngreso());
                            }
                        }
                    }
                    for (Integer anio : añosDisponibles) {
                        String anioParam = request.getParameter("anio");
                %>
                <option value="<%= anio%>" <%= (anioParam != null && anioParam.equals(String.valueOf(anio))) ? "selected" : ""%>><%= anio%></option>
                <% }%>
            </select>
        </form>

        <div class="descargar" style="display: flex; gap: 10px;">
            <a href="ingresoColaboradores.jsp?formato=excel<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank">
                <img src="../presentacion/iconos/excel.png" alt="Exportar a Excel">
            </a>
            <a href="ingresoColaboradores.jsp?formato=word<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank">
                <img src="../presentacion/iconos/word.png" alt="Exportar a Word">
            </a>
        </div>
    </div>
    <% } %>

    <%
        String anioFiltro = request.getParameter("anio");
        String condicion = "tipo = 'C'";
        List<Persona> listaPersonasFiltradas = Persona.getListaEnObjetos(condicion, "nombres");

        List<Persona> personasConIngreso = new ArrayList<>();
        for (Persona p : listaPersonasFiltradas) {
            InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (info != null && info.getFechaIngreso() != null && !info.getFechaIngreso().isEmpty()) {
                if (anioFiltro == null || anioFiltro.isEmpty()) {
                    personasConIngreso.add(p);
                } else {
                    try {
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(info.getFechaIngreso()));
                        int anio = cal.get(Calendar.YEAR);
                        if (anio == Integer.parseInt(anioFiltro)) {
                            personasConIngreso.add(p);
                        }
                    } catch (ParseException e) {
                        System.out.println("Error al parsear la fecha de ingreso");
                    }
                }
            }
        }

        Map<String, Integer> ingresosPorPeriodo = new TreeMap<>();
        int totalIngresos = 0;

        for (Persona p : listaPersonasFiltradas) {
            InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (info != null && info.getFechaIngreso() != null && !info.getFechaIngreso().isEmpty()) {
                try {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(info.getFechaIngreso()));

                    int anio = cal.get(Calendar.YEAR);
                    int mes = cal.get(Calendar.MONTH) + 1;

                    if (anioFiltro == null || anioFiltro.isEmpty()) {
                        // Agrupar por año
                        String clave = String.valueOf(anio);
                        ingresosPorPeriodo.put(clave, ingresosPorPeriodo.getOrDefault(clave, 0) + 1);
                        totalIngresos++;
                    } else if (anio == Integer.parseInt(anioFiltro)) {
                        // Agrupar por mes del año filtrado
                        String clave = String.format("%02d", mes); // ejemplo: "01" para enero
                        ingresosPorPeriodo.put(clave, ingresosPorPeriodo.getOrDefault(clave, 0) + 1);
                        totalIngresos++;
                    }

                } catch (ParseException e) {
                    System.out.println("Error al parsear la fecha para gráfica");
                }
            }
        }

        String tablaResumen = "";
        String datosGrafico = "[";
        int contador = 0;

        for (Map.Entry<String, Integer> entry : ingresosPorPeriodo.entrySet()) {
            String periodo = entry.getKey(); // año o mes
            int cantidad = entry.getValue();
            double porcentaje = (cantidad / (double) totalIngresos) * 100;

            // Si es mes, conviértelo a nombre de mes
            String label = periodo;
            if (anioFiltro != null && !anioFiltro.isEmpty()) {
                String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
                    "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                int mesIndex = Integer.parseInt(periodo) - 1;
                label = meses[mesIndex];
            }

            tablaResumen += "<tr><td>" + label + "</td><td>" + cantidad + "</td><td>" + String.format("%.2f", porcentaje) + "%</td></tr>";

            if (contador++ > 0) {
                datosGrafico += ",";
            }
            datosGrafico += "{ years: '" + label + "', value: " + cantidad + " }";
        }
        datosGrafico += "]";

    %>

    <!-- Tabla principal -->
    <table border="1" class="table">
        <tr>
            <th>Identificación</th>
            <th>Nombre</th>
            <th>Cargo</th>
            <th>Establecimiento</th>
            <th>Unidad de Negocio</th>
            <th>Fecha de Ingreso</th>
        </tr>
        <%            for (Persona p : personasConIngreso) {
                InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
                if (info == null || info.getFechaIngreso() == null || info.getFechaIngreso().isEmpty()) {
                    continue;
                }

                String nombreCargo = Cargo.getCargoPersona(p.getIdentificacion());
                String[] fechaIngresoPartes = info.getFechaIngreso().split("-");
                String anioIngreso = fechaIngresoPartes[0];
                String mesIngreso = fechaIngresoPartes[1];
        %>
        <tr>
            <td><%= p.getIdentificacion()%></td>
            <td><%= p.getNombres()%> <%= p.getApellidos()%></td>
            <td><%= nombreCargo%></td>
            <td><%= info.getEstablecimiento()%></td> 
            <td><%= info.getUnidadNegocio()%></td>
            <td>
                <a href="ingresoMes.jsp?anio=<%= anioIngreso%>&mes=<%= mesIngreso%>">
                    <%= info.getFechaIngreso()%>
                </a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <style>
        .contenedor-flex {
            display: flex;
            gap: 20px; /* espacio entre gráfica y tabla */
            align-items: flex-start; /* alinear arriba */
            flex-wrap: wrap; /* se acomoda mejor en pantallas pequeñas */
        }

        .tabla {
            border-collapse: collapse;
            width: 300px;
        }

        .tabla th, .tabla td {
            padding: 8px;
            text-align: center;
            border: 1px solid #ccc;
        }

        #chartdiv {
            width: 600px;
            height: 400px;
        }
    </style>

    <% if (!isDownloadMode) {%>
    <h3 class="titulo">Indicador por años</h3>
    <div style="display: flex; gap: 20px; align-items: flex-start;">
        <div>
            <table class="table" border="1">
                <tr><th>Año</th><th>Ingresos</th><th>%</th></tr>
                        <%= tablaResumen.toString()%>
            </table>
        </div>
        <div id="chartdiv" style="width: 700px; height: 400px;"></div>
    </div>

    <!-- Incluir la librería -->
    <script src="https://cdn.amcharts.com/lib/5/index.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>

    <script>
                am5.ready(function () {
                    var root = am5.Root.new("chartdiv");
                    root.setThemes([am5themes_Animated.new(root)]);
                    var chart = root.container.children.push(am5xy.XYChart.new(root, {
                        panX: true,
                        panY: true,
                        wheelX: "panX",
                        wheelY: "zoomX"
                    }));

                    var xAxis = chart.xAxes.push(am5xy.CategoryAxis.new(root, {
                        categoryField: "years",
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
                        categoryXField: "years"
                    }));

                    var data = <%= datosGrafico%>;
                    xAxis.data.setAll(data);
                    series.data.setAll(data);
                });
    </script>
    <% }%>
</div>
