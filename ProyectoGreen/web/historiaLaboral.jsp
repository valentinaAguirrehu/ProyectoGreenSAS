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
        <title>Historia Laboral</title>
        <link rel="stylesheet" href="presentacion/style-historiaLGreen.css">
    </head>
    <body>
        <div class="container">
            <h1>HISTORIA LABORAL TEMPORALES </h1>

            <div class="section">
                <input type="text" value="JOHANA LILIANA JIMÉN" class="nombre">
            </div>
            <!-- Datos Laborales -->
            <div class="section">
                <h3 class="titulo-seccion">Datos Laborales</h3>
                <div class="input-group">
                    <div class="campo">
                        <label>C.C.</label>
                        <input type="text" class="campo-pequeno">
                    </div>
                    <div class="campo">
                        <label>Centro de Costo</label>
                        <input type="text" class="campo-mediano">
                    </div>

                    <div class="campo">
                        <label>Establecimiento</label>
                        <input type="text" class="campo-pequeno">
                    </div>
                    <div class="campo">
                        <label>Celular</label>
                        <input type="text" class="campo-pequeno">
                    </div>
                </div>
            </div>


            <div class="section">
                <h3 class="titulo-seccion">Datos Personales</h3>
                <div class="data-grid">

                    <!-- Cédula Ciudadanía -->
                    <div class="data-item">
                        <span>Cédula Ciudadanía</span>
                        <div class="icon-buttons">
                            <button class="ver-btn" data-file="<%= rutaArchivoGuardado%>">
                                <img src="presentacion/iconos/ojo.png" alt="Ver">
                            </button>
                            <button class="descargar-btn" data-file="<%= rutaArchivoGuardado%>">
                                <img src="presentacion/iconos/descargar.png" alt="Descargar">
                            </button>
                            <button class="eliminar-btn">
                                <img src="presentacion/iconos/eliminar.png" alt="Eliminar">
                            </button>

                            <button class="upload-btn">
                                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                            </button>
                            <input type="file" class="file-input" accept=".pdf,.jpg,.png" hidden>
                        </div>
                    </div>

                    <!-- Documentos SAGRILAFT -->
                    <div class="data-item">
                        <span>Documentos SAGRILAFT</span>
                        <div class="icon-buttons">
                            <button class="ver-btn">
                                <img src="presentacion/iconos/ojo.png" alt="Ver">
                            </button>
                            <button class="descargar-btn">
                                <img src="presentacion/iconos/descargar.png" alt="Descargar">
                            </button>
                            <button class="eliminar-btn">
                                <img src="presentacion/iconos/eliminar.png" alt="Eliminar">
                            </button>

                            <button class="upload-btn">
                                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                            </button>
                            <input type="file" class="file-input" accept=".pdf,.jpg,.png" hidden>
                        </div>
                    </div>

                    <!-- Otros Documentos -->
                    <div class="data-item">
                        <span>Otros Documentos</span>
                        <div class="icon-buttons">
                            <button class="ver-btn">
                                <img src="presentacion/iconos/ojo.png" alt="Ver">
                            </button>
                            <button class="descargar-btn">
                                <img src="presentacion/iconos/descargar.png" alt="Descargar">
                            </button>
                            <button class="eliminar-btn">
                                <img src="presentacion/iconos/eliminar.png" alt="Eliminar">
                            </button>

                            <button class="upload-btn">
                                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                            </button>
                            <input type="file" class="file-input" accept=".pdf,.jpg,.png" hidden>
                        </div>
                    </div>

                    <!-- Inducción SST -->
                    <div class="data-item">
                        <span>Inducción SST</span>
                        <div class="icon-buttons">
                            <button class="ver-btn">
                                <img src="presentacion/iconos/ojo.png" alt="Ver">
                            </button>
                            <button class="descargar-btn">
                                <img src="presentacion/iconos/descargar.png" alt="Descargar">
                            </button>
                            <button class="eliminar-btn">
                                <img src="presentacion/iconos/eliminar.png" alt="Eliminar">
                            </button>

                            <button class="upload-btn">
                                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                            </button>
                            <input type="file" class="file-input" accept=".pdf,.jpg,.png" hidden>
                        </div>
                    </div>

                    <!-- Inducción SGA -->
                    <div class="data-item">
                        <span>Inducción SGA</span>
                        <div class="icon-buttons">
                            <button class="ver-btn">
                                <img src="presentacion/iconos/ojo.png" alt="Ver">
                            </button>
                            <button class="descargar-btn">
                                <img src="presentacion/iconos/descargar.png" alt="Descargar">
                            </button>
                            <button class="eliminar-btn">
                                <img src="presentacion/iconos/eliminar.png" alt="Eliminar">
                            </button>

                            <button class="upload-btn">
                                <img src="presentacion/iconos/agregarDocumento.png" alt="Subir">
                            </button>
                            <input type="file" class="file-input" accept=".pdf,.jpg,.png" hidden>
                        </div>
                    </div>

                </div>
            </div>

            <div class="buttons">
                <a href="principal.jsp" class="btn-volver">VOLVER</a>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll('.upload-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        let fileInput = this.nextElementSibling;
                        fileInput.click();
                    });
                });

                document.querySelectorAll('.file-input').forEach(input => {
                    input.addEventListener('change', function () {
                        if (this.files.length > 0) {
                            let file = this.files[0];

                            // Validar que sea un archivo PDF, JPG o PNG
                            let allowedExtensions = /(\.pdf|\.jpg|\.png)$/i;
                            if (!allowedExtensions.test(file.name)) {
                                alert("Solo se permiten archivos PDF, JPG o PNG.");
                                return;
                            }

                            let formData = new FormData();
                            formData.append("archivo", file);

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
                                        parent.querySelector(".eliminar-btn").setAttribute("data-file", data);
                                    })
                                    .catch(error => console.error("Error al subir archivo", error));
                        }
                    });
                });

                function verificarArchivo(btn) {
                    let file = btn.getAttribute("data-file");
                    if (!file || file === "null") {
                        alert("Debe subir un archivo antes de realizar esta acción.");
                        return false;
                    }
                    return true;
                }

                document.querySelectorAll('.ver-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        if (verificarArchivo(this)) {
                            window.open(this.getAttribute("data-file"), "_blank");
                        }
                    });
                });

                document.querySelectorAll('.descargar-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        if (verificarArchivo(this)) {
                            let link = document.createElement("a");
                            link.href = this.getAttribute("data-file");
                            link.download = this.getAttribute("data-file").split('/').pop();
                            document.body.appendChild(link);
                            link.click();
                            document.body.removeChild(link);
                        }
                    });
                });

                document.querySelectorAll('.eliminar-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        if (verificarArchivo(this)) {
                            if (confirm("¿Está seguro de eliminar este archivo?")) {
                                alert("Archivo eliminado correctamente.");
                                this.setAttribute("data-file", "");
                            }
                        }
                    });
                });
            });
        </script>

    </body>
</html>