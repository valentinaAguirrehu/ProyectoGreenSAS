<%-- 
    Document   : usoInvDotUsada
    Created on : 18 jun 2025, 16:00:01
    Author     : Angie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
<<<<<<< HEAD
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
                color: #094421;
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
                width: 95%;
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
                background-color: #094421;
                color: #fff;
                text-decoration: none;
                border-radius: 6px;
                margin-top: 40px;
            }

            .back-button:hover {
                background-color: #0c5a2a;
            }
        </style>
    </head>
    <body>

        <div class="section">
            <h2>Inventario de dotación usada - GREEN S.A.S.</h2>

            <p>
                Este módulo te permite gestionar todas las existencias de prendas que ya han sido utilizadas pero que se encuentran disponibles para redistribución.
                Las prendas están <strong>agrupadas por tipo de prenda</strong> para facilitar su consulta (por ejemplo: Parte superior, Parte inferior, Nariz/Boca, Pies, etc.).
            </p>

            <p>
                Cada prenda en el inventario tiene los siguientes datos:
            </p>
            <ul>
                <li><strong>Última fecha de ingreso:</strong> la fecha de ingreso más reciente para esa referencia.</li>
                <li><strong>Prenda:</strong> nombre comercial tal como fue creada en el módulo de <em>Prendas</em>.</li>
                <li><strong>Talla o número:</strong> según corresponda a la prenda.</li>
                <li><strong>Cantidad:</strong> número total de unidades disponibles.</li>
                <li><strong>Unidad de negocio:</strong> unidad de negocio a la que pertenece la existencia.</li>
            </ul>

            <div class="image-container">
                <img src="../presentacion/imagenesManual/InvDotUsada_Vista.jpg" 
                     alt="Vista del inventario de dotación usada">
            </div>

            <h3>Filtros y búsqueda</h3>
            <p>
                En la parte superior encontrarás un <strong>buscador rápido</strong> que filtra por nombre de la prenda, este filtro es general y busca en todos los tipos de prendas
                que haya disponible.
            </p>

            <h3 class="highlight">¿Cómo se ingresa una prenda usada al inventario?</h3>
            <p>
                Hay dos formas de ingreso al inventario de dotación usada:
            </p>
            <ul>
                <li>
                    <strong>1. Manualmente:</strong> 
                    Haciendo clic en el botón <strong>“Agregar prendas”</strong> (ícono verde con un <em>+</em>). 
                    Esto abre un formulario donde puedes ingresar varias prendas a la vez, indicando el tipo, la prenda, su talla o número y la cantidad existente.
                </li>
                <li>
                    <strong>2. Automáticamente:</strong> 
                    Cuando se registra una <strong>devolución de dotación</strong> desde el formulario correspondiente, 
                    <span class="highlight">las prendas devueltas se suman automáticamente al inventario de dotación usada</span> 
                    con la fecha, cantidad, talla y unidad de negocio registradas en la devolución.
                </li>
            </ul>

            <h3>Formulario para agregar dotación usada</h3>
            <p>
                Este formulario permite ingresar varias prendas usadas al inventario de forma simultánea, 
                para ello se deben completar los siguientes campos por cada fila:
            </p>
            <ul>
                <li>Tipo de prenda</li>
                <li>Nombre de la prenda</li>
                <li>Tipo de medida (Talla o Número)</li>
                <li>Valor de la medida (por ejemplo, M o 30)</li>
                <li>Cantidad existente</li>
            </ul>

            <p>
                Puedes hacer clic en el botón <strong>“+”</strong> para agregar más filas según sea necesario. 
                Si necesitas eliminar una fila, usa el <em>ícono de papelera</em>.
            </p>

            <div class="image-container">
                <img src="../presentacion/imagenesManual/InvDotUsada_Formulario.jpg" 
                     alt="Formulario para agregar dotación usada">
            </div>

            <p class="highlight">
                Nota: asegúrate de que las prendas ya existan en el catálogo de prendas para que estén disponibles en las listas desplegables del formulario.
            </p>

            <a href="../9.ManualUso/dotacionMenu.jsp" class="back-button">← Volver</a>
        </div>

    </body>
</html>

=======
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
>>>>>>> fe11330657a673041a6ace477a331c77eb9f968e
