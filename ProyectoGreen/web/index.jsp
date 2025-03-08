<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GREEN SAS - Iniciar Sesión</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            display: flex;
            height: 100vh;
            background: linear-gradient(to right, #145a32, #1c7430);
            justify-content: center;
            align-items: center;
        }

        .login-container {
            display: flex;
            width: 800px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            border: 2px solid #fff;
        }

        .left-section {
            width: 50%;
            background: #145a32;
            color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px;
            text-align: center;
        }

        .left-section h2 {
            margin-bottom: 10px;
        }

        .left-section p {
            font-size: 24px;
            font-weight: bold;
            color: white;
        }

        .right-section {
            width: 50%;
            padding: 40px;
            background: white; /* Fondo blanco */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        h2 {
            margin-bottom: 20px;
            text-align: center;
            color: #145a32;
        }

        .right-section h2 {
            color: green;
        }

        .input-box {
            margin-bottom: 15px;
            width: 100%;
            text-align: center; /* Centra el texto de los labels */
        }

        .input-box label {
            font-weight: bold;
            
            margin-bottom: 5px;
            color: #145a32;
            text-align: center; /* Centra el texto */
        }

        .icon-input {
            display: flex;
            align-items: center;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 5px;
            background: rgba(255, 255, 255, 0.5);
            width: 100%;
        }

        .icon-input input {
            flex: 1;
            border: none;
            outline: none;
            padding: 10px;
            font-size: 16px;
            background: transparent;
        }

        .icon-input img {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }

        input:focus {
            border: 2px solid #388e3c;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #388e3c;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #2e7d32;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <div class="left-section">
            
            <p>BIENVENIDO</p>
            <p>A</p>
            <p>GREEN SAS</p>
        </div>

        <div class="right-section">
          
            <h2>GESTION HUMANA</h2>
            <form action="principal.jsp" method="POST">
                <div class="input-box">
                    <label for="usuario"></label>
                    <div class="icon-input">
                        <input type="text" name="identificacion" id="usuario" placeholder=" Identificación">
                        <img src="presentacion/imagenes/user.png" alt="usuario" class="icon">
                    </div>
                </div>
                <div class="input-box">
                    <label for="clave"></label>
                    <div class="icon-input">
                        <input type="password" name="password" id="clave"  placeholder="Contraseña">
                        <img src="presentacion/imagenes/clave.png" alt="clave" class="icon">
                    </div>
                </div>
              
                
                <a href="principal.jsp">
                <button type="submit" id="boton">Iniciar Sesion</button></a>
            </form>
        </div>
    </div>

</body>
</html>
