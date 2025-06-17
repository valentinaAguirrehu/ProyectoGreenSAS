<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    /* Caja centrada y limpia */
    .export-box {
      max-width: 400px;
      margin: 20px auto;
      padding: 20px;
      background-color: #ffffff; /* fondo blanco */
      border-radius: 6px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
      text-align: center;
    }
    .export-box h2 {
      margin-bottom: 10px;
      font-size: 1.4rem;
      color: #145a32;
    }
    .export-box p {
      margin-bottom: 20px;
      font-size: 1rem;
      color: #333;
    }
    /* Botón azul personalizado con imagen */
    .export-button {
      background-color: #145a32;
      color: white;
      border: none;
      padding: 10px 24px;
      font-size: 1rem;
      border-radius: 4px;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
    }
    .export-button img {
      width: 20px;
      height: auto;
      margin-right: 8px;
    }
    .export-button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
  <jsp:include page="../menu.jsp" />

  <div class="export-box">
    <h2>Exportar Reporte General</h2>
    <p>Descarga toda la información de colaboradores en formato Excel</p>
    <form action="../5.Reportes/reporteGeneral.jsp" method="get">
      <button type="submit" class="export-button">
          <img src="../presentacion/iconos/excel.png" alt="Excel"> <!-- aquí tu icono -->
        Descargar Excel
      </button>
    </form>
  </div>
</body>
</html>
