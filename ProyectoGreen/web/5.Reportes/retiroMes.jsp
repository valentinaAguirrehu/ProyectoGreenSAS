<%@page import="clases.Cargo"%>
<%@page import="clases.Persona"%>
<%@page import="clases.InformacionLaboral"%> 
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    boolean isDownloadMode = request.getParameter("formato") != null;

    String anioParam = request.getParameter("anio");
    String mesParam = request.getParameter("mes");

    int anio = 0;
    int mes = 0;

    try {
        anio = anioParam != null ? Integer.parseInt(anioParam) : 0;
    } catch (Exception e) {
        anio = 0;
    }
    try {
        mes = mesParam != null ? Integer.parseInt(mesParam) : 0;
    } catch (Exception e) {
        mes = 0;
    }

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
        String nombreArchivo = "Reporte_Retirados_Por_Mes-" + fechaActual + extensionArchivo;
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
    <h3 class="titulo">REPORTE DE COLABORADORES RETIRADOS POR MES - GREEN S.A.S</h3>

    <%
        String[] mesesNombres = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
        String mesNombre = (mes > 0 && mes <= 12) ? mesesNombres[mes - 1] : "";
        String condicion = "tipo = 'R' AND FechaRetiro IS NOT NULL";

        if (anio > 0) {
            condicion += " AND YEAR(FechaRetiro) = " + anio;
        }
        if (mes > 0) {
            condicion += " AND MONTH(FechaRetiro) = " + mes;
        }

        List<Persona> todas = Persona.getListaEnObjetos("tipo = 'R'", null);
        List<Persona> retirados = new ArrayList<>();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for (Persona p : todas) {
            InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (info != null && info.getFechaRetiro() != null && !info.getFechaRetiro().isEmpty()) {
                Date fecha = sdf.parse(info.getFechaRetiro());
                Calendar cal = Calendar.getInstance();
                cal.setTime(fecha);

                int anioRetiro = cal.get(Calendar.YEAR);
                int mesRetiro = cal.get(Calendar.MONTH) + 1;

                if ((anio == 0 || anioRetiro == anio) && (mes == 0 || mesRetiro == mes)) {
                    retirados.add(p);
                }
            }
        }

        List<Persona> retiradosTodos = Persona.getListaEnObjetos("tipo = 'R'", null);

        Map<Integer, Integer> retirosPorMes = new TreeMap<>();
        int totalRetiros = 0;

        for (Persona p : retiradosTodos) {
            InformacionLaboral infoLab = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (infoLab != null) {
                String fechaRetiro = infoLab.getFechaRetiro();
                if (fechaRetiro != null && !fechaRetiro.isEmpty()) {
                    Date fecha = sdf.parse(fechaRetiro);
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(fecha);
                    int mesRetiro = cal.get(Calendar.MONTH) + 1;
                    retirosPorMes.put(mesRetiro, retirosPorMes.getOrDefault(mesRetiro, 0) + 1);
                    totalRetiros++;
                }
            }
        }

        StringBuilder tablaResumen = new StringBuilder();
        StringBuilder datosGrafico = new StringBuilder("[");
        int contador = 0;
        for (int m = 1; m <= 12; m++) {
            int cant = retirosPorMes.getOrDefault(m, 0);
            if (cant > 0) {
                double porcentaje = (cant / (double) totalRetiros) * 100;
                tablaResumen.append("<tr><td>").append(mesesNombres[m - 1]).append("</td><td>").append(cant).append("</td><td>")
                        .append(String.format("%.2f", porcentaje)).append("%</td></tr>");
                if (contador++ > 0) {
                    datosGrafico.append(",");
                }
                datosGrafico.append("{ \"mes\": \"").append(mesesNombres[m - 1]).append("\", \"value\": ").append(cant).append(" }");
            }
        }
        datosGrafico.append("]");
    %>

    <%   // Mostrar el mes y año en el título
        if (!mesNombre.isEmpty()) {
            out.println("<h4 class='titulo-mes'>Mes: " + mesNombre + " " + (anioParam != null ? anioParam : "") + "</h4>");
        } else {
            out.println("<h4 class='titulo-mes'>Retiros (Mes no seleccionado)</h4>");
        }%>

    <% if (!isDownloadMode) {%>
    <div class="iconos-container">
        <a href="retiroMes.jsp?formato=excel<%= (anioParam != null ? "&anio=" + anioParam : "") + (mesParam != null ? "&mes=" + mesParam : "")%>" target="_blank">
            <img src="../presentacion/iconos/excel.png" alt="Exportar a Excel">
        </a>
        <a href="retiroMes.jsp?formato=word<%= (anioParam != null ? "&anio=" + anioParam : "") + (mesParam != null ? "&mes=" + mesParam : "")%>" target="_blank">
            <img src="../presentacion/iconos/word.png" alt="Exportar a Word">
        </a>
    </div>
    <% } %>

    <table border="1" class="table">
        <tr>
            <th>Identificación</th>
            <th>Nombre completo</th>
            <th>Cargo</th>
            <th>Establecimiento</th>
            <th>Unidad de negocio</th>
            <th>Fecha de retiro</th>
        </tr>
        <%
            for (Persona p : retirados) {
                Cargo cargoObj = new Cargo();
                String nombreCargo = cargoObj.getCargoPersona(p.getIdentificacion());
                InformacionLaboral infoLab = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
                String establecimiento = "";
                String fechaRetiro = "";
                String unidadNegocio = "";  // <-- inicializo aquí

                if (infoLab != null) {
                    establecimiento = infoLab.getEstablecimiento();
                    fechaRetiro = infoLab.getFechaRetiro();
                    // Supongamos que existe método getUnidadNegocio()
                    unidadNegocio = infoLab.getUnidadNegocio();
                }
        %>
        <tr>
            <td><%= p.getIdentificacion()%></td>
            <td><%= p.getNombres() + " " + p.getApellidos()%></td>
            <td><%= nombreCargo%></td>
            <td><%= establecimiento%></td>
            <td><%= unidadNegocio%></td>
            <td><%= fechaRetiro%></td>
        </tr>
        <% } %>
    </table>
    <%
        if (!isDownloadMode) {
    %>
    <div style="text-align: center; margin-top: 20px;">
        <a href="retiroColaboradores.jsp">
            <button class="btn-retorno">VOLVER</button>
        </a>
    </div>
    <%
        }
    %>
</div>