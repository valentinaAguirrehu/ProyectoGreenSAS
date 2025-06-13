<%@page import="clases.InformacionLaboral"%>
<%@page import="clases.Cargo"%>
<%@page import="java.util.*" %>
<%@page import="clases.Persona" %>
<%@page import="java.text.SimpleDateFormat" %>

<%
    boolean isDownloadMode = request.getParameter("formato") != null;
    if (isDownloadMode) {
        String tipoContenido = "";
        String extensionArchivo = "";

        // Obtener fecha actual formateada dd-MM-yyyy
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy");
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
            default:
                // En caso de formato inválido, cancelar modo descarga
                isDownloadMode = false;
        }
        if (isDownloadMode) {
            // Aquí se agrega el guion y la fecha actual
            String nombreArchivo = "Reporte_Retirados_Por_Año-" + fechaActual + extensionArchivo;

            response.setContentType(tipoContenido);
            response.setHeader("Content-Disposition", "inline; filename=\"" + nombreArchivo + "\"");
        }
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
    <h3 class="titulo">REPORTE DE RETIROS DE COLABORADORES - GREEN S.A.S</h3>

    <%
        // Obtengo la lista de personas retiradas
        List<Persona> retirados = Persona.getListaEnObjetos("tipo = 'R'", null);

        // Set para años disponibles
        Set<Integer> años = new TreeSet<>(); // TreeSet para ordenar años

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for (Persona p : retirados) {
            InformacionLaboral hl = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (hl != null) {
                String fechaRetiroStr = hl.getFechaRetiro();
                if (fechaRetiroStr != null && !fechaRetiroStr.isEmpty()) {
                    try {
                        Date fechaRetiroDate = sdf.parse(fechaRetiroStr);
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(fechaRetiroDate);
                        años.add(cal.get(Calendar.YEAR));
                    } catch (Exception e) {
                        // Ignorar formato inválido
                    }
                }
            }
        }
    %>

    <% if (!isDownloadMode) {%>
    <a href="retiroColaboradores.jsp?formato=excel<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Exportar a Excel"></a>
    <a href="retiroColaboradores.jsp?formato=word<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>

    <form method="get" class="filtro-anio-form">
        <label for="anio">Filtrar por año:</label>
        <select name="anio" onchange="this.form.submit()">
            <option value="">-- Todos --</option>
            <%
                String paramAnio = request.getParameter("anio");
                for (Integer anio : años) {
            %>
            <option value="<%= anio%>" <%= (paramAnio != null && paramAnio.equals(String.valueOf(anio))) ? "selected" : ""%>>
                <%= anio%>
            </option>
            <% } %>
        </select>
    </form>
    <% } %>

    <%
        String anioFiltro = request.getParameter("anio");
        List<Persona> filtrados = new ArrayList<>();
        Map<String, Integer> retirosPorPeriodo = new TreeMap<>();
        int totalRetiros = 0;

        for (Persona p : retirados) {
            InformacionLaboral hl = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (hl != null && hl.getFechaRetiro() != null && !hl.getFechaRetiro().isEmpty()) {
                try {
                    Date fechaRetiroDate = sdf.parse(hl.getFechaRetiro());
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(fechaRetiroDate);
                    int anio = cal.get(Calendar.YEAR);
                    int mes = cal.get(Calendar.MONTH) + 1;

                    if (anioFiltro == null || anioFiltro.isEmpty()) {
                        // Agrupar por año
                        String clave = String.valueOf(anio);
                        retirosPorPeriodo.put(clave, retirosPorPeriodo.getOrDefault(clave, 0) + 1);
                    } else if (anio == Integer.parseInt(anioFiltro)) {
                        // Agrupar por mes
                        String clave = String.format("%02d", mes);
                        retirosPorPeriodo.put(clave, retirosPorPeriodo.getOrDefault(clave, 0) + 1);
                    }

                    // Solo cuenta como total si entra en la condición
                    if (anioFiltro == null || anioFiltro.isEmpty() || anio == Integer.parseInt(anioFiltro)) {
                        filtrados.add(p);
                        totalRetiros++;
                    }

                } catch (Exception e) {
                    // Ignorar fechas inválidas
                }
            }
        }

        StringBuilder tablaResumen = new StringBuilder();
        StringBuilder datosGrafico = new StringBuilder("[");
        int contador = 0;

        for (Map.Entry<String, Integer> entry : retirosPorPeriodo.entrySet()) {
            String periodo = entry.getKey();
            int cantidad = entry.getValue();
            double porcentaje = (cantidad / (double) totalRetiros) * 100;

            // Si se filtró por año, el período es un mes, así que lo convertimos a nombre
            String label = periodo;
            if (anioFiltro != null && !anioFiltro.isEmpty()) {
                String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
                    "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                label = meses[Integer.parseInt(periodo) - 1];
            }

            tablaResumen.append("<tr><td>").append(label).append("</td><td>")
                    .append(cantidad).append("</td><td>")
                    .append(String.format("%.2f", porcentaje)).append("%</td></tr>");

            if (contador++ > 0) {
                datosGrafico.append(",");
            }
            datosGrafico.append("{ years: '").append(label).append("', value: ").append(cantidad).append(" }");
        }
        datosGrafico.append("]");

    %>

    <table border="1" class="table">
        <tr>
            <th>Identificación</th>
            <th>Nombre completo</th>
            <th>Cargo</th>
            <th>Lugar de trabajo</th>
            <th>Unidad de negocio</th>
            <th>Fecha de retiro</th>
        </tr>
        <%            for (Persona p : filtrados) {
                InformacionLaboral hl = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
                if (hl == null || hl.getFechaRetiro() == null || hl.getFechaRetiro().isEmpty()) {
                    continue;
                }
                try {
                    Date fechaRetiroDate = sdf.parse(hl.getFechaRetiro());
                    String nombreCargo = Cargo.getCargoPersona(p.getIdentificacion());
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(fechaRetiroDate);

                    String anioLink = String.valueOf(cal.get(Calendar.YEAR));
                    String mesLink = String.format("%02d", cal.get(Calendar.MONTH) + 1);
        %>
        <tr>
            <td><%= p.getIdentificacion()%></td>
            <td><%= p.getNombres()%> <%= p.getApellidos()%></td>
            <td><%= nombreCargo%></td>
            <td><%= hl.getEstablecimiento()%></td> 
            <td><%= hl.getUnidadNegocio()%></td>  
            <td>
                <a href="retiroMes.jsp?anio=<%= anioLink%>&mes=<%= mesLink%>">
                    <%= sdf.format(fechaRetiroDate)%>
                </a>
            </td>
        </tr>
        <%
                } catch (Exception e) {
                    // Ignorar errores de parseo de fecha
                }
            }
        %>
    </table>

    <% if (!isDownloadMode) {%>
    <h3 class="titulo">Indicador por años</h3>
    <div style="display: flex; gap: 20px; align-items: flex-start;">
        <div>
            <table class="table" border="1">
                <tr><th>Año</th><th>Retiros</th><th>%</th></tr>
                        <%= tablaResumen.toString()%>
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
                var data = <%= datosGrafico.toString()%>;
                xAxis.data.setAll(data);
                series.data.setAll(data);
                series.appear(1000);
                chart.appear(1000, 100);
            });
    </script>
    <% }%>
</div>
