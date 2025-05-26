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
                justify-content: center;
                gap: 40px;
                max-width: 1100px;
                width: 100%;
                flex-wrap: nowrap; /* evita que salten a una nueva línea */
            }

            .profile-card {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 15px;
                padding: 30px 25px;
                width: 320px;
                text-align: center;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
                flex-shrink: 0;
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
                margin: 10px 0 10px;
                color: #000;
                word-wrap: break-word;
            }

            .profile-card p {
                margin: 6px 0;
                font-size: 1rem;
                color: #444;
            }

            .label {
                font-weight: 600;
                color: #000;
                margin-right: 5px;
            }

            .fa-phone, .fa-envelope {
                color: #000;
                margin-right: 6px;
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

            @media (max-width: 1100px) {
                .team-container {
                    flex-wrap: wrap;
                }
            }

            @media (max-width: 768px) {
                .profile-card {
                    width: 90%;
                }

                .team-container {
                    gap: 20px;
                }
                .watermark {
                    position: fixed;
                    bottom: 10px;
                    right: 20px;
                    color: rgba(100, 100, 100, 0.2); /* Gris claro con transparencia */
                    font-size: 1.5rem;
                    font-weight: bold;
                    z-index: 0;
                    pointer-events: none; /* No interfiere con clics */
                    user-select: none;    /* No se puede seleccionar */
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
                <p><span class="label"><i class="fas fa-phone"></i>Celular:</span> 3175862921</p>
                <p><span class="label"><i class="fas fa-envelope"></i>Correo:</span> angiefer352@gmail.com</p>
            </div>

            <!-- Persona 2 -->
            <div class="profile-card">
                <img src="presentacion/imagenes/imagensena.PNG" alt="Foto de Lina">
                <h2>Maria de los Angeles Perez</h2>
                <p><span class="label"><i class="fas fa-phone"></i>Celular:</span> 3176973975</p>
                <p><span class="label"><i class="fas fa-envelope"></i>Correo:</span> marysalazarr27@gmail.com</p>
            </div>

            <!-- Persona 3 -->
            <div class="profile-card">
                <img src="presentacion/imagenes/imagensena.PNG" alt="Foto de Valentina">
                <h2>Valentina Aguirre</h2>
                <p><span class="label"><i class="fas fa-phone"></i>Celular:</span> 3146172629</p>
                <p><span class="label"><i class="fas fa-envelope"></i>Correo:</span> valentinaaguirre@gmail.com</p>
            </div>
            
        </div>

        <!-- Botón Volver -->
        <a href="0.Inicio/principal.jsp" class="back-button"><i class="fas fa-arrow-left"></i> Volver</a>


    </body>
    
</html>