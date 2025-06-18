<%-- 
    Document   : verDocumentosContratacion
    Created on : 26/03/2025, 04:29:53 PM
    Author     : VALEN
--%>

<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Administrador"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    String identificacion = request.getParameter("identificacion");
    Persona persona = null;

    if (identificacion != null && !identificacion.isEmpty()) {
        persona = new Persona(identificacion);
    }%>


<!DOCTYPE html>
<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>

<div class="content">
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   
            <link rel="stylesheet" href="../presentacion/style-historiaLRetirado.css">
        </head>
        <body>
            <div class="container">
                <h1>HISTORIA LABORAL</h1>
                <div class="section">
                    <h2>DOCUMENTOS CONTRATACI�N</h2>
                    <input type="text" value="<%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() + " - " + persona.getIdentificacion() : ""%>" class="nombre" readonly>
                </div>
                <table class="documentos-tabla">
                    <thead>
                        <tr>
                            <th>DOCUMENTOS</th>
                            <th>ARCHIVO</th>

                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Contrato de trabajo</td>
                            <td>
                                <button class="ver-btn" 
                                        onclick="window.location.href = 'detalleHistoria.jsp?identificacion=<%= identificacion%>&tipo=CTotros'" 
                                        style="background-color: #2C6E49; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 4px;">
                                    VER
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>Tratamiento y autorizaci�n de datos personales y autorizaci�n de ex�menes y requisas</td>
                            <td>
                                <button class="ver-btn" 
                                        onclick="window.location.href = 'detalleHistoria.jsp?identificacion=<%= identificacion%>&tipo=TDotros'" 
                                        style="background-color: #2C6E49; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 4px;">
                                    VER
                                </button>
                            </td>
                        </tr>

                        <tr>
                            <td>Profesiograma</td>
                            <td>
                                <button class="ver-btn" 
                                        onclick="window.location.href = 'detalleHistoria.jsp?identificacion=<%= identificacion%>&tipo=PRotros'" 
                                        style="background-color: #2C6E49; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 4px;">
                                    VER
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>SAGRILAFT</td>
                            <td>
                                <button class="ver-btn" 
                                        onclick="window.location.href = 'detalleHistoria.jsp?identificacion=<%= identificacion%>&tipo=SGRILAFTotros'" 
                                        style="background-color: #2C6E49; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 4px;">
                                    VER
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>Inducci�n Gesti�n Humana e induccion al cargo</td>
                            <td>
                                <button class="ver-btn" 
                                        onclick="window.location.href = 'detalleHistoria.jsp?identificacion=<%= identificacion%>&tipo=SGHotros'" 
                                        style="background-color: #2C6E49; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 4px;">
                                    VER
                                </button>
                            </td>
                        </tr>
                    </tbody>

                </table>
                <div class="buttons">
                    <a href="javascript:history.back()" class="btn-volver">VOLVER</a>
                </div>
            </div>
        </body>
    </html>
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

            if (!uploadBtn || !deleteBtn || !viewBtn || !downloadBtn || !fileMessage || !fileInput)
                return;

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

    // PERMISOS

    document.addEventListener("DOMContentLoaded", function () {
        controlarPermisos(
    <%= administrador.getpEliminar()%>,
    <%= administrador.getpAgregar()%>,
    <%= administrador.getpLeer()%>,
    <%= administrador.getpDescargar()%>
        );
    });

</script>

