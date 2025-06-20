<%-- 
    Document   : usoInvDotNueva
    Created on : 19 jun 2025, 22:55:00
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
            <h2>Inventario de dotación - GREEN S.A.S.</h2>
            
            <p>
                En esta sección podrás <strong>visualizar</strong> todas las existencias de dotación disponibles, agrupadas por su <em>Tipo de prenda</em> (Nariz/Boca, Parte superior, Parte inferior, etc.). 
                Si un tipo de prenda no aparece, por ejemplo <em>Cabeza</em>, significa que hasta el momento, <u>no se ha registrado ninguna prenda</u> de ese tipo en el inventario.
            </p>

            <p>
                Cada registro despliega detalles clave para la gestión:
            </p>
            <ul>
                <li><strong>Última fecha de ingreso:</strong> la fecha de ingreso más reciente para esa referencia.</li>
                <li><strong>Prenda:</strong> nombre comercial tal como fue creada en el módulo de <em>Prendas</em>.</li>
                <li><strong>Talla / Número:</strong> según corresponda a la prenda.</li>
                <li><strong>Cantidad:</strong> número total de unidades disponibles.</li>
                <li><strong>Unidad de negocio:</strong> unidad de negocio a la que pertenece la existencia.</li>
            </ul>

            <div class="image-container">
                <img src="../presentacion/imagenesManual/InvDotNueva_Vista.jpg" 
                     alt="Vista del inventario de dotación nueva">
            </div>

            <h3>Filtros y búsqueda</h3>
            <p>
                En la parte superior encontrarás un <strong>buscador rápido</strong> que filtra por nombre de la prenda, este filtro es general y busca en todos los tipos de prendas
                que haya disponible.
            </p>

            <h3 class="highlight">Agregar nuevas existencias</h3>
            <p>
                Para ingresar nuevas prendas al inventario, haz clic en el botón 
                <strong>"Agregar prendas"</strong> (ícono verde con un <em>+</em>) ubicado 
                en la parte superior derecha de la pantalla. Se abrirá el formulario 
                <em>"Agregar dotación nueva"</em>, donde se capturan los datos obligatorios:
            </p>

            <div class="image-container">
                <img src="../presentacion/imagenesManual/InvDotNueva_Formulario.jpg" 
                     alt="Formulario para agregar dotación nueva">
            </div>

            <ul>
                <li><strong>Fecha de ingreso:</strong> día en que se recibe la dotación.</li>
                <li><strong>Unidad de negocio:</strong> selecciona la sucursal a la que ingresará el stock.</li>
                <li>
                    <strong>Tabla de detalle:</strong> en cada fila debes completar:
                    <ul>
                        <li>Tipo de prenda</li>
                        <li>Prenda (menú desplegable de las prendas previamente registradas)</li>
                        <li>Tipo de medida (Talla o Número) y la medida específica</li>
                        <li>Cantidad existente que ingresa</li>
                    </ul>
                </li>
            </ul>

            <p>
                Con el botón <strong><em>+</em> dentro del círculo</strong> puedes añadir tantas filas como necesites para ingresar varias referencias en la misma operación. 
                Si te equivocas en una fila, utiliza el <em>ícono de papelera</em> para eliminarla antes de guardar.
            </p>

            <p class="highlight">
                Recuerda: si la prenda no existe en el catálogo de <em>Prendas</em>, primero debes crearla allí para que aparezca en la lista desplegable. 
            </p>

            <a href="../9.ManualUso/dotacionMenu.jsp" class="back-button">← Volver</a>
        </div>

    </body>
</html>
