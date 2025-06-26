 <%@ page import="java.util.*, java.text.DateFormatSymbols, java.text.SimpleDateFormat" %>
<%@ page import="clases.DetalleEntrega, clases.EntregaDotacion, clases.Persona, clases.Prenda" %>

<%
    boolean isDownloadMode = request.getParameter("formato") != null;
    if (isDownloadMode) {
        String tipo = "application/vnd.ms-excel", ext = ".xls";
        if ("word".equals(request.getParameter("formato"))) {
            tipo = "application/msword";
            ext = ".doc";
        }
        String fecha = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
        response.setContentType(tipo);
        response.setHeader("Content-Disposition", "inline; filename=\"Reporte_Dotacion_" + fecha + ext + "\"");
    }

    String anio = request.getParameter("anio"),
            unidad = request.getParameter("unidad"),
            estado = request.getParameter("estado"),
            tipoEnt = request.getParameter("tipo");

    List<DetalleEntrega> lista = DetalleEntrega.getDetallesFiltrados(anio, unidad, estado, tipoEnt);

    Set<String> aniosSet = new TreeSet<>(Collections.reverseOrder());
    for (DetalleEntrega d : lista) {
        String f = d.getEntrega().getFechaEntrega();
        if (f != null && f.length() >= 4) {
            aniosSet.add(f.substring(0, 4));
        }
    }

    Map<String, List<DetalleEntrega>> agrupado = new LinkedHashMap<>();
    for (DetalleEntrega de : lista) {
        String idEnt = de.getEntrega().getIdEntrega();
        List<DetalleEntrega> subset = agrupado.get(idEnt);
        if (subset == null) {
            subset = new ArrayList<>();
            agrupado.put(idEnt, subset);
        }
        subset.add(de);

    }

    Map<String, Integer> entregasGrafico = new LinkedHashMap<>();
    for (List<DetalleEntrega> dets : agrupado.values()) {
        EntregaDotacion ed = dets.get(0).getEntrega();
        String f = ed.getFechaEntrega();
        String label = (anio != null && !anio.isEmpty())
                ? new DateFormatSymbols().getMonths()[Integer.parseInt(f.substring(5, 7)) - 1]
                : f.substring(0, 4);
        entregasGrafico.put(label, entregasGrafico.getOrDefault(label, 0) + 1);
    }

    Map<String, String> mapaPrendas = new HashMap<>();
    for (Prenda p : Prenda.getListaEnObjetos(null, null)) {
        mapaPrendas.put(p.getIdPrenda(), p.getNombre());
    }
%>

<% if (!isDownloadMode) { %>
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: Arial, sans-serif; line-height: 1.4; }
  .content { max-width: 1200px; margin: auto; padding: 20px; }
  .titulo { text-align: center; margin-bottom: 20px; }

  .export-icons {
    display: flex; justify-content: center; gap: 20px;
    margin-bottom: 20px;
  }
  .descargar img {
    width: 32px; height: 32px;
    transition: transform .2s;
  }
  .descargar img:hover { transform: scale(1.1); }

  .filtro-form {
    display: flex; flex-wrap: wrap; justify-content: center;
    gap: 15px; margin-bottom: 30px;
  }
  .filtro-form select { padding: 8px; min-width: 150px; }

  .table {
    width: 100%; border-collapse: collapse;
    margin-bottom: 30px;
  }
  .table th, .table td {
    border: 1px solid #ccc;
    padding: 10px; text-align: center;
    vertical-align: middle;
  }
  .table th { background: #f4f4f4; font-weight: bold; }

  @media (max-width: 768px) {
    .table thead { display: none; }
    .table tr {
      display: block;
      margin-bottom: 15px;
      border: 1px solid #ddd;
    }
    .table td {
      display: flex;
      justify-content: space-between;
      padding: 8px;
      border-bottom: 1px solid #eee;
      position: relative;
    }
    .table td::before {
      content: attr(data-label);
      flex-basis: 40%;
      font-weight: bold;
      text-align: left;
    }
    .table td:last-child { border-bottom: 0; }
  }

  .contenedor-flex {
    display: flex; flex-wrap: wrap;
    justify-content: center; gap: 30px;
    margin-top: 40px;
  }
  .tabla-resumen-pequena {
    width: 100%; max-width: 300px;
    border-collapse: collapse;
    font-size: 0.9rem;
    border-radius: 6px;
    overflow: hidden;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }
  .tabla-resumen-pequena th, .tabla-resumen-pequena td {
    padding: 8px; border: 1px solid #ccc;
    text-align: center;
  }
  .tabla-resumen-pequena th {
    background: #2c6e49; color: #fff;
  }
  .tabla-resumen-pequena tfoot td {
    font-weight: bold;
    background: #daf2da; color: #2c6e49;
  }
  .chart-container {
    flex: 1;
    min-width: 300px;
    max-width: 600px;
    aspect-ratio: 3.5;
    position: relative;
  }
</style>

<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>
<% } %>

