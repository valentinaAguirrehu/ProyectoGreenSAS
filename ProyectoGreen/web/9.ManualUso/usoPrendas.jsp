<%-- 
    Document   : usoPrendas
    Created on : 18 jun 2025, 15:11:28
    Author     : Angie
--%>

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
                max-width: 800px;
                width: 90%;
                border: 1px solid #ccc;
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            p {
                text-align: justify;
                margin-bottom: 15px;
            }

            .highlight {
                color: #b30000;
                font-weight: bold;
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
        </style>
    </head>
    <body>

        <div class="section">
            <h2>Prendas de dotación - GREEN S.A.S.</h2>

            <p>
                Este módulo permite registrar y visualizar las <strong>prendas disponibles para dotación</strong>, clasificadas por su tipo. Cada prenda se asocia a una categoría general (por ejemplo, cabeza, oídos , pies) mediante un campo llamado <strong>"Tipo de prenda"</strong>, y luego se define su nombre específico.
            </p>

            <p class="highlight">
                <strong>Importante:</strong> Para poder realizar registros en el inventario de dotación, es requisito que las prendas estén previamente registradas en este módulo. Si una prenda no ha sido creada aquí, no estará disponible en los formularios de registro de inventario.
            </p>

            <p>
                Las prendas registradas se agrupan automáticamente según el tipo de dotación para facilitar su consulta. Además, desde esta interfaz es posible <strong>modificar o eliminar</strong> cada prenda mediante los botones disponibles en la tabla.
            </p>

            <div class="image-container">
                <img src="../presentacion/imagenesManual/Prenda.jpg" alt="Vista del inventario de prendas">
            </div>

            <h3>¿Cómo agregar una nueva prenda?</h3>

            <p>
                Para registrar una nueva prenda, haz clic en el <strong>ícono blanco de círculo con una cruz</strong> ubicado en la parte superior derecha de la tabla. A continuación, selecciona primero el tipo de prenda desde el menú desplegable. Luego, escribe el nombre específico de la prenda y guarda el registro. El sistema organizará automáticamente esta prenda dentro de su categoría correspondiente.
            </p>

            <div class="image-container">
                <img src="../presentacion/imagenesManual/PrendaFormulario.PNG" alt="Formulario para agregar prenda">
            </div>

            <h3>¿Qué acciones se pueden realizar?</h3>

            <ul>
                <li><strong>Modificar:</strong> Puedes actualizar el nombre de una prenda o cambiar su tipo de dotación en cualquier momento.</li>
                <li><strong>Eliminar:</strong> Solo es posible eliminar una prenda si <em>aún no ha sido registrada en el inventario de dotación</em>.</li>
            </ul>

            <p class="highlight">
                Importante: Si una prenda ya ha sido utilizada en registros de inventario, <u>no podrá ser eliminada</u> para garantizar la integridad de los datos históricos.
            </p>

            <a href="../9.ManualUso/dotacionMenu.jsp" class="back-button">← Volver</a>
        </div>

    </body>
</html>
