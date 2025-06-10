<%-- 
    Document   : verDocumentosSSTSGA
    Created on : 26/03/2025, 04:37:17 PM
    Author     : VALEN
--%>

<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
                    <h2>DOCUMENTOS SG-SST Y SGA</h2>
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
    <!-- SG‑SST y SGA -->
    <tr>
      <td>Inducción y reinducción SG-SST</td>
      <td>
        <button class="ver-btn"
                onclick="window.location.href='detalleHistoria.jsp?identificacion=<%=identificacion%>&tipo=IRSGSSTotros'"
                style="background-color:#2C6E49;color:white;border:none;padding:5px 10px;cursor:pointer;border-radius:4px;">
          VER
        </button>
      </td>
    </tr>
    <tr>
      <td>Inducción y reinducción SGA</td>
      <td>
        <button class="ver-btn"
                onclick="window.location.href='detalleHistoria.jsp?identificacion=<%=identificacion%>&tipo=IRSGAotros'"
                style="background-color:#2C6E49;color:white;border:none;padding:5px 10px;cursor:pointer;border-radius:4px;">
          VER
        </button>
      </td>
    </tr>
    <!-- EMO -->
    <tr>
      <td>EMO ingreso</td>
      <td>
        <button class="ver-btn"
                onclick="window.location.href='detalleHistoria.jsp?identificacion=<%=identificacion%>&tipo=EMOIotros'"
                style="background-color:#2C6E49;color:white;border:none;padding:5px 10px;cursor:pointer;border-radius:4px;">
          VER
        </button>
      </td>
    </tr>
    <tr>
      <td>EMO seguimiento a recomendaciones</td>
      <td>
        <button class="ver-btn"
                onclick="window.location.href='detalleHistoria.jsp?identificacion=<%=identificacion%>&tipo=EMOSRotros'"
                style="background-color:#2C6E49;color:white;border:none;padding:5px 10px;cursor:pointer;border-radius:4px;">
          VER
        </button>
      </td>
    </tr>
    <tr>
      <td>EMO post-incapacidad</td>
      <td>
        <button class="ver-btn"
                onclick="window.location.href='detalleHistoria.jsp?identificacion=<%=identificacion%>&tipo=EMOINotros'"
                style="background-color:#2C6E49;color:white;border:none;padding:5px 10px;cursor:pointer;border-radius:4px;">
          VER
        </button>
      </td>
    </tr>
    <tr>
      <td>Encuenta condiciones de salud</td>
      <td>
        <button class="ver-btn"
                onclick="window.location.href='detalleHistoria.jsp?identificacion=<%=identificacion%>&tipo=EncuentaSalud'"
                style="background-color:#2C6E49;color:white;border:none;padding:5px 10px;cursor:pointer;border-radius:4px;">
          VER
        </button>
      </td>
    </tr>
    <tr>
      <td>Certificados y permisos</td>
      <td>
        <button class="ver-btn"
                onclick="window.location.href='detalleHistoria.jsp?identificacion=<%=identificacion%>&tipo=CPotros'"
                style="background-color:#2C6E49;color:white;border:none;padding:5px 10px;cursor:pointer;border-radius:4px;">
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
                    alert("No hay ningún archivo cargado");
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
                    alert("No hay ningún archivo cargado");
                }
            });

            // Eliminar Archivo con Confirmación
            deleteBtn.addEventListener("click", function () {
                if (fileData) {
                    let confirmacion = confirm("¿Estás seguro de eliminar este archivo?");
                    if (confirmacion) {
                        fileData = null;
                        fileMessage.style.color = "red";
                        fileMessage.textContent = "NO HAY NINGÚN ARCHIVO CARGADO";
                        fileInput.value = ""; // Limpiar input
                    }
                } else {
                    alert("No hay ningún archivo para eliminar");
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

