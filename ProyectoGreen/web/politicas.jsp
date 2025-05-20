<%--  
    Document   : politicas
    Created on : 7/05/2025, 05:24:10 PM
    Author     : Valentina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Políticas de Privacidad</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            header {
                background-color: #145a32;
                color: white;
                padding: 20px;
                text-align: center;
                font-size: 24px;
                font-weight: bold;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .container {
                max-width: 900px;
                margin: 40px auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                color: #145a32;
                border-bottom: 2px solid #ccc;
                padding-bottom: 5px;
                margin-top: 30px;
            }

            p {
                line-height: 1.6;
                margin: 10px 0;
                color: #333;
            }

            ul {
                margin-left: 20px;
                color: #333;
            }

            footer {
                background-color: #145a32;
                color: white;
                text-align: center;
                padding: 15px;
                margin-top: 50px;
            }
        </style>
    </head>
    <body>
        <header>
            Políticas de Privacidad y Protección de Datos
        </header>

        <div class="container">
            <h2>1. Responsable del Tratamiento</h2>
            <p>GREEN SAS, con domicilio en Pasto, Colombia, es responsable del tratamiento de los datos personales gestionados a través del sistema de Gestión Humana. Contacto: [correo@greensas.com]</p>

            <h2>2. Normativa Aplicable</h2>
            <p>Esta política se rige por la Ley 1581 de 2012, Decreto 1377 de 2013, y otras normas colombianas sobre protección de datos personales.</p>

            <h2>3. Finalidades del Tratamiento</h2>
            <p>Los datos serán utilizados para gestión laboral, control de dotaciones, afiliaciones, historial de empleados, y cumplimiento de deberes legales, entre otros fines autorizados.</p>

            <h2>4. Datos Tratados</h2>
            <p>Se gestionarán datos como: nombre, identificación, dirección, teléfono, EPS, fondo de pensiones, información familiar, licencias, cuenta bancaria, y datos de dotaciones.</p>

            <h2>5. Derechos de los Titulares</h2>
            <ul>
                <li>Conocer, actualizar y rectificar sus datos</li>
                <li>Solicitar prueba de autorización</li>
                <li>Ser informado del uso de sus datos</li>
                <li>Revocar la autorización cuando sea legalmente posible</li>
                <li>Acceder gratuitamente a sus datos</li>
            </ul>

            <h2>6. Tratamiento de Datos Sensibles</h2>
            <p>Se realizará bajo criterios de legalidad, proporcionalidad y necesidad. Se requerirá autorización expresa para tratar datos sensibles, como información de salud.</p>

            <h2>7. Medidas de Seguridad</h2>
            <ul>
                <li>Control de accesos (RBAC)</li>
                <li>Cifrado de contraseñas (MD5)</li>
                <li>Auditoría de acciones</li>
                <li>Copias de seguridad automáticas</li>
                <li>Eliminación segura de datos</li>
            </ul>

            <h2>8. Transferencia de Datos</h2>
            <p>No se compartirán datos con terceros sin autorización, salvo por requerimiento legal o judicial.</p>

            <h2>9. Vigencia de la Política</h2>
            <p>Esta política rige desde su publicación. Puede ser modificada en cualquier momento por requerimientos legales o técnicos.</p>

            <h2>10. Autorización del Titular</h2>
            <p>Los colaboradores deben firmar un consentimiento informado, el cual se almacenará digitalmente en su perfil laboral.</p>
        </div>
<div style="text-align: center; margin-top: 30px;">
    <button onclick="window.location.href='0.Inicio/principal.jsp'" style="
        background-color: #145a32;
        color: white;
        padding: 12px 24px;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;">
        ¡Está claro!
    </button>
</div>

        <footer>
            © 2025 GREEN SAS - Todos los derechos reservados
        </footer>
    </body>
</html>
