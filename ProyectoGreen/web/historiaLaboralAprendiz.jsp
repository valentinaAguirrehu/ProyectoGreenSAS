<%@page import="clases.Persona"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Iterator, java.util.Map, java.util.HashMap" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.FileItem" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext" %>
<%@ page import="java.io.File" %>
<% String identificacion = request.getParameter("identificacion");
    Persona persona = null;

    if (identificacion != null && !identificacion.isEmpty()) {
        persona = new Persona(identificacion);
    }%>

<!DOCTYPE html>
<%@ include file="menu.jsp" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historia Laboral Green Activos</title>
        <link rel="stylesheet" href="presentacion/style-historiaLGreen.css">
    </head>
    <body>
        <div class="content">
            <div class="container">
                <h1>HISTORIA LABORAL APRENDIZ</h1>
                <!-- Datos Laborales -->

                <div class="section">
                    <input type="text" value="<%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() : ""%>" class="nombre" readonly>
                </div>

                <div class="section">
                    <h3 class="titulo-seccion">DATOS DEL COLABORADOR </h3>
                    <div class="input-group">
                        <div class="campo">
                            <label>Documento de identificación</label>
                            <input type="text" class="campo-mediano" value="<%= (persona != null) ? persona.getIdentificacion() : ""%>" readonly>
                        </div>
                        <div class="campo">
                            <label>Centro de costos</label>
                            <input type="text" class="campo-mediano" value="<%= (persona != null) ? persona.getCentroCostos() : ""%>" readonly>
                        </div>
                        <div class="campo">
                            <label>Establecimiento</label>
                            <input type="text" class="campo-pequeno" value="<%= (persona != null) ? persona.getEstablecimiento() : ""%>" readonly>
                        </div>
                        <div class="campo">
                            <label>Celular</label>
                            <input type="text" class="campo-pequeno" value="<%= (persona != null) ? persona.getCelular() : ""%>" readonly>
                        </div>
                        <div class="campo">
                            <label>Fecha de inicio del contrato</label>
                            <input type="text" class="campo-mediano" value="<%= (persona != null) ? persona.getFechaIngreso() : ""%>" readonly>
                        </div>
                    </div>
                </div>

                <!-- Datos Personales -->
                <div class="section">
                    <h3 class="titulo-seccion">DOCUMENTOS</h3>

                    <div class="data-grid"> 
                        <div class="data-item">
                            <span>DOCUMENTO DE IDENTIDAD</span>
                            <button class="ver-btn" onclick="window.location.href = 'detalleHistoria.jsp?identificacion=<%= identificacion%>&tipo=documentoIdentidad'">VER</button>
                        </div>

                        <div class="data-item">
                            <span>HOJA DE VIDA</span>
                            <button class="ver-btn" onclick="window.location.href = 'verHojaDeVida.jsp?identificacion=<%= identificacion%>'">VER</button>
                        </div>

                        <div class="data-item">
                            <span>DOCUMENTOS CONTRATACIÓN</span>
                            <button class="ver-btn" onclick="window.location.href = 'verDocumentosContratacion.jsp?identificacion=<%= identificacion%>'">VER</button>
                        </div>

                        <div class="data-item">
                            <span>AFILIACIONES</span>
                            <button class="ver-btn" onclick="window.location.href = 'verAfiliacionesAprendiz.jsp?identificacion=<%= identificacion%>'">VER</button>
                        </div>

                    </div>


                    <div class="buttons">
                        <a href="aprendiz.jsp" class="btn-volver">VOLVER</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
