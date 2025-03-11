<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Iterator, java.util.Map, java.util.HashMap" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.FileItem" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext" %>
<%@ page import="java.io.File" %>

<%
    String rutaArchivoGuardado = null;
    String nombreArchivoGuardado = null;
    boolean subioArchivo = false;

    String rutaArchivos = getServletContext().getRealPath("/") + "uploads/";
    File destino = new File(rutaArchivos);

    if (!destino.exists()) {
        destino.mkdirs();
    }

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (isMultipart) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));

        for (FileItem item : items) {
            if (!item.isFormField()) {
                nombreArchivoGuardado = new File(item.getName()).getName();
                if (!nombreArchivoGuardado.isEmpty()) {
                    File archivoGuardado = new File(destino, nombreArchivoGuardado);
                    item.write(archivoGuardado);
                    subioArchivo = true;
                    rutaArchivoGuardado = "uploads/" + nombreArchivoGuardado; // Ruta relativa
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historia laboral</title>
        <link rel="stylesheet" href="presentacion/historiaLaboral.css">
    </head>
    <body>
        <div class="container">
            <h1>HISTORIA LABORAL</h1>

            <div class="section">
                <input type="text" value="JOHANA LILIANA JIMÉN" class="nombre">
            </div>

            <div class="section">
                <h3>Datos laborales</h3>
                <div class="input-group">
                    <label>C.C.</label>
                    <input type="text" class="campo-pequeno">
                    <label>Centro de costo</label>
                    <input type="text" class="campo-mediano">
                    <label>Celular</label>
                    <input type="text" class="campo-pequeno">
                </div>
                <div class="input-group">
                    <label for="establecimiento">Establecimiento</label>
                    <input type="text" id="establecimiento" class="campo-pequeno">
                </div>
            </div>

            <div class="section">
                <h3>Datos personales</h3>

                <div class="input-group">
                    <label>Cédula ciudadanía</label>
                    <div class="icon-buttons">
                        <button class="ver-btn" data-file="<%= rutaArchivoGuardado%>" title="Ver Documento">
                            <img src="presentacion/iconos/ojo.png" alt="Ver">
                        </button>
                        <button class="descargar-btn" data-file="<%= rutaArchivoGuardado%>" title="Descargar Documento">
                            <img src="presentacion/iconos/descargar.png" alt="Descargar">
                        </button>
                        <button class="upload-btn" title="Subir Documento">
                            <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                        </button>
                        <input type="file" class="file-input" style="display: none;">
                    </div>


                    <label>Inducción SST</label>
                    <div class="icon-buttons">
                        <button class="ver-btn" data-file="<%= rutaArchivoGuardado%>" title="Ver Documento">
                            <img src="presentacion/iconos/ojo.png" alt="Ver">
                        </button>
                        <button class="descargar-btn" data-file="<%= rutaArchivoGuardado%>" title="Descargar Documento">
                            <img src="presentacion/iconos/descargar.png" alt="Descargar">
                        </button>
                        <button class="upload-btn" title="Subir Documento">
                            <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                        </button>
                        <input type="file" class="file-input" style="display: none;">
                    </div>

                </div>

                <div class="input-group">
                    <label>Documentos SAGRILAFT</label>
                    <div class="icon-buttons">
                        <button class="ver-btn" data-file="<%= rutaArchivoGuardado%>" title="Ver Documento">
                            <img src="presentacion/iconos/ojo.png" alt="Ver">
                        </button>
                        <button class="descargar-btn" data-file="<%= rutaArchivoGuardado%>" title="Descargar Documento">
                            <img src="presentacion/iconos/descargar.png" alt="Descargar">
                        </button>
                        <button class="upload-btn" title="Subir Documento">
                            <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                        </button>
                        <input type="file" class="file-input" style="display: none;">
                    </div>



                    <label>Inducción SGA</label>
                    <div class="icon-buttons">
                        <button class="ver-btn" data-file="<%= rutaArchivoGuardado%>" title="Ver Documento">
                            <img src="presentacion/iconos/ojo.png" alt="Ver">
                        </button>
                        <button class="descargar-btn" data-file="<%= rutaArchivoGuardado%>" title="Descargar Documento">
                            <img src="presentacion/iconos/descargar.png" alt="Descargar">
                        </button>
                        <button class="upload-btn" title="Subir Documento">
                            <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                        </button>
                        <input type="file" class="file-input" style="display: none;">
                    </div>

                </div>

                <div class="input-group">
                    <label>Otros documentos</label>
                    <div class="icon-buttons">
                        <button class="ver-btn" data-file="<%= rutaArchivoGuardado%>" title="Ver Documento">
                            <img src="presentacion/iconos/ojo.png" alt="Ver">
                        </button>
                        <button class="descargar-btn" data-file="<%= rutaArchivoGuardado%>" title="Descargar Documento">
                            <img src="presentacion/iconos/descargar.png" alt="Descargar">
                        </button>
                        <button class="upload-btn" title="Subir Documento">
                            <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                        </button>
                        <input type="file" class="file-input" style="display: none;">
                    </div>

                </div>
            </div>

            <div class="buttons">
                <a href="principal.jsp" class="btn-volver">VOLVER</a>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Seleccionar todos los botones de subida
                document.querySelectorAll('.upload-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        let fileInput = this.nextElementSibling;
                        fileInput.click();
                    });
                });

                // Escuchar cambios en el input file
                document.querySelectorAll('.file-input').forEach(input => {
                    input.addEventListener('change', function () {
                        if (this.files.length > 0) {
                            let file = this.files[0];
                            let formData = new FormData();
                            formData.append("archivo", file);

                            // Enviar el archivo mediante AJAX
                            fetch("subirArchivo.jsp", {
                                method: "POST",
                                body: formData
                            })
                                    .then(response => response.text())
                                    .then(data => {
                                        alert("Archivo subido con éxito: " + file.name);
                                        let parent = this.closest(".icon-buttons");
                                        parent.querySelector(".ver-btn").setAttribute("data-file", data);
                                        parent.querySelector(".descargar-btn").setAttribute("data-file", data);
                                    })
                                    .catch(error => console.error("Error al subir archivo", error));
                        }
                    });
                });

                // Ver documento
                document.querySelectorAll('.ver-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        let file = this.getAttribute("data-file");
                        if (file) {
                            window.open(file, "_blank");
                        } else {
                            alert("No hay archivo para ver");
                        }
                    });
                });

                // Descargar documento
                document.querySelectorAll('.descargar-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        let file = this.getAttribute("data-file");
                        if (file) {
                            let a = document.createElement("a");
                            a.href = file;
                            a.download = file.split("/").pop();
                            document.body.appendChild(a);
                            a.click();
                            document.body.removeChild(a);
                        } else {
                            alert("No hay archivo para descargar");
                        }
                    });
                });
            });

        </script>
    </body>
</html>