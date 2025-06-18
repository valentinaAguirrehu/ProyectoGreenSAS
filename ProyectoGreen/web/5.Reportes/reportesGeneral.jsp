<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="../presentacion/style-Cargos.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html, body {
                height: 100%;
                
            }

            .container {
                display: flex;
                height: 100vh;
                width: 100%;
            }

            .menu {
                width: 220px;

            }

            .content {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: white;
            }

            .export-box {
                text-align: center;
                margin-left: -200px; /* Ajuste para centrar mejor visualmente */
            }


            .export-box h2 {
                font-size: 1.6rem;
                font-weight: bold;
                color: #145a32;
                margin-bottom: 10px;
            }

            .export-box p {
                font-size: 1rem;
                color: #333;
                margin-bottom: 20px;
            }

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
                text-decoration: none;
                transition: background-color 0.3s ease;
            }

            .export-button img {
                width: 20px;
                height: auto;
                margin-right: 8px;
            }

            .export-button:hover {
                background-color: #0e3e24;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="menu">
                <jsp:include page="../menu.jsp" />
            </div>

            <div class="content">
                <div class="export-box">
                    <h2>Exportar Reporte General</h2>
                    <p>Descarga toda la información de colaboradores en formato Excel</p>
                    <form action="../5.Reportes/reporteGeneral.jsp" method="get">
                        <button type="submit" class="export-button">
                            <img src="../presentacion/iconos/excel.png" alt="Excel">
                            Descargar Excel
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
