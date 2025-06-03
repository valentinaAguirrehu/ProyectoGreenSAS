<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manual de Uso - Reporte de Ingresos</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #fff;
            color: #111;
            margin: 0;
            padding: 40px;
            line-height: 1.6;
        }

        h1, h2, h3 {
            color: #000;
            text-align: center;
        }

        .section {
            max-width: 1000px;
            margin: 0 auto 60px;
        }

        ul {
            padding-left: 25px;
            margin-top: 10px;
            margin-bottom: 20px;
        }

        .image-container {
            text-align: center;
            margin: 30px 0;
        }

        .image-container img {
            max-width: 800px;
            width: 90%;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        p {
            text-align: justify;
            margin-bottom: 15px;
        }

        .back-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #000;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            margin-top: 40px;
        }

        .back-button:hover {
            background-color: #333;
        }
    </style>
</head>
<body>

<div class="section">
    <h2>Reporte de Ingreso de Colaboradores - GREEN S.A.S</h2>

    <p>
        Este módulo permite al usuario consultar y analizar los <strong>ingresos laborales de los colaboradores</strong> de GREEN S.A.S, agrupados por año o mes, según el filtro aplicado.
    </p>

    <p>
        Proporciona una <strong>tabla detallada</strong> con información personal y laboral, además de una sección de <strong>resumen estadístico</strong> con gráficos interactivos. También permite exportar los datos en formatos Excel o Word.
    </p>

    <div class="image-container">
        <img src="../presentacion/imagenesManual/ReporteIngreso.PNG" alt="Vista general del reporte">
    </div>

    <h3>¿Cómo utilizar este módulo?</h3>

    <p>
        En la parte superior de la interfaz encontrarás dos botones con íconos: uno para <strong>exportar a Excel</strong> y otro para <strong>exportar a Word</strong>. Estos archivos incluyen todos los datos visibles según el año filtrado.
    </p>

    <div class="image-container">
        <img src="../presentacion/imagenesManual/2ReporteIngreso.png" alt="Opciones de exportación">
    </div>

    <p>
        Justo debajo se encuentra un <strong>filtro desplegable por año</strong>. Al seleccionar un año específico, el sistema agrupará los ingresos por <strong>meses</strong> de ese año y se mostraran en la grafica.
    </p>

    <div class="image-container">
        <img src="../presentacion/imagenesManual/indicadorReporte.PNG" alt="Filtro por año">
    </div>


    <h3>Navegación hacia detalle mensual</h3>

    <p>
        Cada fecha de ingreso actúa como un hipervínculo. Al hacer clic, se redirige a una interfaz que muestra todos los ingresos del mes correspondiente, permitiendo un análisis más detallado.
    </p>

    <div class="image-container">
        <img src="../presentacion/imagenesManual/IngresoMes.PNG" alt="Detalle mensual de ingresos">
    </div>

    <a href="../9.ManualUso/UsuReportes.jsp" class="back-button">← Volver </a>
</div>

</body>
</html>
