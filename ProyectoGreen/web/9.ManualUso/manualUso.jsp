<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manual de Uso - GREEN S.A.S.</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #fff;
                color: #111;
                margin: 0;
                padding: 20px 30px; /* reducido */
                overflow-x: hidden;
            }

            h1 {
                text-align: center;
                font-size: 2.2rem;
                margin-bottom: 30px; /* reducido */
            }

            .module-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 30px;
            }

            .module-card {
                background-color: #f9f9f9;
                border: 1px solid #ccc;
                border-radius: 12px;
                padding: 20px;
                width: 280px;
                text-align: center;
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
                cursor: pointer;
                text-decoration: none;
                color: #000;
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

            .back-button {
                margin-top: 30px; /* reducido */
                display: inline-block;
                padding: 10px 20px;
                background-color: #000;
                color: #fff;
                border-radius: 8px;
                text-decoration: none;
            }

            .back-button:hover {
                background-color: #333;
            }

            @media (max-width: 768px) {
                .module-card {
                    width: 90%;
                }
            }
        </style>
    </head>
    <body>

        <h1>Manual de Uso del PROYECTO GREEN S.A.S.</h1>

        <div class="module-container">
            <!-- Módulo 1 -->
            <a href="UsoCargo.jsp" class="module-card">
                <i class="fas fa-briefcase"></i>
                <h3>Módulo Cargos</h3>
                <p>Gestiona los cargos y roles asignados a cada colaborador de la empresa.</p>
            </a>

            <!-- Módulo 2 -->
            <a href="UsoColaboradores.jsp" class="module-card">
                <i class="fas fa-users"></i>
                <h3>Módulo Colaboradores</h3>
                <p>Gestión de información y registro de empleados de la empresa.</p>
            </a>

            <!-- Módulo 3: Historia Laboral -->
            <a href="usoHistoriaLaboral.jsp" class="module-card">
                <i class="fas fa-book-open"></i>
                <h3>Historia Laboral</h3>
                <p>Consulta y seguimiento del historial laboral de los colaboradores.</p>
            </a>

            <!-- Módulo 4 -->
            <a href="ruta/Dotaciones.jsp" class="module-card">
                <i class="fas fa-tshirt"></i>
                <h3>Módulo Dotaciones</h3>
                <p>Registro y entrega de dotaciones al personal.</p>
            </a>

            <!-- Módulo 5 -->
            <a href="UsuReportes.jsp" class="module-card">
                <i class="fas fa-chart-line"></i>
                <h3>Reportes e Indicadores</h3>
                <p>Visualización de métricas clave de gestión humana.</p>
            </a>

            <!-- Módulo 6 -->
            <a href="../9.ManualUso/usoNotificaciones.jsp" class="module-card">
                <i class="fas fa-bell"></i>
                <h3>Módulo Notificaciones</h3>
                <p>Gestión y envío de notificaciones internas al personal.</p>
            </a>
        </div>

        <div style="text-align: center;">
            <a href="../0.Inicio/principal.jsp" class="back-button"><i class="fas fa-arrow-left"></i> Volver al Inicio</a>
        </div>

    </body>
</html>
