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
        response.setHeader("Content-Disposition", "inline; filename=\"Reporte_Ingresos" + extensionArchivo + "\"");
    }
%>

<% if (!isDownloadMode) {%>
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
    }
       .titulo-mes {
        text-align: center;  /* Alineación a la izquierda */
        font-size: 18px;  /* Título más grande */
        font-weight: bold;  /* Negrita */
        color: #000;
        margin-top: 20px;  /* Espacio superior */
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
        overflow-x: auto;
        margin-left: 220px;
        padding: 20px;
    
    }
    
    .btn-retorno {
    background-color: #2c6e49;
    color: white;
    border: none;
    padding: 16px 20px;
    font-size: 12px;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.btn-retorno:hover {
    background-color: #24723b;
}
.iconos-container {
    text-align: center;
    margin: 15px 0;
}

.iconos-container a {
    margin: 0 4px;
    display: inline-block;
}

.iconos-container img {
    width: 35px;
    height: 30px;
}
s
</style>
<%@ include file="../menu.jsp" %>
<% } %>

<div class="content">
    <h3 class="titulo">REPORTE DE INGRESOS POR MES - GREEN S.A.S</h3>

    <% 
        // Obtener el nombre del mes en base al parámetro mes
        String[] mesesNombres = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
        String mesNombre = "";
        if (mesParam != null && !mesParam.isEmpty()) {
            int mesIndex = Integer.parseInt(mesParam) - 1; // Ajuste para que enero sea 0
            mesNombre = mesesNombres[mesIndex];
        }

   
    %>



    <%
        // Condición para filtrar ingresos del mes
        String condicion = "tipo = 'C' AND fechaIngreso IS NOT NULL";
        if (anioParam != null && !anioParam.isEmpty()) {
            condicion += " AND YEAR(fechaIngreso) = " + anioParam;
        }
        if (mesParam != null && !mesParam.isEmpty()) {
            condicion += " AND MONTH(fechaIngreso) = " + mesParam;
        }

        List<Persona> ingresosFiltrados = Persona.getListaEnObjetos(condicion, "fechaIngreso ASC");

        // Indicador de ingresos por mes general
        List<Persona> todosIngresos = Persona.getListaEnObjetos("tipo = 'C' AND fechaIngreso IS NOT NULL", null);
        Map<Integer, Integer> ingresosPorMes = new HashMap<>();
        int totalIngresos = 0;

        for (Persona p : todosIngresos) {
            if (p.getFechaIngreso() != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(p.getFechaIngreso()));
                int mes = cal.get(Calendar.MONTH) + 1;
                ingresosPorMes.put(mes, ingresosPorMes.getOrDefault(mes, 0) + 1);
                totalIngresos++;
            }
        }

        String tablaResumen = "";
        String datosGrafico = "[";        
        int contador = 0;
        for (int mes = 1; mes <= 12; mes++) {
            if (ingresosPorMes.containsKey(mes)) {
                int cantidad = ingresosPorMes.get(mes);
                double porcentaje = (cantidad / (double) totalIngresos) * 100;
                String estiloResaltado = (mesParam != null && mesParam.equals(String.valueOf(mes))) ? " style='background-color: #fff3b0; font-weight: bold;'" : "";
                tablaResumen += "<tr" + estiloResaltado + "><td>" + mesesNombres[mes - 1] + "</td><td>" + cantidad + "</td><td>" + String.format("%.2f", porcentaje) + "%</td></tr>";
                if (contador++ > 0) {
                    datosGrafico += ",";
                }
                datosGrafico += "{ mes: '" + mesesNombres[mes - 1] + "', value: " + cantidad + " }";
            }
        }
        datosGrafico += "]"; 
    %>
    <%
      // Mostrar el título con el mes seleccionado
         if (!mesNombre.isEmpty()) {
            out.println("<h4 class='titulo-mes'>Ingresos del mes de " + mesNombre + " " + (anioParam != null ? anioParam : "") + "</h4>");        }
    %>
    <% if (!isDownloadMode) { %>
<div class="iconos-container">
    <a href="ingresoMes.jsp?formato=excel<%= (anioParam != null ? "&anio=" + anioParam : "") + (mesParam != null ? "&mes=" + mesParam : "")%>" target="_blank">
        <img src="../presentacion/iconos/excel.png" alt="Exportar a Excel">
    </a>
    <a href="ingresoMes.jsp?formato=word<%= (anioParam != null ? "&anio=" + anioParam : "") + (mesParam != null ? "&mes=" + mesParam : "")%>" target="_blank">
        <img src="../presentacion/iconos/word.png" alt="Exportar a Word">
    </a>
</div>
<% } %>

    <table border="1" class="table">
        <tr>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Unidad de Negocio</th>
            <th>Establecimiento</th>
            <th>Cargo</th>
            <th>Fecha de Ingreso</th>
        </tr>
        <% for (Persona p : ingresosFiltrados) {
                String cargo = Cargo.getCargoPersona(p.getIdentificacion());
        %>
        <tr>
            <td><%= p.getNombres()%></td>
            <td><%= p.getApellidos()%></td>
            <td><%= p.getUnidadNegocio()%></td>
            <td><%= p.getEstablecimiento()%></td>
            <td><%= cargo%></td>
            <td><%= p.getFechaIngreso()%></td>
        </tr>
        <% } %>
    </table>
     <div style="text-align: center; margin-top: 20px;">
    <a href="ingresoColaboradores.jsp">
        <button class="btn-retorno">VER AÑO</button>
    </a>
</div>
    <% if (!isDownloadMode) {%>
    <h3>Indicador de ingresos por mes</h3>
    <div style="display: flex; gap: 20px; align-items: flex-start;">
        <div>
            <table class="table" border="1">
                <tr><th>Mes</th><th>Ingresos</th><th>%</th></tr>
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
                name: "Ingresos",
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
    <% }%>
</div>
