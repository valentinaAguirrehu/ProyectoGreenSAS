<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historia Laboral Retirados</title>
        <link rel="stylesheet" href="presentacion/style-historiaLRetirado.css">
    </head>
    <body>
        <div class="container">
            <h1>HISTORIA LABORAL RETIRADOS</h1>
            <div class="section">
                <h2>DOCUMENTOS DE RETIRADOS</h2>
                <div class="buttons">
                    <a href="principal.jsp" class="btn-volver">VOLVER</a>
                </div>
                <input type="text" value="ANGE FLORENCIA JOOJA" class="nombre">
            </div>
        <table class="documentos-tabla">
    <thead>
        <tr>
            <th>DOCUMENTOS</th>
            <th>ARCHIVO</th>
            <th>OTRO</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>HOJA DE VIDA</td>
            <td class="archivo">
                <span class="estado" style="color:red; font-size:12px;">NO HAY NING�N ARCHIVO CARGADO</span>
            </td>
            <td>
                <img src="presentacion/iconos/ojo.png" alt="Ver" class="ver">
                <img src="presentacion/iconos/descargar.png" alt="Descargar" class="descargar">
                <img src="presentacion/iconos/eliminar.png" alt="Eliminar" class="eliminar">
                <input type="file" class="input-file" accept=".pdf,.png,.jpg" style="display: none;">
                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir" class="subir">
            </td>
        </tr>
        <tr>
            <td>DOCUMENTOS CONTRATACI�N</td>
            <td class="archivo">
                <span class="estado" style="color:red; font-size:12px;">NO HAY NING�N ARCHIVO CARGADO</span>
            </td>
            <td>
                <img src="presentacion/iconos/ojo.png" alt="Ver" class="ver">
                <img src="presentacion/iconos/descargar.png" alt="Descargar" class="descargar">
                <img src="presentacion/iconos/eliminar.png" alt="Eliminar" class="eliminar">
                <input type="file" class="input-file" accept=".pdf,.png,.jpg" style="display: none;">
                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir" class="subir">
            </td>
        </tr>
        <tr>
            <td>AFILIACIONES</td>
            <td class="archivo">
                <span class="estado" style="color:red; font-size:12px;">NO HAY NING�N ARCHIVO CARGADO</span>
            </td>
            <td>
                <img src="presentacion/iconos/ojo.png" alt="Ver" class="ver">
                <img src="presentacion/iconos/descargar.png" alt="Descargar" class="descargar">
                <img src="presentacion/iconos/eliminar.png" alt="Eliminar" class="eliminar">
                <input type="file" class="input-file" accept=".pdf,.png,.jpg" style="display: none;">
                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir" class="subir">
            </td>
        </tr>
        <tr>
            <td>DOCUMENTOS DURANTE LA CONTRATACI�N</td>
            <td class="archivo">
                <span class="estado" style="color:red; font-size:12px;">NO HAY NING�N ARCHIVO CARGADO</span>
            </td>
            <td>
                <img src="presentacion/iconos/ojo.png" alt="Ver" class="ver">
                <img src="presentacion/iconos/descargar.png" alt="Descargar" class="descargar">
                <img src="presentacion/iconos/eliminar.png" alt="Eliminar" class="eliminar">
                <input type="file" class="input-file" accept=".pdf,.png,.jpg" style="display: none;">
                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir" class="subir">
            </td>
        </tr>
        <tr>
            <td>AUSENTISMOS</td>
            <td class="archivo">
                <span class="estado" style="color:red; font-size:12px;">NO HAY NING�N ARCHIVO CARGADO</span>
            </td>
            <td>
                <img src="presentacion/iconos/ojo.png" alt="Ver" class="ver">
                <img src="presentacion/iconos/descargar.png" alt="Descargar" class="descargar">
                <img src="presentacion/iconos/eliminar.png" alt="Eliminar" class="eliminar">
                <input type="file" class="input-file" accept=".pdf,.png,.jpg" style="display: none;">
                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir" class="subir">
            </td>
        </tr>
        <tr>
            <td>DOCUMENTOS AL FINALIZAR LA CONTRATACI�N</td>
            <td class="archivo">
                <span class="estado" style="color:red; font-size:12px;">NO HAY NING�N ARCHIVO CARGADO</span>
            </td>
            <td>
                <img src="presentacion/iconos/ojo.png" alt="Ver" class="ver">
                <img src="presentacion/iconos/descargar.png" alt="Descargar" class="descargar">
                <img src="presentacion/iconos/eliminar.png" alt="Eliminar" class="eliminar">
                <input type="file" class="input-file" accept=".pdf,.png,.jpg" style="display: none;">
                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir" class="subir">
            </td>
        </tr>
        <tr>
            <td>SST-SGA</td>
            <td class="archivo">
                <span class="estado" style="color:red; font-size:12px;">NO HAY NING�N ARCHIVO CARGADO</span>
            </td>
            <td>
                <img src="presentacion/iconos/ojo.png" alt="Ver" class="ver">
                <img src="presentacion/iconos/descargar.png" alt="Descargar" class="descargar">
                <img src="presentacion/iconos/eliminar.png" alt="Eliminar" class="eliminar">
                <input type="file" class="input-file" accept=".pdf,.png,.jpg" style="display: none;">
                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir" class="subir">
            </td>
        </tr>
    </tbody>
</table>

        </div>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll("tr").forEach(row => {
            let uploadBtn = row.querySelector(".subir");   // Subir archivo
            let deleteBtn = row.querySelector(".eliminar"); // Eliminar archivo
            let viewBtn = row.querySelector(".ver");       // Ver archivo
            let downloadBtn = row.querySelector(".descargar"); // Descargar archivo
            let fileMessage = row.querySelector(".estado"); // Mensaje de estado
            let fileInput = row.querySelector(".input-file"); // Input de archivo
            let fileData = null;

            if (!uploadBtn || !deleteBtn || !viewBtn || !downloadBtn || !fileMessage || !fileInput) return;

            // Subir Archivo
            uploadBtn.addEventListener("click", function () {
                fileInput.click();
            });

            fileInput.addEventListener("change", function () {
                if (fileInput.files.length > 0) {
                    fileData = fileInput.files[0];
                    fileMessage.style.color = "green";
                    fileMessage.textContent = "ARCHIVO CARGADO: " + fileData.name;
                }
            });

            // Ver Archivo
            viewBtn.addEventListener("click", function () {
                if (fileData) {
                    let fileURL = URL.createObjectURL(fileData);
                    window.open(fileURL, "_blank");
                } else {
                    alert("No hay ning�n archivo cargado");
                }
            });

            // Descargar Archivo
            downloadBtn.addEventListener("click", function () {
                if (fileData) {
                    let a = document.createElement("a");
                    a.href = URL.createObjectURL(fileData);
                    a.download = fileData.name;
                    document.body.appendChild(a);
                    a.click();
                    document.body.removeChild(a);
                } else {
                    alert("No hay ning�n archivo cargado");
                }
            });

                // Eliminar Archivo con Confirmaci�n
                deleteBtn.addEventListener("click", function () {
                    if (fileData) {
                        let confirmacion = confirm("�Est�s seguro de eliminar este archivo?");
                        if (confirmacion) {
                            fileData = null;
                            fileMessage.style.color = "red";
                            fileMessage.textContent = "NO HAY NING�N ARCHIVO CARGADO";
                            fileInput.value = ""; // Limpiar input
                        }
                    } else {
                        alert("No hay ning�n archivo para eliminar");
                    } 
            });
        });
    });
</script>


    </body>
</html>