<link rel="stylesheet" href="../presentacion/style-Cargos.css">

<div class="content">
  <h3 class="titulo">REPORTE DE DOTACIÓN</h3>

  <% if (!isDownloadMode) { %>
    <div class="export-icons">
      <a class="descargar" href="dotacion.jsp?formato=excel<%= request.getQueryString()!=null?"&"+request.getQueryString().replaceAll("formato=\\w+&?",""):""%>" target="_blank"><img src="../presentacion/iconos/excel.png" alt="Excel"></a>
      <a class="descargar" href="dotacion.jsp?formato=word<%= request.getQueryString()!=null?"&"+request.getQueryString().replaceAll("formato=\\w+&?",""):""%>" target="_blank"><img src="../presentacion/iconos/word.png" alt="Word"></a>
    </div>

    <form method="get" class="filtro-form" id="filtroForm">
      <select name="anio"><option value="">-- Año --</option>
      <% for (String y : aniosSet) { %>
        <option value="<%= y %>" <%= y.equals(anio)?"selected":"" %>><%= y %></option>
      <% } %></select>

      <select name="unidad"><option value="">-- Unidad --</option>
      <% Set<String> us = new TreeSet<>(); for (DetalleEntrega d : lista) us.add(d.getUnidadNegocio());
         for (String u : us) { %>
        <option value="<%= u %>" <%= u.equals(unidad)?"selected":"" %>><%= u %></option>
      <% } %></select>

      <select name="estado">
        <option value="">-- Estado --</option>
        <option value="Nueva" <%= "Nueva".equals(estado)?"selected":"" %>>Nueva</option>
        <option value="Usada" <%= "Usada".equals(estado)?"selected":"" %>>Usada</option>
      </select>

      <select name="tipo"><option value="">-- Tipo Entrega --</option>
      <% Set<String> ts = new TreeSet<>(); for (DetalleEntrega d:lista) ts.add(d.getEntrega().getTipoEntrega());
         for (String t : ts) { %>
        <option value="<%= t %>" <%= t.equals(tipoEnt)?"selected":"" %>><%= t %></option>
      <% } %></select>
    </form>
    <script>
      document.querySelectorAll('#filtroForm select').forEach(s=>s.onchange=()=>document.getElementById('filtroForm').submit());
    </script>
  <% } %>

  <% if (isDownloadMode) { %>
    <style>
      table { border-collapse: collapse; width:100%; font-family:Arial,sans-serif; }
      th, td { border:1px solid #000; padding:5px; text-align:center; }
      th { background-color:#4CAF50; color:#fff; }
    </style>
  <% } %>

  <table class="table">
    <thead>
      <tr>
        <th>Identificación</th><th>Colaborador</th><th>Fecha Entrega</th><th>Tipo Entrega</th>
        <th>Estado</th><th>Unidad de Negocio</th><th>Responsable</th>
        <th>Prenda</th><th>Talla</th><th>Observación</th>
      </tr>
    </thead>
    <tbody>
    <% for (List<DetalleEntrega> dets : agrupado.values()) {
         EntregaDotacion ed = dets.get(0).getEntrega();
         String nombrePersona = Persona.getNombrePorId(ed.getIdPersona());
         for (DetalleEntrega d : dets) {
           String prenda = mapaPrendas.getOrDefault(d.getIdPrenda(),"Desconocida");
    %>
      <tr>
        <td data-label="Identificación"><%= ed.getIdPersona() %></td>
        <td data-label="Colaborador"><%= nombrePersona %></td>
        <td data-label="Fecha Entrega"><%= ed.getFechaEntrega() %></td>
        <td data-label="Tipo Entrega"><%= ed.getTipoEntrega() %></td>
        <td data-label="Estado"><%= d.getEstado() %></td>
        <td data-label="Unidad de Negocio"><%= d.getUnidadNegocio() %></td>
        <td data-label="Responsable"><%= ed.getResponsable() %></td>
        <td data-label="Prenda"><%= prenda %></td>
        <td data-label="Talla"><%= d.getTalla() %></td>
        <td data-label="Observación"><%= ed.getObservacion() %></td>
      </tr>
    <% } } %>
    </tbody>
  </table>
<% if (!isDownloadMode && !entregasGrafico.isEmpty()) {%>
<h3 class="titulo">Indicador por <%= (anio != null && !anio.isEmpty() ? "Meses" : "Años")%></h3>
<style>
    .contenedor-flex {
        display: flex;
        gap: 20px;
        align-items: flex-start;
        flex-wrap: wrap;
        justify-content: center;
        margin-top: 40px;
    }
    .tabla-resumen-pequena {
        border-collapse: collapse;
        width: 300px;
        font-family: Arial, sans-serif;
        font-size: 13px;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }
    .tabla-resumen-pequena th,
    .tabla-resumen-pequena td {
        padding: 8px;
        border: 1px solid #ccc;
        text-align: center;
    }
    .tabla-resumen-pequena th {
        background-color: #2c6e49;
        color: white;
    }
    .tabla-resumen-pequena tfoot td {
        font-weight: bold;
        background-color: #daf2da;
        color: #2c6e49;
    }
    .chart-container {
        position: relative;
        width: 600px;  /* puedes usar % o fijo */
        aspect-ratio: 3.5; /* ancho:alto */
    }
</style>

<div class="contenedor-flex">
    <table class="tabla-resumen-pequena">
        <thead>
            <tr><th><%= (anio != null && !anio.isEmpty() ? "Mes" : "Año")%></th><th>Entregas</th></tr>
        </thead>
        <tbody>
            <% int total = 0;
                for (Map.Entry<String, Integer> e : entregasGrafico.entrySet()) {
                    total += e.getValue();%>
            <tr><td><%= e.getKey()%></td><td><%= e.getValue()%></td></tr>
            <% }%>
        </tbody>
        <tfoot><tr><td>Total</td><td><%= total%></td></tr></tfoot>
    </table>

    <!-- Gráfico dentro de un contenedor con aspect-ratio -->
    <div class="chart-container">
        <canvas id="graficoEntregas"></canvas>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('graficoEntregas').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<% boolean first = true;
                for (String lbl : entregasGrafico.keySet()) {
                    if (!first) {
                        out.print(",");
                    }
                    out.print("\"" + lbl + "\"");
                    first = false;
                }%>],
            datasets: [{
                    label: '<%= anio != null && !anio.isEmpty() ? "Entregas por Mes en " + anio : "Entregas por Año"%>',
                    data: [<% boolean fb = true;
                        for (Integer v : entregasGrafico.values()) {
                            if (!fb) {
                                out.print(",");
                            }
                            out.print(v);
                            fb = false;
                        } %>],
                    backgroundColor: 'rgba(100,149,237,0.7)',
                    borderColor: '#6495ED',
                    borderWidth: 2,
                    borderRadius: 6,
                    barPercentage: 0.6,
                    categoryPercentage: 0.8
                }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false, // 
            scales: {
                y: {beginAtZero: true, ticks: {stepSize: 1}}
            },
            plugins: {
                legend: {labels: {font: {weight: 'bold', size: 14}}},
                tooltip: {backgroundColor: '#daf2da'}
            }
        }
    });

</script>

<% }%>
</div>
