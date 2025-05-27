<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manual de Uso - Módulo de Cargos</title>

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
            max-width: 600px;
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
            margin-left: 40px;
        }

        .back-button:hover {
            background-color: #333;
        }

        /* Carrusel */
        .carousel-container {
            position: relative;
            max-width: 600px;
            margin: 30px auto;
            overflow: hidden;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .carousel-slide {
            display: flex;
            transition: transform 0.5s ease-in-out;
        }

        .carousel-slide img {
            width: 100%;
            flex-shrink: 0;
            user-select: none;
        }

        .carousel-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0,0,0,0.5);
            border: none;
            color: white;
            font-size: 24px;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 50%;
            user-select: none;
            z-index: 10;
        }

        .left-btn {
            left: 10px;
        }

        .right-btn {
            right: 10px;
        }

        .carousel-btn:hover {
            background-color: rgba(0,0,0,0.8);
        }
    </style>
</head>
<body>

    <div class="section">
        <h2>Módulo de Cargos</h2>

        <p>
            Este módulo permite al usuario <strong>crear, modificar y eliminar cargos</strong> dentro de la empresa GREEN S.A.S.
            Su propósito es garantizar una asignación organizada y coherente de cargos en toda la plataforma, facilitando la
            gestión de vacantes y empleados. La información registrada incluye:
        </p>

        <ul>
            <li>Nombre del cargo</li>
            <li>Código del cargo</li>
            <li>Descripción del cargo</li>
        </ul>

        <div class="image-container">
            <img src="../presentacion/imagenesManual/cargos.PNG" alt="Formulario para agregar cargo">
        </div>

        <h3>¿Cómo agregar un cargo?</h3>

        <p>
            En la parte superior de la interfaz, encontrará un ícono con el símbolo <strong>“+”</strong>. Al hacer clic en este botón, será redirigido a una nueva interfaz para registrar el nuevo cargo.
        </p>

        <p>
            Allí deberá ingresar:
        </p>

        <ul>
            <li><strong>Nombre del cargo:</strong> Debe ser claro y representativo.</li>
            <li><strong>Código del cargo:</strong> Asegúrese de que no esté repetido en otro registro.</li>
            <li><strong>Descripción:</strong> Explique brevemente las funciones o el propósito del cargo.</li>
        </ul>

        <p>
            Una vez completado el formulario, haga clic en el botón <strong>“Adicionar”</strong> (de color rojo) para guardar la información.
        </p>

        <p>
            Además, dispone de un buscador que le permite filtrar por nombre o código de cargo para facilitar la consulta de registros existentes.
        </p>

        <div class="image-container">
            <img src="../presentacion/imagenesManual/AdicionCargo.PNG" alt="Formulario para agregar cargo">
        </div>

        <h3>¿Cómo modificar o eliminar un cargo?</h3>

        <p>
            En la tabla que se muestra de los cargos existentes, se encuentran dos íconos junto a cada registro: el ícono de un <strong>lápiz</strong> y el de un <strong>basurero</strong>. 
            El <strong>lápiz</strong> representa la acción de <strong>modificar</strong> un cargo; al hacer clic en él, se abrirá una interfaz con los datos del cargo previamente registrados, permitiendo editarlos y guardarlos nuevamente. 
            Por su parte, el ícono de <strong>basurero</strong> permite <strong>eliminar</strong> el cargo correspondiente de forma definitiva. Es recomendable confirmar esta acción, ya que eliminar un cargo lo quita del sistema completamente.
        </p>

        <!-- Carrusel de imágenes -->
        <div class="carousel-container">
            <button class="carousel-btn left-btn" onclick="moveSlide(-1)">&#10094;</button>
            
            <div class="carousel-slide">
                <img src="../presentacion/imagenesManual/cargos.PNG" alt="Imagen 1">
                <img src="../presentacion/imagenesManual/modificarCargo.png" alt="Imagen 2">
                <img src="../presentacion/imagenesManual/eliminar.png" alt="Imagen 3">
            </div>
            
            <button class="carousel-btn right-btn" onclick="moveSlide(1)">&#10095;</button>
        </div>

        <a href="../9.ManualUso/manualUso.jsp" class="back-button"><i class="fas fa-arrow-left"></i> Volver al Manual</a>
    </div>

<script>
    const slideContainer = document.querySelector('.carousel-slide');
    const slides = document.querySelectorAll('.carousel-slide img');
    let currentIndex = 0;

    function moveSlide(direction) {
        currentIndex += direction;

        if (currentIndex < 0) {
            currentIndex = slides.length - 1;
        } else if (currentIndex >= slides.length) {
            currentIndex = 0;
        }

        const slideWidth = slides[0].clientWidth;
        slideContainer.style.transform = 'translateX(' + (-slideWidth * currentIndex) + 'px)';
    }
</script>

</body>
</html>
