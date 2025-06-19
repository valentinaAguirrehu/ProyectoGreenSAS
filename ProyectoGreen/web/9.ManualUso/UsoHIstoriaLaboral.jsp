<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manual de Uso - Módulo de Historia Laboral</title>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #fff;
            color: #111;
            margin: 0;
            padding: 40px;
            line-height: 1.6;
        }

        h1, h2, h3, h4 {
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

        .small-image {
            max-width: 1000px;
            width: 100%;
            height: auto;
            border: 1px solid #ccc;
        }

        .document-image {
            max-width: 600px;
            width: 100%;
            height: auto;
            border: 1px solid #ccc;
            margin: 0 auto;
            display: block;
        }
    </style>
</head>
<body>

    <div class="section">
        <h2>Módulo de Historia Laboral</h2>

        <h3>Acceso al Módulo</h3>
        <p>
            El módulo de Historia Laboral está disponible para todos los colaboradores, ya sean <strong>activos</strong>, <strong>temporales</strong>, <strong>aprendices</strong> o <strong>retirados</strong>.
            En el menú lateral izquierdo, estos módulos se encuentran organizados dentro del apartado <strong>Colaboradores</strong>.
            Al hacer clic sobre este, se desplegarán las diferentes categorías de colaboradores para su selección.
        </p>

        <div class="image-container">
            <img class="small-image" src="../presentacion/imagenesManual/menuHistoriaLaboral.png" alt="Menú historia laboral">
        </div>

        <h3>Ingreso desde el apartado "Activos"</h3>
        <p>
            Al ingresar, por ejemplo, al submódulo de <strong>Activos</strong>, se mostrará en la parte derecha una lista de colaboradores junto con varios iconos que permiten diferentes acciones sobre cada registro.
        </p>
        <p>
            Cada colaborador tiene un ícono con una <strong>lupa</strong>, que representa la acción "Historia Laboral". 
            Al posicionar el puntero del mouse sobre este icono, se mostrará un texto emergente que confirma su función.
        </p>

        <div class="image-container">
            <img class="small-image" src="../presentacion/imagenesManual/IconoHistoriaLaboral.png" alt="Icono de historia laboral">
        </div>

        <h3>Visualización de la Historia Laboral</h3>
        <p>
            Al hacer clic en el icono de Historia Laboral, se abrirá una interfaz donde se precargarán automáticamente los <strong>datos personales</strong> más importantes del colaborador seleccionado.
        </p>
        <p>
            Además, se mostrarán todos los <strong>documentos asociados</strong> a la historia laboral de la persona.
        </p>

        <div class="image-container">
            <img class="document-image" src="../presentacion/imagenesManual/VerHistoriaLaboral.png" alt="Vista de historia laboral">
        </div>

        <p>
            Esta funcionalidad permite tener un registro completo y detallado de la trayectoria del colaborador dentro de la empresa.
        </p>

        <h3>Carga de Documentos en Historia Laboral</h3>

        <p>
            A continuación, se explicará paso a paso cómo cargar documentos dentro del módulo de Historia Laboral. Esta funcionalidad permite registrar archivos PDF asociados a diferentes eventos del historial del colaborador.
        </p>

        <h4>Paso 1: Acceder a un documento</h4>
        <p>
            Ingrese a cualquiera de los apartados disponibles en la sección de Historia Laboral (por ejemplo, "Proceso de Selección"). Una vez dentro, haga clic en el botón <strong>"Ver"</strong> correspondiente al documento deseado.
        </p>

        <div class="image-container">
            <img class="document-image" src="../presentacion/imagenesManual/procesoSeleccion.png" alt="Botón Ver documento historia laboral">
        </div>

        <h4>Paso 2: Ver subdocumentos</h4>
        <p>
            Al hacer clic en <strong>"Ver"</strong>, se abrirá una nueva interfaz que mostrará los subdocumentos relacionados al documento principal seleccionado. 
            Por ejemplo, al seleccionar "Proceso de Selección", se listarán sus subdocumentos. Cada uno tendrá también su propio botón <strong>"Ver"</strong> que lo llevará a su interfaz correspondiente.
        </p>

        <div class="image-container">
            <img class="document-image" src="../presentacion/imagenesManual/subMenu.jpg" alt="Vista de subdocumentos">
        </div>

        <h4>Paso 3: Cargar un archivo PDF</h4>
        <p>
            Dentro del subdocumento seleccionado, se abrirá una nueva vista en la que podrá cargar el archivo correspondiente. 
            Para ello, haga clic en el ícono <strong>"+"</strong>, el cual indica la acción de <strong>Agregar Documento</strong>.
        </p>

        <p>
            Es importante tener en cuenta lo siguiente:
        </p>

        <ul>
            <li>El documento a cargar debe estar en formato <strong>PDF</strong>.</li>
            <li>El <strong>nombre del archivo debe ser único</strong>. El sistema no permite cargar documentos que ya existan con el mismo nombre. Si esto sucede, se solicitará cambiar el nombre del archivo antes de continuar.</li>
        </ul>

        <div class="image-container">
            <img class="document-image" src="../presentacion/imagenesManual/agregarHistoriaLaboral.jpg alt="Agregar documento a historia laboral">
        </div>

        <h4>Paso 4: Agregar observación y guardar</h4>
        <p>
            Una vez seleccionado el archivo PDF, se podrá agregar una <strong>observación opcional</strong> que complemente la información del documento. Si no se desea agregar ninguna, este campo puede dejarse en blanco.
        </p>

        <p>
            Finalmente, haga clic en el botón <strong>"Guardar"</strong> para registrar el documento en el sistema.
        </p>

        <div class="image-container">
            <img class="document-image" src="../presentacion/imagenesManual/guardarDocumento.png" alt="Guardar documento con observación">
        </div>

        <a href="../9.ManualUso/manualUso.jsp" class="back-button"><i class="fas fa-arrow-left"></i> Volver al Manual</a>
    </div>

</body>
</html>
