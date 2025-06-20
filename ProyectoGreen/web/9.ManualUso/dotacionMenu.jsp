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

        <h1>Módulo de dotación</h1>

        <div class="module-container">
            <a href="usoPrendas.jsp" class="module-card">
                <i class="fas fa-tshirt"></i>
                <h3>Gestión de prendas</h3>
                <p>Administra y visualiza las prendas disponibles para registrar en el inventario de dotación.</p>
            </a>

            <a href="usoInvDotNueva.jsp" class="module-card">
                <i class="fas fa-warehouse"></i>
                <h3>Inventario de dotación nueva</h3>
                <p>Visualiza el inventario de prendas nuevas listas para ser entregadas al personal.</p>
            </a>

            <a href="usoInvDotUsada.jsp" class="module-card">
                <i class="fas fa-boxes-stacked"></i>
                <h3>Inventario de dotación usada</h3>
                <p>Visualiza el inventario de prendas devueltas por el personal, con su respectivo estado de usado.</p>
            </a>

            <a href="usoEntregaDot.jsp" class="module-card">
                <i class="fas fa-truck-loading"></i>
                <h3>Entrega de dotación</h3>
                <p>Conoce la guía sobre el proceso de entrega de dotación al personal.</p>
            </a>

            <a href="usoDevolucionDot.jsp" class="module-card">
                <i class="fas fa-undo-alt"></i>
                <h3>Devolución de dotación</h3>
                <p>Conoce la guía sobre el proceso de devolución de dotación del personal.</p>
            </a>
        </div>

        <div class="footer">
            <a href="manualUso.jsp" class="back-button"><i class="fas fa-arrow-left"></i> Volver al Manual</a>
        </div>

    </body>
</html>

