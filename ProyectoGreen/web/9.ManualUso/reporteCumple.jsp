<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GREEN S.A.S.</title>
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
            max-width: 900px;
            margin: 0 auto;
        }

        ul {
            padding-left: 25px;
            margin-top: 10px;
            margin-bottom: 20px;
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

        /* Carrusel */
        .carousel {
            position: relative;
            max-width: 900px; /* ampliado para que coincida con sección */
            margin: 30px auto;
            overflow: hidden;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            background-color: #f9f9f9;
        }

        .carousel-images {
            display: flex;
            transition: transform 0.4s ease-in-out;
            width: 100%;
        }

        .carousel-slide {
            min-width: 100%;
            box-sizing: border-box;
            text-align: center;
            padding: 0; /* quitamos padding para que imagen ocupe todo */
        }

        .carousel-slide img {
            width: 100%;
            max-width: 900px;
            height: auto;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin: 0 auto;
            display: block;
        }

        /* Quitamos el texto debajo de las imágenes */
        .carousel-slide p {
            display: none;
        }

        .carousel-button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0,0,0,0.5);
            color: white;
            border: none;
            font-size: 32px;
            padding: 12px 18px;
            cursor: pointer;
            z-index: 1;
            border-radius: 4px;
            user-select: none;
        }

        .carousel-button.left {
            left: 10px;
        }

        .carousel-button.right {
            right: 10px;
        }

        .image-container {
            text-align: center;
            margin: 30px 0;
        }

        .image-container img {
            max-width: 500px;
            width: 90%;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<div class="section">
    <h2>Cumpleañeros del Mes - GREEN S.A.S</h2>

    <p>
        Este módulo permite visualizar de forma dinámica a los <strong>colaboradores que cumplen años</strong> en el mes actual.
    </p>

    <h3>¿Cómo navegar entre los meses?</h3>

    <p>
        En la parte inferior del módulo encontrarás dos <strong>flechas de navegación</strong> que te permiten avanzar o retroceder entre los meses.
    </p>

    <!-- Carrusel con imágenes centradas sin texto -->
    <div class="carousel">
        <button class="carousel-button left" onclick="moverCarrusel(-1)">&#10094;</button>
        <div class="carousel-images" id="carrusel">
            <div class="carousel-slide">
                <img src="../presentacion/imagenesManual/CUMPLEAÑOS.PNG" alt="Vista cumpleaños">
            </div>
            <div class="carousel-slide">
                <img src="../presentacion/imagenesManual/CumpleañosAdvertencia.PNG" alt="Advertencia">
            </div>
        </div>
        <button class="carousel-button right" onclick="moverCarrusel(1)">&#10095;</button>
    </div>

    <p>
        Solo se permite consultar <strong>hasta tres meses anteriores o tres meses posteriores</strong> al mes actual. Si intentas acceder a un mes fuera de este rango, el sistema mostrará una alerta y regresará automáticamente al mes actual.
    </p>

    <h3>Visualización del documento de identidad</h3>

    <p>
        Si el colaborador tiene disponible su documento de identidad, se mostrará un <strong>ícono de documento</strong> que puede ser abierto en una nueva pestaña para su visualización.
    </p>

    <div class="image-container">
        <img src="../presentacion/imagenesManual/documentoCumpleaños.png" alt="Documento de identidad del cumpleañero">
    </div>

    <p>
        En caso de que el colaborador no tenga documento disponible, se indicará con el texto <strong>"No disponible"</strong>.
    </p>

    <a href="../9.ManualUso/UsuReportes.jsp" class="back-button">← Volver </a>
</div>

<script>
    let indice = 0;

    function moverCarrusel(direccion) {
        const carrusel = document.getElementById('carrusel');
        const totalSlides = carrusel.children.length;

        indice += direccion;
        if (indice < 0) indice = totalSlides - 1;
        if (indice >= totalSlides) indice = 0;

        const slideWidth = carrusel.children[0].clientWidth;
        carrusel.style.transform = 'translateX(' + (-slideWidth * indice) + 'px)';
    }
</script>

</body>
</html>
