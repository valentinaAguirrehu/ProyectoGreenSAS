<%-- 
    Document   : dotacionMenu
    Created on : 18 jun 2025, 14:16:59
    Author     : Angie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>GREEN S.A.S.</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            html, body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #fff;
                color: #111;
            }

            body {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px 30px;
                box-sizing: border-box;
            }

            h1 {
                text-align: center;
                font-size: 2.2rem;
                margin: 0 0 20px 0;
            }

            .module-container {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
                display: flex;
                flex-wrap: wrap;
                justify-content: center; 
                max-width: 1200px;
            }

            .module-card {
                background-color: #f9f9f9;
                border: 1px solid #ccc;
                border-radius: 12px;
                padding: 20px;
                width: 260px;
                text-align: center;
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
                text-decoration: none;
                color: #000;
                display: block;
            }

            .module-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            }

            .module-card i {
                font-size: 2rem;
                color: #111;
                margin-bottom: 12px;
            }

            .module-card h3 {
                margin: 10px 0;
                font-size: 1.2rem;
            }

            .module-card p {
                font-size: 0.95rem;
                color: #444;
            }

            .footer {
                text-align: center;
                margin-top: 30px;
            }

            .back-button {
                padding: 10px 20px;
                background-color: #000;
                color: #fff;
                border-radius: 8px;
                text-decoration: none;
            }

            .back-button:hover {
                background-color: #333;
            }

            @media (max-width: 900px) {
                .module-container {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 600px) {
                .module-container {
                    grid-template-columns: 1fr;
                }

                .module-card {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>

        <h1>DOTACIÓN</h1>

        <div class="module-container">
            <a href="ReporteIngresoUSO.jsp" class="module-card">
                <i class="fas fa-user-plus"></i>
                <h3>Ingresos de Colaboradores</h3>
                <p>Visualiza los ingresos por mes y año en tabla y gráfica. Permite el seguimiento de crecimiento del personal.</p>
            </a>

            <a href="reporteRetiroUSO.jsp" class="module-card">
                <i class="fas fa-user-minus"></i>
                <h3>Retiros de Colaboradores</h3>
                <p>Presenta los retiros por mes y año con representación gráfica. Útil para analizar rotación de personal.</p>
            </a>

            <a href="dotacionesEntregadas.jsp" class="module-card">
                <i class="fas fa-box-open"></i>
                <h3>Dotaciones Entregadas</h3>
                <p>Reporte mensual y anual con gráficas que muestra la cantidad de dotaciones entregadas al personal.</p>
            </a>
            <a href="reporteCumple.jsp" class="module-card">
                <i class="fas fa-birthday-cake"></i>
                <h3>Cumpleaños del Mes</h3>
                <p>Lista actualizada de los colaboradores que cumplen años en el mes actual. Solo muestra tabla, sin exportación.</p>
            </a>

            <a href="diaFamilia.jsp" class="module-card">
                <i class="fas fa-users-line"></i>
                <h3>Día de la Familia</h3>
                <p>Visualiza días acumulados por colaborador. Exportable a Excel y Word.</p>
            </a>

            <a href="vacaciones.jsp" class="module-card">
                <i class="fas fa-umbrella-beach"></i>
                <h3>Vacaciones</h3>
                <p>Muestra en tabla los días de vacaciones acumulados. Soporta exportación a Word y Excel.</p>
            </a>
        </div>

        <div class="footer">
            <a href="manualUso.jsp" class="back-button"><i class="fas fa-arrow-left"></i> Volver al Manual</a>
        </div>

    </body>
</html>

