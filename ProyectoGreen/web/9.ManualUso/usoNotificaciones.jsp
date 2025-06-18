<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manual de Uso - Módulo de Notificaciones</title>

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

        p {
            text-align: justify;
            margin-bottom: 15px;
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

        .carousel {
            position: relative;
            max-width: 600px;
            margin: 0 auto;
            overflow: hidden;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .carousel-images {
            display: flex;
            transition: transform 0.4s ease-in-out;
            width: 100%;
        }

        .carousel-images img {
            width: 100%;
            flex-shrink: 0;
            border: 1px solid #ccc;
        }

        .carousel-button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0,0,0,0.5);
            color: white;
            border: none;
            font-size: 24px;
            padding: 8px 16px;
            cursor: pointer;
            z-index: 1;
        }

        .carousel-button.left {
            left: 10px;
        }

        .carousel-button.right {
            right: 10px;
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
    </style>
</head>
<body>

    <div class="section">
        <h2>Módulo de Notificaciones</h2>

        <h3>Interfaz Principal</h3>
        <p>
            Al ingresar al módulo de notificaciones, la plataforma evaluará si existen contratos próximos a vencer en los próximos 30 días.
        </p>

        <ul>
            <li>
                Si <strong>no hay contratos por vencer</strong> en ese periodo, se mostrará un mensaje informativo que indica que no existen contratos próximos a vencer.
            </li>
            <li>
                Si <strong>hay contratos por vencer</strong>, aparecerá un listado con las personas cuyos contratos están próximos a vencer dentro de los próximos 30 días.
            </li>
        </ul>

        <p>
            En la parte derecha de esta interfaz, se encuentra un <strong>botón verde</strong> con la etiqueta <strong>“Enviar correos”</strong>. 
            Al hacer clic en este botón, se enviarán correos electrónicos tanto a los usuarios del sistema como a los colaboradores, notificando que los contratos de las personas listadas están próximos a finalizar.
        </p>

        <div class="image-container">
            <img src="../presentacion/imagenesManual/contratos.png" alt="Contratos próximos a vencer">
        </div>

        <h3>Historial de Correos Enviados</h3>

        <p>
            Después de enviar los correos, el sistema redirigirá automáticamente al <strong>historial de correos enviados</strong>.  
            Allí podrá observar a qué usuarios se les envió la notificación.
        </p>

       <p> En la parte superior del historial encontrarás un botón rojo etiquetado <strong>“Eliminar”</strong>, que te permite eliminar registros de envíos anteriores. Este botón solo estará activo si han pasado más de 30 días desde la primera fecha de envío del registro, lo cual garantiza que no se eliminen datos recientes. </p>

        <!-- Carrusel de imágenes -->
        <div class="carousel">
            <button class="carousel-button left" onclick="moverCarrusel(-1)">&#10094;</button>
            <div class="carousel-images" id="carrusel">
                <img src="../presentacion/imagenesManual/historialVista.png" alt="Historial de correos - imagen 1">
                <img src="../presentacion/imagenesManual/historialEliminar.png" alt="Historial de correos - imagen 2">
                <img src="../presentacion/imagenesManual/borrarcorreos.PNG" alt="Historial de correos - imagen 3">
            </div>
            <button class="carousel-button right" onclick="moverCarrusel(1)">&#10095;</button>
        </div>

        <a href="../9.ManualUso/manualUso.jsp" class="back-button"><i class="fas fa-arrow-left"></i> Volver al Manual</a>
    </div>

    <script>
        let indice = 0;

        function moverCarrusel(direccion) {
            const carrusel = document.getElementById('carrusel');
            const total = carrusel.children.length;

            indice += direccion;
            if (indice < 0) indice = total - 1;
            if (indice >= total) indice = 0;

            const ancho = carrusel.children[0].clientWidth;
            carrusel.style.transform = 'translateX(' + (-ancho * indice) + 'px)';
        }
    </script>

</body>
</html>
