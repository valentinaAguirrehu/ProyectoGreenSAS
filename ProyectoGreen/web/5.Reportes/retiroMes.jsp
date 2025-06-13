<%@page import="clases.Cargo"%>
<%@page import="clases.Persona"%>
<%@page import="clases.InformacionLaboral"%> 
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.ParseException"%>

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
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String fechaActual = sdf.format(new Date());

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
        String nombreArchivo = "Reporte_Retiros_Por_Mes-" + fechaActual + extensionArchivo;
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
        text-shadow: 2px 2px 5px rgba(0,0,0,0.2);
        transition: transform 0.3s ease-in-out;
    }
    .titulo:hover {
        transform: scale(1.05);
    }
    .table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 4px 8px rgba(0,0,0,0.3);
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
    .titulo-mes {
        text-align: center;
        font-size: 18px;
        font-weight: bold;
        color: #000;
        margin-top: 20px;
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
    .btn-retorno {
        background-color: #2c6e49;
        color: white;
        border: none;
        padding: 16px 20px;
        font-size: 12px;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
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

        // Ya no mostramos el selector de meses aquí (lo eliminamos)
        
        String tituloMes = (mes > 0 && mes <= 12) ? mesesNombres[mes - 1] : "Todos los meses";
        String tituloAnio = (anio > 0) ? String.valueOf(anio) : "Todos los años";

        out.println("<h4 class='titulo-mes'>Mes: " + tituloMes + " - Año: " + tituloAnio + "</h4>");

        // Filtrar personas retiradas por mes y año
        List<Persona> listaRetirados = Persona.getListaEnObjetos("tipo = 'R'", null);
        List<Persona> retiradosFiltrados = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for (Persona p : listaRetirados) {
            InformacionLaboral infoLab = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());
            if (infoLab != null && infoLab.getFechaRetiro() != null && !infoLab.getFechaRetiro().trim().isEmpty()) {
                try {
                    Date fechaRetiro = sdf.parse(infoLab.getFechaRetiro());
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(fechaRetiro);
                    int anioRetiro = cal.get(Calendar.YEAR);
                    int mesRetiro = cal.get(Calendar.MONTH) + 1;

                    boolean coincideAnio = (anio == 0 || anioRetiro == anio);
                    boolean coincideMes = (mes == 0 || mesRetiro == mes);

                    if (coincideAnio && coincideMes) {
                        retiradosFiltrados.add(p);
                    }
                } catch (ParseException e) {
                    // ignorar error de parseo fecha
                }
            }
        }
    %>

    <p class="titulo-mes">Total de retirados: <%= retiradosFiltrados.size()%></p>

    <% if (!isDownloadMode) {%>
    <div class="iconos-container">
        <a href="retiroMes.jsp?formato=excel<%= (anio > 0 ? "&anio=" + anio : "") + (mes > 0 ? "&mes=" + mes : "")%>" target="_blank">
            <img src="../presentacion/iconos/excel.png" alt="Exportar a Excel">
        </a>
        <a href="retiroMes.jsp?formato=word<%= (anio > 0 ? "&anio=" + anio : "") + (mes > 0 ? "&mes=" + mes : "")%>" target="_blank">
            <img src="../presentacion/iconos/word.png" alt="Exportar a Word">
        </a>
    </div>
    <% } %>

    <table border="1" class="table">
        <tr>
            <th>Identificación</th>
            <th>Nombre completo</th>
            <th>Cargo</th>
            <th>Lugar de trabajo</th>
            <th>Unidad de negocio</th>
            <th>Fecha de retiro</th>
        </tr>
        <%
            for (Persona p : retiradosFiltrados) {
                Cargo cargoObj = new Cargo();
                String nombreCargo = cargoObj.getCargoPersona(p.getIdentificacion());
                InformacionLaboral infoLab = InformacionLaboral.getInformacionPorIdentificacion(p.getIdentificacion());

                String establecimiento = "";
                String unidadNegocio = "";
                String fechaRetiro = "";

                if (infoLab != null) {
                    establecimiento = (infoLab.getEstablecimiento() != null) ? infoLab.getEstablecimiento().toString() : "";
                    fechaRetiro = infoLab.getFechaRetiro() != null ? infoLab.getFechaRetiro() : "";
                    unidadNegocio = infoLab.getUnidadNegocio() != null ? infoLab.getUnidadNegocio() : "";
                } else {
                    establecimiento = "";
                    fechaRetiro = "";
                    unidadNegocio = "";
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

    <% if (!isDownloadMode) { %>
    <div style="text-align: center; margin-top: 20px;">
        <a href="retiroColaboradores.jsp">
            <button class="btn-retorno">VOLVER</button>
        </a>
    </div>
    <% }%>
</div>
