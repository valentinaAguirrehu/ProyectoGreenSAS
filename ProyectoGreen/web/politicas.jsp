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
            Políticas de privacidad y protección de datos
        </header>

        <div class="container">
            <h2>PROTECCIÓN DE DATOS</h2>
            <p>Dando cumplimiento a la Ley 1581 de 2012 y el Decreto 1377 de 2013, GREEN S.A.S. garantiza el adecuado tratamiento de sus datos personales y el respeto a sus derechos como titulares.</p>


            <div style="text-align: center; margin-top: 30px;">
                <button onclick="window.location.href = '0.Inicio/principal.jsp'" style="
                        background-color: #145a32;
                        color: white;
                        padding: 12px 24px;
                        border: none;
                        border-radius: 6px;
                        font-size: 16px;
                        cursor: pointer;
                        transition: background-color 0.3s;">
                   He leído y acepto la Política de Privacidad y Protección de Datos
                </button>
            </div>

            <footer>
                © 2025 GREEN S.A.S. - Todos los derechos reservados
            </footer>
    </body>
</html>
