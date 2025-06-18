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
            height: 100%;
            font-family: 'Segoe UI', sans-serif;
            background-color: #fff;
            color: #111;
            overflow: hidden; /* No scroll */
        }

        body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 20px 30px;
            box-sizing: border-box;
        }

        h1 {
            text-align: center;
            font-size: 2.2rem;
            margin-bottom: 20px;
        }

        .module-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            flex-grow: 1;
        }

        .row {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: nowrap;
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
            color: #000;
            text-decoration: none;
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
            margin-top: 10px;
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

        @media (max-width: 768px) {
            .row {
                flex-wrap: wrap;
            }

            .module-card {
                width: 90%;
            }
        }
    </style>
</head>
<body>

    <h1>Manual de Uso - Módulo Colaboradores</h1>

    <div class="module-container">
        <!-- Fila de 3 -->
        <div class="row">
            <div class="module-card">
                <i class="fas fa-leaf"></i>
                <h3>Activos Green</h3>
                <p>Muestra personal que pertenece al programa Green de la empresa. Usado para control exclusivo de esta categoría.</p>
            </div>
            <div class="module-card">
                <i class="fas fa-user-clock"></i>
                <h3>Temporales</h3>
                <p>Lista de colaboradores temporales con fecha de inicio y finalización. Permite gestión específica por contrato temporal.</p>
            </div>
            <div class="module-card">
                <i class="fas fa-user-slash"></i>
                <h3>Colaboradores Retirados</h3>
                <p>Historial de colaboradores que han salido de la empresa. Aquí se pueden consultar sus datos y fecha de retiro.</p>
            </div>
        </div>

        <!-- Una tarjeta centrada abajo -->
        <div class="row">
            <div class="module-card">
                <i class="fas fa-user-graduate"></i>
                <h3>Aprendices</h3>
                <p>Sección dedicada a aprendices en formación. Permite su seguimiento independiente al resto de colaboradores.</p>
            </div>
        </div>
    </div>

    <div class="footer">
        <a href="manualUso.jsp" class="back-button"><i class="fas fa-arrow-left"></i> Volver al Manual</a>
    </div>

</body>
</html>
