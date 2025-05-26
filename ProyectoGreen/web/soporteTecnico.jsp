<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Soporte Técnico - GREEN S.A.S.</title>

    <!-- Font Awesome para íconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #111;
            margin-bottom: 40px;
            font-size: 2.5rem;
            text-align: center;
        }

        .team-container {
            display: flex;
            justify-content: space-between;
            max-width: 1080px;
            width: 100%;
            gap: 20px;
            flex-wrap: nowrap;
        }

        .profile-card {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 15px;
            padding: 30px 25px;
            width: 100%;
            max-width: 320px;
            text-align: center;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            flex: 1;
        }

        .profile-card:hover {
            transform: translateY(-8px);
        }

        .profile-card img {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #000;
            margin-bottom: 15px;
        }

        .profile-card h2 {
            font-size: 1.3rem;
            margin: 10px 0 18px;
            color: #000;
        }

        .profile-card p {
            margin: 10px 0;
            font-size: 1rem;
            color: #444;
        }

        .label {
            font-weight: 600;
            color: #000;
            margin-right: 8px;
            display: inline-block;
            min-width: 90px;
            text-align: right;
        }

        .profile-card a {
            color: #000;
            text-decoration: none;
            font-weight: 500;
        }

        .profile-card a:hover {
            text-decoration: underline;
        }

        .back-button {
            margin-top: 50px;
            padding: 12px 25px;
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }

        .back-button:hover {
            background-color: #333;
        }

        .watermark {
            position: fixed;
            bottom: 10px;
            right: 20px;
            color: rgba(100, 100, 100, 0.2);
            font-size: 1.5rem;
            font-weight: bold;
            pointer-events: none;
            user-select: none;
        }

        @media (max-width: 1024px) {
            .team-container {
                flex-wrap: wrap;
                justify-content: center;
            }

            .profile-card {
                max-width: 90%;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>

    <h1>Equipo de Soporte Técnico</h1>

    <div class="team-container">
        <!-- Persona 1 -->
        <div class="profile-card">
            <img src="presentacion/imagenes/imagensena.PNG" alt="Foto de Angie">
            <h2>Angie Benavides</h2>
            <p><span class="label"><i class="fas fa-envelope"></i>Correo:</span>
                <a href="https://mail.google.com/mail/?view=cm&fs=1&to=angiebenavides1809@gmail.com" target="_blank">angiebenavides1809@gmail.com</a>
            </p>
            <p><span class="label"><i class="fab fa-linkedin"></i>LinkedIn:</span>
                <a href="https://www.linkedin.com/in/angiebenavides" target="_blank">Ver perfil</a>
            </p>
        </div>

        <!-- Persona 2 -->
        <div class="profile-card">
            <img src="presentacion/imagenes/imagensena.PNG" alt="Foto de Maria">
            <h2>Maria de los Angeles Perez</h2>
            <p><span class="label"><i class="fas fa-envelope"></i>Correo:</span>
                <a href="https://mail.google.com/mail/?view=cm&fs=1&to=marysalazarr27@gmail.com" target="_blank">marysalazarr27@gmail.com</a>
            </p>
            <p><span class="label"><i class="fab fa-linkedin"></i>LinkedIn:</span>
                <a href="https://www.linkedin.com/in/mariaperez" target="_blank">Ver perfil</a>
            </p>
        </div>

        <!-- Persona 3 -->
        <div class="profile-card">
            <img src="presentacion/imagenes/imagensena.PNG" alt="Foto de Valentina">
            <h2>Valentina Aguirre</h2>
            <p><span class="label"><i class="fas fa-envelope"></i>Correo:</span>
                <a href="https://mail.google.com/mail/?view=cm&fs=1&to=valentinaaguirre@gmail.com" target="_blank">valentinaaguirre@gmail.com</a>
            </p>
            <p><span class="label"><i class="fab fa-linkedin"></i>LinkedIn:</span>
                <a href="https://www.linkedin.com/in/valentinaaguirre" target="_blank">Ver perfil</a>
            </p>
        </div>
    </div>

    <!-- Botón Volver -->
    <a href="0.Inicio/principal.jsp" class="back-button"><i class="fas fa-arrow-left"></i> Volver</a>

    <!-- Marca de agua -->
    <div class="watermark">ProyectoGreen</div>

</body>
</html>
