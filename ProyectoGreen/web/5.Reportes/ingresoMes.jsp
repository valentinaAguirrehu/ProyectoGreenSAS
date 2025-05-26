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
        }
        response.setContentType(tipoContenido);
        String nombreArchivo = "Reporte_Ingresos_Por_Mes-" + fechaActual + extensionArchivo;
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
    .titulo-mes {
        text-align: center;  /* Alineación a la izquierda */
        font-size: 18px;  /* Título más grande */
        font-weight: bold;  /* Negrita */
        color: #000;
        margin-top: 20px;  /* Espacio superior */
    }

    .iconos-container {
        text-align: center; /* Centra los iconos */
        margin: 15px 0; /* Espaciado superior e inferior */
    }

    .iconos-container a {
        margin: 0 4px; /* Espacio entre los iconos */
        display: inline-block;
    }

    .iconos-container img {
        width: 35px; /* Tamaño de los iconos (ajusta según lo necesites) */
        height: 30px;
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

</style>

<% } %>

<% if (!isDownloadMode) {%>
<%@ include file="../menu.jsp" %> 
<% } %> 

<div class="content">
    <h3 class="titulo">REPORTE DE INGRESO DE COLABORADORES POR MES - GREEN S.A.S</h3>

    <%
        String anioParam = request.getParameter("anio");
        String mesParam = request.getParameter("mes");

        List<Persona> listaFiltrada = Persona.getListaEnObjetos("tipo = 'C'", "nombres");

        List<Persona> personasConIngreso = new ArrayList<>();
        for (Persona p : listaFiltrada) {
            InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (info != null && info.getFechaIngreso() != null && !info.getFechaIngreso().isEmpty()) {
                try {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(info.getFechaIngreso()));
                    int anio = cal.get(Calendar.YEAR);
                    int mes = cal.get(Calendar.MONTH) + 1; // Enero = 1

                    boolean anioCoincide = (anioParam == null || anioParam.isEmpty() || anio == Integer.parseInt(anioParam));
                    boolean mesCoincide = (mesParam == null || mesParam.isEmpty() || mes == Integer.parseInt(mesParam));

                    if (anioCoincide && mesCoincide) {
                        personasConIngreso.add(p);
                    }
                } catch (ParseException | NumberFormatException e) {
                    // Puedes loguear el error si deseas
                }
            }
        }

        String[] nombresMeses = {
            "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
        };

        // Obtener el nombre del mes si está presente
        String mesNombre = "";
        if (mesParam != null && !mesParam.isEmpty()) {
            try {
                int mesIndex = Integer.parseInt(mesParam) - 1;
                if (mesIndex >= 0 && mesIndex < nombresMeses.length) {
                    mesNombre = nombresMeses[mesIndex];
                }
            } catch (NumberFormatException e) {
                // mes inválido
            }
        }

        // Mostrar título con mes y año
        if (!mesNombre.isEmpty()) {
            out.println("<h4 class='titulo-mes'>Mes: " + mesNombre + " " + (anioParam != null ? anioParam : "") + "</h4>");
        } else {
            out.println("<h4 class='titulo-mes'>Retiros (Mes no seleccionado)</h4>");
        }

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
                } catch (ParseException e) {
                }
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

            if (contador++ > 0) {
                datosGrafico += ",";
            }
            datosGrafico += "{ label: '" + mes + "', value: " + cantidad + " }";
        }
        datosGrafico += "]";
    %>

    <!-- Mostrar el conteo de personas -->
    <p class="titulo-mes">Total de ingresos: <%= personasConIngreso.size()%></p>

    <% if (!isDownloadMode) {%>
    <div class="iconos-container">
        <a href="ingresoMes.jsp?formato=excel<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Exportar a Excel"></a>
        <a href="ingresoMes.jsp?formato=word<%= request.getParameter("anio") != null ? "&anio=" + request.getParameter("anio") : ""%>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Exportar a Word"></a>
    </div>    
    <% } %>

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
            <td><%= info.getUnidadNegocio()%></td>
            <td>

                <%= info.getFechaIngreso()%>

            </td>
        </tr>
        <%
            }
        %>
    </table>
    <%
        if (!isDownloadMode) {
    %>
    <div style="text-align: center; margin-top: 20px;">
        <a href="ingresoColaboradores.jsp">
            <button class="btn-retorno">VOLVER</button>
        </a>
    </div>
    <%
        }
    %>
</div>