<%@page import="java.text.ParseException"%>
<%@page import="clases.Cargo"%>
<%@ page import="java.util.*" %>
<%@ page import="clases.Persona" %>
<%@ page import="clases.InformacionLaboral" %>
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
        margin: 0;
    }
    .titulo {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 2px;
        color: #2c6e49;
        text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
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
    .content {
        flex-grow: 1;
        padding: 20px;
    }
    .filtro-anio-form {
        display: flex;
        align-items: center;
        gap: 10px;
        background-color: #f4f4f4;
        padding: 12px 16px;
        border-radius: 6px;
        width: fit-content;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }
    .filtro-anio-form select {
        padding: 6px 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
</style>
<% } %>

<% if (!isDownloadMode) {%>
<%@ include file="../menu.jsp" %> 
<% } %> 

<div class="content">
    <h3 class="titulo">REPORTE DE INGRESO DE COLABORADORES - GREEN S.A.S</h3>

    <% if (!isDownloadMode) { %>
    <a href="ingresoColaboradores.jsp?formato=excel<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Exportar a Excel"></a>
    <a href="ingresoColaboradores.jsp?formato=word<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>

    <form method="get" class="filtro-anio-form">
        <label for="anio">Filtrar por año:</label>
        <select name="anio" onchange="this.form.submit()">
            <option value="">-- Todos --</option>
            <%
                Set<Integer> añosDisponibles = new HashSet<>();
                List<Persona> listaPersonas = Persona.getListaEnObjetos("tipo = 'C'", null);
                for (Persona p : listaPersonas) {
                    InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
                    if (info != null && info.getFechaIngreso() != null && !info.getFechaIngreso().isEmpty()) {
                        try {
                            Calendar cal = Calendar.getInstance();
                            cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(info.getFechaIngreso()));
                            añosDisponibles.add(cal.get(Calendar.YEAR));
                        } catch (ParseException e) {}
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
    <% } %>

    <%
        String anioFiltro = request.getParameter("anio");
        List<Persona> listaFiltrada = Persona.getListaEnObjetos("tipo = 'C'", "nombres");

        List<Persona> personasConIngreso = new ArrayList<>();
        for (Persona p : listaFiltrada) {
            InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (info != null && info.getFechaIngreso() != null && !info.getFechaIngreso().isEmpty()) {
                try {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(info.getFechaIngreso()));
                    int anio = cal.get(Calendar.YEAR);
                    if (anioFiltro == null || anioFiltro.isEmpty() || anio == Integer.parseInt(anioFiltro)) {
                        personasConIngreso.add(p);
                    }
                } catch (ParseException e) {}
            }
        }

        String[] nombresMeses = {
            "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
        };

        Map<String, Integer> ingresosPorMes = new LinkedHashMap<>();
        int totalIngresos = 0;

        for (Persona p : personasConIngreso) {
            InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (info != null && info.getFechaIngreso() != null && !info.getFechaIngreso().isEmpty()) {
                try {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(info.getFechaIngreso()));
                    int mes = cal.get(Calendar.MONTH);
                    String nombreMes = nombresMeses[mes];
                    ingresosPorMes.put(nombreMes, ingresosPorMes.getOrDefault(nombreMes, 0) + 1);
                    totalIngresos++;
                } catch (ParseException e) {}
            }
        }

        String tablaResumen = "";
        String datosGrafico = "[";
        int contador = 0;

        for (Map.Entry<String, Integer> entry : ingresosPorMes.entrySet()) {
            String mes = entry.getKey();
            int cantidad = entry.getValue();
            double porcentaje = (cantidad / (double) totalIngresos) * 100;
            tablaResumen += "<tr><td>" + mes + "</td><td>" + cantidad + "</td><td>" + String.format("%.2f", porcentaje) + "%</td></tr>";

            if (contador++ > 0) datosGrafico += ",";
            datosGrafico += "{ label: '" + mes + "', value: " + cantidad + " }";
        }
        datosGrafico += "]";
    %>

    <h3 class="titulo">Resumen Mensual</h3>
    <div style="display: flex; flex-wrap: wrap; gap: 20px; justify-content: space-between;">
        <div style="flex: 1; min-width: 300px;">
            <canvas id="graficaIngresos"></canvas>
        </div>
        <div style="flex: 1; min-width: 300px;">
            <table border="1" class="table">
                <thead>
                    <tr>
                        <th>Mes</th>
                        <th>Cantidad de Ingresos</th>
                        <th>Porcentaje</th>
                    </tr>
                </thead>
                <tbody>
                    <%= tablaResumen %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Tabla principal -->
    <table border="1" class="table" style="margin-top: 30px;">
        <tr>
            <th>Identificación</th>
            <th>Nombre</th>
            <th>Cargo</th>
            <th>Unidad de Negocio</th>
            <th>Fecha de Ingreso</th>
        </tr>
    <%
        for (Persona p : personasConIngreso) {
            InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (info == null || info.getFechaIngreso() == null || info.getFechaIngreso().isEmpty()) continue;
            String nombreCargo = Cargo.getCargoPersona(p.getIdentificacion());
            String[] fechaIngresoPartes = info.getFechaIngreso().split("-");
            String anioIngreso = fechaIngresoPartes[0];
            String mesIngreso = fechaIngresoPartes[1];
    %>
        <tr>
            <td><%= p.getIdentificacion() %></td>
            <td><%= p.getNombres() %> <%= p.getApellidos() %></td>
            <td><%= nombreCargo %></td>
            <td><%= info.getUnidadNegocio() %></td>
            <td>
                <a href="ingresoMes.jsp?anio=<%= anioIngreso %>&mes=<%= mesIngreso %>">
                    <%= info.getFechaIngreso() %>
                </a>
            </td>
        </tr>
    <%
        }
    %>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const data = <%= datosGrafico %>;
    const ctx = document.getElementById('graficaIngresos').getContext('2d');
    const labels = data.map(item => item.label);
    const values = data.map(item => item.value);

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Ingresos por Mes',
                data: values,
                backgroundColor: '#2c6e49',
                borderRadius: 4
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false },
                title: {
                    display: true,
                    text: 'Gráfico de Ingresos por Mes'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0
                    }
                }
            }
        }
    });
</script>
